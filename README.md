# Overview


# Set up 


# Robot Assembly


# Data



# Control System Modeling
- Aim to control the wave motion of the undulatory fin
- Employed a frequency-response-based modeling method
1. Using Fish's fin top view video data, run src\dataGenProc\multiObjectTracking.py to calculate the fin's each position in time
2. Run src\dataGenProc\GenerateBodedata.py to create bode plot with the processed video data
3. Run src\dataGenProc\EstimateTF.m in MATLAB to estimate Transfer Function from Bode Plot, and generate discrete time state space model
4. Design LQR gain, Kalman filter gain by running src\dataGenProc\ControllerDesign.m in MATLAB

# Testing Controller in Robotic Fish
1. Run src\controlSystem\realTimeTracking.py to track the tail point of the fin and send it to Arduino
2. Run src\controlSystem\discretecontroller\discretecontroller.ino in Aruino IDE and output motor sin wave frequency