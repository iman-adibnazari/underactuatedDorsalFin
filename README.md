## Overview
- Proposing an efficient fish robot design where, leveraging the physical properties of the dorsal fin material, only the front part of the fin is motor-driven to initiate wave propagation
- Design a linear quadratic regulator(LQR) and feedforward controller to manage the movement of the fish's fin

## Set up
Install necessary packages listed in requirements.txt:
`$ pip install -r requirements.txt`

## Robot Assembly
![Schemetic view of robotic fish](RoboticFish.png)
1. Laser-cut acrylic fin ray, fish body acrylic Frame, Fiberglass Panel
```
cad\Fish\FinRay.SLDPRT
cad\Fish\Body2.SLDPRT
cad\Fish\FIN.SLDPRT
```
2. Build silicone fin using 3D printed mold embedded with FR4 and fin ray 
```
cad\Fin Silicone Mold\Fin_mold_assemble.SLDASM
```
3. 3D printing PLA Head Closure 
```
cad\Fish\Body1_L.SLDPRT
cad\Fish\Body1_R.SLDPRT
```
4. Assemble 
- Mount dowel pin, Savox SW0250MGP motor with left Head Closure
- Attach fin with acrylic body frame
- Combine left head closure and acrylic body frame with fin 

## Data


## Control System Modeling
![Propulsion of wave through dorsal fin](undulatoryfin_s.mp4)
Goal: Aim to control the wave motion of the undulatory dorsal fin of robotic fish
Approach: Employing a frequency-response-based control system modeling method
1. Use top-view video data of the fish's fin, run `src\dataGenProc\multiObjectTracking.py` to calculate each position of the fin over time
2. Run `src\dataGenProc\GenerateBodedata.py` to create Bode plot using the processed video data
3. Run `src\dataGenProc\EstimateTF.m` in MATLAB to estimate Transfer Function from Bode plot, and generate discrete time state-space model
4. Design LQR gain, Kalman filter gain by running `src\dataGenProc\ControllerDesign.m` in MATLAB

## Testing Controller in Robotic Fish
1. Run `src\controlSystem\realTimeTracking.py` to track the tail point of the fin and send it to Arduino
2. Execute `src\controlSystem\discretecontroller\discretecontroller.ino` in Arduino IDE to output motor sine wave frequency