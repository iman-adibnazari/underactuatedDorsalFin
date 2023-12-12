import numpy as np
import matplotlib.pyplot as plt
from scipy.io import savemat
from statistics import median

dfre=0.1
fre=np.arange(0.1,3+dfre,dfre)
fps=60
Mag=[]
Phi=[]
tol=0.01

saveMATLAB = True

#Path for input Data
inputDataPathDir= "./data/processed/"

#Path for output Data
outputDataPathDir= "./data/processed/bodeplotdata/"

#Amplitude, Phase of Transfer function
def AmpPha(f,fps,y_cln):
    framepTp=int(fps/f)
    if np.size(y_cln)%framepTp!=0:
        NumCycle=int(np.size(y_cln)/framepTp)+1
    else:
        NumCycle=int(np.size(y_cln)/framepTp)

    y_max=[]
    y_min=[]
    for i in range(0,NumCycle):
        if i<NumCycle-1:
            y_max.append(np.max(y_cln[i*framepTp:(i+1)*framepTp-1]))
            y_min.append(np.min(y_cln[i*framepTp:(i+1)*framepTp-1]))

        else:
            y_max.append(np.max(y_cln[(i)*framepTp:]))
            y_min.append(np.min(y_cln[(i)*framepTp:]))

    #Amplitude Calculate, Save
    y_max_1= np.sort(y_max)[len(y_max)//2]
    #median(y_max)
    y_min_1= np.sort(y_min)[len(y_min)//2]
    #median(y_min)
    fpt_amp=(y_max_1-y_min_1)/2

    #For Phase Calcuation, max/min index
    y_max_ind =np.argwhere(y_cln == y_max_1)[0,0]
    y_min_ind =np.argwhere(y_cln == y_min_1)[0,0]
    #y_max_ind =np.argwhere(np.abs(y_cln - y_max_1) <= (tol*y_max_1))[0,0]
    #y_min_ind =np.argwhere(np.abs(y_cln - y_min_1) <= (tol*y_max_1))[0,0]
    return fpt_amp,y_max_ind,y_min_ind


#Loop for Bode Plot
for f in fre:
    #Load input Data
    DataPath=inputDataPathDir+"{:.1f}Hz_CSRT.npy".format(f)
    FullData=np.load(DataPath)

    #Time array
    S=np.size(FullData, axis=0)
    time_end=S*1/fps
    time=np.arange(0,time_end,1/fps)

    #y coordinate
    fpt_y=FullData[:,0,1]
    lpt_y=FullData[:,1,1]

    #x,y coordinate truncation
    strtpt=int(S*0.3)
    endpt=int(S*0.8)
    fpt_y_cln=fpt_y[strtpt:endpt]
    lpt_y_cln=lpt_y[strtpt:endpt]
    t_cln=time[strtpt:endpt]
    plt.plot(fpt_y_cln)
    plt.plot(lpt_y_cln)
    #plt.show()

    #Find Magnitude,Phase of Bode plot
    (fpt_Amp,fpt_ymax_ind,fpt_ymin_ind)=AmpPha(f,fps,fpt_y_cln)
    (lpt_Amp,lpt_ymax_ind,lpt_ymin_ind)=AmpPha(f,fps,lpt_y_cln)
    print('%.1f Hz:'%f,"first point Amp",fpt_Amp,"/Last point Amp",lpt_Amp)
    Mag.append(lpt_Amp/fpt_Amp)
    Phi.append(np.mod(((fpt_ymax_ind-lpt_ymax_ind)/fps)*f*360,360))


BodePlot=np.row_stack((np.array(Mag), np.array(Phi)))
plt.subplot(2,1,1)
plt.scatter(np.arange(0.1,3+dfre,0.1),BodePlot[0,:])

plt.subplot(2,1,2)
plt.scatter(np.arange(0.1,3+dfre,0.1),BodePlot[1,:])
plt.show()
plt.title("Bode Plot")

#Save Data as a numpy,matlab file
np.save(outputDataPathDir+"Lpt_BodePlotData.npy",BodePlot)
if saveMATLAB:
    savemat(outputDataPathDir+"Lpt_BodePlotData.mat",{'BodePlot':BodePlot})