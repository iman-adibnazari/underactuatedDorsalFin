# Overview


# Set up 


# Robot Assembly


# Control System Modeling
    1. Using Fish's fin top view video data, run multiObjectTracking.py to calculate the fin's each position in time
    2. Run GenerateBodedata.py to create bode plot with the processed video data
    3. Run EstimateTF.m in MATLAB to estimate Transfer Function from Bode Plot, and generate discrete time state space model
    4. Design LQR controllers, Kalman filter gain by running ControllerDesign.m in MATLAB
    5. 



# Data 
