import numpy as np
import gym
from stable_baselines3 import PPO,A2C
import time
from stable_baselines3.common.evaluation import evaluate_policy
from quanser_robots import GentlyTerminating



env = gym.make('Rotpen-100-v0')
env.reset() 
for i in range(5000):
    env.step(np.array([50*np.sin(i*0.1)],dtype=np.float32))
    env.render()
    
env.close()



