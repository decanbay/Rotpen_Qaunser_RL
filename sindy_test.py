#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Feb 28 16:46:40 2021

@author: deniz
"""

import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
from scipy.integrate import odeint
from sklearn.linear_model import Lasso

import pysindy as ps
np.random.seed(100)



def pend(y, t, b, c):
    theta, omega = y
    dydt = [omega, -b*omega - c*np.sin(theta)]
    return dydt

b = 0.2
c = 9.807

y0 = [np.pi - 0.1, 0.0]

dt = .001

t_train = np.arange(0, 10, dt)
y0_train = [np.pi-0.1, 0.0]

x_train = odeint(pend, y0_train, t_train,args=(b, c))
obs_noise = np.ones_like(x_train)*np.random.randn()*0.001
x_train+=obs_noise
poly_order = 10
threshold = 0.0
model = ps.SINDy(optimizer=ps.STLSQ(threshold=threshold),feature_library=ps.PolynomialLibrary(degree=poly_order)) 
model.fit(x_train, t=dt)
model.print()

t_test = np.arange(0, 80, dt)

y0_test = [0.4, 0.05]
y_test = odeint(pend, y0_test, t_test,args=(b, c))
y_test_sim = model.simulate(y0_test, t_test)

plt.plot(y_test_sim[:,1],'r-', label='Sindy')
plt.plot(y_test[:,1],'b--', label='Real')
plt.legend()
plt.show()



