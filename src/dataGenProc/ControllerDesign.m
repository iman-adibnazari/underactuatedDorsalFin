clc, close all, clear all;
% Load system model from EstimateTF script
run("C:\Users\super\Desktop\UCSD\랩인턴\Fish\underactuatedDorsalFin\src\dataGenProc\EstimateTF.m")

%% LQR gain 
Q = [0.0001 0 0; 0 0.0001 0; 0 0 1000];
R = .01;
[K,S,P] = lqr(sys,Q,R);
[Kd,Sd,Pd] = lqr(sysd,Q,R);
fprintf(fileID,'BLA::Matrix<1, 3> Kl={%5.4f, %5.4f, %5.4f};\r\n',Kd);



%% Kalman filter
Qe = 1;
Re = 1;
[Kf,L,Pf]=kalman(sys,Qe,Re);
[Kfd,Ld,Pfd]=kalman(sysd,Qe,Re);
fprintf(fileID,'BLA::Matrix<3, 1> L={%5.4f, %5.4f, %5.4f};\r\n',Ld);

