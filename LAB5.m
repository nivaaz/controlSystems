%% CONTROL 2019 LAB 5
s = tf('s')
% prelab question 1
Kdc = 22.6;
tau =0.12;
OS = 0.01
Tp = 0.27;

zeta = -log(OS)/(sqrt(pi^2+log(OS)^2))
wn = pi/(Tp*sqrt(1-zeta^2))

pole1 = zeta*wn - wn*sqrt(1-zeta^2) 
pole2 = zeta*wn + wn*sqrt(1-zeta^2) 
%% prelab question 2
propD = Kp+Kd*s
propI = Kdc/(s*(tau*s+1))

G = propD*propI %open loop tf

tf_closed = G/(1+G) %cloed loop tf

%from lecture slides 
Kd = (pole1+pole2 - 2*zeta*wn)/K
Kp = (pole1*pole2-wn^2)/Kdc
%% prelab question 3
theta_ref = 60;

%% question 4
% % Kp - increases wn, zeta dddrops leads to a higher overshoot.
% Tp is reduced 
% fatser transient response 
% Ts is about the same

% Kd - increases zeta
% less overshoot
% Ts is reduced 
% Tp is slightly increased

%% question 5
%tp
%os

%% LAB

%%question 1
%os = steady state - peak /steasy state
Os_1 = 1;

%% question 3

%% question 4

%% question 5
Ki = 0.2
%% question 6

%% question 7
