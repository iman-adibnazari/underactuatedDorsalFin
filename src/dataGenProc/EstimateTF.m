clc, close all, clear all

%Loat BodePlot data (Python script made)
directory = 'C:\Users\super\Desktop\UCSD\랩인턴\Fish\underactuatedDorsalFin\data\processed\bodeplotdata\Lpt_BodePlotData.mat';
load(directory);

fhz=0.1; %first data frequency(Hz)
lhz=3; %last data frequency(Hz)
shz=0.1; %data step frequency(Hz)

mag = BodePlot(1,:);
phase = BodePlot(2,:);
freq = [fhz:shz:lhz]; %Hz
data = frd(mag.*exp(1j*phase*pi/180),freq*2*pi);

np = 3;
nz = 1;
% Estimate transfer function
sys_est= tfest(data,np,nz);

% Observable Canonical Form
A = [0 0 -sys_est.denominator(4); 1 0 -sys_est.denominator(3); 0 1 -sys_est.denominator(2)];
C = [0 0 1];
B = [sys_est.numerator(2); sys_est.numerator(1); 0];
D = 0;

%[A,B,C,D]=tf2ss(sys_est.numerator, sys_est.denominator); 
sys = ss(A,B,C,D);

h=bodeplot(sys_est,data);
setoptions(h,'FreqScale','linear','FreqUnits','Hz');
xlim([0 5]);


