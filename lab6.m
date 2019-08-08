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
% dcgain(t_fun)
pole(t_fun)
% zero(t_fun)

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

%% LAB 6 prelab q1
Cm = [B A*B A*A*B A*A*A*B];
Om = [C; C*A; C*A*A; C*A*A*A];

if(4 == rank(Cm))
    fprintf("Controllable! Full rank! \n")
else
    fprintf("Not controllable")
end

if(4 == rank(Om))
    fprintf("Observavle! Full rank! \n")
else
    fprintf("Not observable")
end 

%% PRELAB question 2
close all;
s = tf('s')
G3rd = tf(79.78,[1  2.348  40.85 0])
impulse(t_fun, G3rd)
legend on;
% poles of G3rd and 0
roots([1 2.348 40.85])

a = [0 1 0; 0 0 1; -40.85 -2.348 1];
b = [0; 0; 79.78];
c = [0 1 0];
%% question 3
os = 0.01
zeta = -log(os)/(sqrt(pi^2+log(os)^2))
ts = 1.5
wn = 4/(ts*zeta)
%poles ideal
p1 = -zeta*wn + wn*sqrt(1-zeta^2)
p2 = -zeta*wn - wn*sqrt(1-zeta^2)

x = s^2 + 2*zeta*wn*s + wn^2 %ideal char eqn 
syms k1
syms k2
syms k3
syms s

%G3 = 79.78/(s*(s*2 + 2.348*s + 40.85))

K = [k1 k2 k3]
s*eye(3)-(a-b*K)
d = det(ans)
solve(x == d, s)

coeffs(d, s) %coeff of s in the det 

%% 4
% L =transpose(acker(A3rd',C3rd',[-20 -20 -20]))
zeta 
wn
x %char eqn 
syms l1
syms l2
L = [l1 l2]
% ex = (A-L*C)ex estimator error dynamics
dd = det(s*eye(3)-(A-L*C))
solve(dd == x, )

