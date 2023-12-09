import numpy as np
import matplotlib.pyplot as plt

inputDataPathDir= "./data/processed/bodeplotdata/"
inputDataPath=inputDataPathDir+"Lpt_BodePlotData.npy"

BodeData = np.load(inputDataPath)   
i=0
for p in BodeData[1,:]:
    if p>=180:
        BodeData[1,i]-=360
    i+=1


plt.subplot(2,1,1)
plt.scatter(np.arange(0.1,3,0.1),BodeData[0,:])

plt.subplot(2,1,2)
plt.scatter(np.arange(0.1,3,0.1),BodeData[1,:])
plt.show()  



