% Load system model from EstimateTF script
run("C:\Users\super\Desktop\UCSD\랩인턴\Fish\underactuatedDorsalFin\src\dataGenProc\EstimateTF.m")

% LQR controller
Q = [0.0001 0 0; 0 0.0001 0; 0 0 1000];
R = .01;
[K,S,P] = lqr(sys,Q,R);
