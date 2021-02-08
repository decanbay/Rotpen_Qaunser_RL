# -*- coding: utf-8 -*-

import numpy as np
import gym
import time
from stable_baselines3 import PPO, A2C, DQN
from stable_baselines3.common.vec_env import DummyVecEnv, SubprocVecEnv
from stable_baselines3.common.utils import set_random_seed
from stable_baselines3.common.evaluation import evaluate_policy
from stable_baselines3.common.env_util import make_vec_env
import argparse
from quanser_robots import GentlyTerminating

alg_dict = {'PPO':PPO, 'A2C':A2C, 'DQN':DQN}

# env = RotpenSwingupSparseEnv()

from typing import Callable

def make_env(rank: int, seed: int = 0) -> Callable:
    """
    Utility function for multiprocessed env.
    
    :param env_id: (str) the environment ID
    :param num_env: (int) the number of environment you wish to have in subprocesses
    :param seed: (int) the inital seed for RNG
    :param rank: (int) index of the subprocess
    :return: (Callable)
    """
    def _init() -> gym.Env:
        env = GentlyTerminating(gym.make('Rotpen-100-v0'))
        env.seed(seed + rank)
        return env
    set_random_seed(seed)
    return _init

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description = 'Pass your arguments')
    parser.add_argument('--alg', type = str, default = 'A2C')
    parser.add_argument('--num_cpu', type = int, default = 12)
    args = parser.parse_args()
    print(args)
    num_cpu = args.num_cpu  # Number of processes to use
    # Create the vectorized environment
    alg = args.alg
    if alg=='DQN':
        num_cpu=1
        device='cuda'
    if num_cpu ==1:
        print('Num_CPU = 1')
        envs = GentlyTerminating(gym.make('Rotpen-100-v0'))
    else:
        envs = SubprocVecEnv([make_env(i) for i in range(num_cpu)])
        device = 'cpu'
    # model = A2C('MlpPolicy', env, verbose=0)
    alg2 = alg_dict[alg]

    print(alg2)
    model = alg2('MlpPolicy', envs, verbose=1,device=device)
    s_time = time.time()
    total_timesteps=num_cpu*2048*100
    model.learn(total_timesteps=total_timesteps)
    t_time = time.time()-s_time
    print('Totoal time passed = {} seconds'.format(t_time))
    print('{} it/sec'.format(total_timesteps/t_time))
    time.sleep(1)
    fname = 'rotpen_'+ alg
    model.save(fname)

    time.sleep(1)
    test_env = GentlyTerminating(gym.make('Rotpen-100-v0'))
    obs = test_env.reset()
    for i in range(2500):
        action, _states = model.predict(obs, deterministic=True)
        obs, reward, done, info = test_env.step(action)
        test_env.render()
        if i%250==0:
            print(i)
        if done:
            print('Done')
            obs = test_env.reset()
    test_env.close()