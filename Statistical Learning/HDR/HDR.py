# -*- coding: utf-8 -*-
"""
Created on Wed Jul 22 18:20:06 2015

@author: MSPRL-6
"""
import numpy as np
import numpy.setup as sli

dir('numpy')
#data = sio.loadmat('HDR.mat')
#X=data['data']
def main():
    print(sli.__name__)
main()
a=[[1, 2], [1, 2]]
np.dot(a,a)
np.array(range(10)) * (np.array(range(10))) 