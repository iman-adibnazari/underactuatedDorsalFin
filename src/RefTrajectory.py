import numpy as np
import matplotlib.pyplot as plt

def genref(t,npts=50, A=1, L=30, k=10, w=1, x_shift=0,y_shift=0):
    x=np.linspace(0,L,npts)
    y=np.sin(k/L*x-w*t)
    return x+x_shift,y+y_shift

t=0
L=30
x,y=genref(t,L)
plt.scatter(x,y,color='yellow')
plt.xlim(0,L)
plt.show()
