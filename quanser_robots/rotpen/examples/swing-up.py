"""
The minimal program that shows the basic control loop on the simulated swing-up.
"""

import gym
from quanser_robots import GentlyTerminating
from quanser_robots.qube import SwingUpCtrl
import numpy as np
env = GentlyTerminating(gym.make('Rotpen-250-v0'))
env = gym.make('Qube-250-v0')


# ctrl = SwingUpCtrl()
# obs = env.reset()
# done = False
# while not done:
#     env.render()
#     act = ctrl(obs)
#     obs, _, done, _ = env.step(act)

# env.close()
obs = env.reset()
done = False
while not done:
    act = input("Next act:\n")
    for i in range(10):
        obs, reward, done, _ = env.step(np.array([act],dtype=np.float32))
        env.render()
        print(reward)
        if done:
            print('Done')

env.close()


