%% lab 3
%% ##### 2DSFJ ROBOT SPECIFICATIONS #####
clc
% ***** Fisrt Joint (Shoulder)
% Harmonic drive #1 gear ratio
n = 100;

% Motor #1 torque constant at the harmonic drive #1 shaft output 
Km = 8.925; %(N.m/A)

% Equivalent Inertia of the loaded drive #1 system 
J1 = 0.06373091; %(kg.m^2)

% Equivalent Viscous Damping Coefficient as seen at the drive #1 output shaft 
B1 = 4.5; %(N.m.s/rad) 

% First Flexible Joint Torsional Stiffness 
Ks = 9; % (N.m/rad)

% First Flexible Joint Equivalent Inertia of the complete 
% serial link mechanism downstream obtained from CAD model
J2 = 0.23041858; %(kg.m^2)

% First Flexible Joint (with full load) Equivalent Viscous Damping Coefficient
% as seen at its rotation axis 
B2 = 0.070364;  %(N.m.s/rad)

% drive #1 maximum continuous current (A)
Im_MAX = 0.94;

% Specifications of a second-order low-pass filter (to obtain the angular speed)
wcf = 2 * pi * 40; % filter cutting frequency (rad/s)
zetaf = 0.9;        % filter damping ratio
% Motor and Link (#1 and #2) Encoder Resolution (before gear ratios) (rad/count)
K_ENC = 2 * pi / ( 4 * 1024 ); % = 0.0015 rad/count
% gear ratio to the flexible joint encoder (#1 and #2)
Kg_enc = 6.4;

syms s
syms Im

% ##### END OF 2DSFJ ROBOT SPECIFICATIONS #####
%% PRELAB QUESTION 1
syms theta_1 theta_2

Tm = Km*Im
YY = [theta_1; theta_2]
Y = [-Tm; 0]
a = [J1*s^2+Ks+B1*s -Ks;-Ks Ks+J2*s^2+B2*s^2] %%check this.

%% PRELAB QUESTION 2
A = [0 0 1 0;0 0 0 1;-Ks/J1 Ks/J1 -B1/J1 0;Ks/J2 -Ks/J2 0 -B2/J2]
B = [0; 0; Km/J1; 0]
C = [0 1 0 0]

%% PRELAB QUESTION 3
eig_A = eig(A)

%% PRELAB QUESTION 4
s = tf('s')
D = 0;
I = eye(4)%%check this.
[NUM, DEN] = ss2tf(A, B, C, D)
t_fun = tf(NUM, DEN)
%% PRELAB QUESTION 5
dcgain(t_fun)
pole(t_fun)
zero(t_fun)

%% LAB 3 QUESTION 1
mag_1 = 0.2 %input for the simulink!
t_len_1 = 0.5

new_ss = Matrix(mag_1*t_fun) %multipling by new mag voltage
%% 3
t = ShoulderData.time; theta1 = ShoulderData.signals(1).values(:,1); 
theta2 = ShoulderData.signals(1).values(:,2); 
theta1_dot = ShoulderData.signals(2).values(:,1); 
theta2_dot = ShoulderData.signals(2).values(:,2);
Im = InputCurrent(:,2); 

%% 
A_3 = [0 1 0;0 0 1; -0.1003 -47.2 -2.737];
B_3 = [0; 0; 93.54];
C_3 = 3;

A_4 = [0 0 0 0; 0 1 0 0; 0 0 1 0; -9.503 -3854 -265.4 -84.15]
B_4 = [0; 0 ;0; 755]
C_4 = 4;
