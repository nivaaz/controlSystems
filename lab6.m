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
os = 0.01
ts = 1.5

G3rd = tf(79.78,[1  2.348  40.85 0])
zeta = -log(os)/(sqrt(pi^2+log(os)^2))
wn = 4/(ts*zeta)

% question 3
x = s^2 + 2*zeta*wn*s + wn^2 %ideal char eqn 

% impulse(t_fun, G3rd)
% legend on;
% poles of G3rd and 0
roots([1 2.348 40.85])
[A3rd, B3rd, C3rd, D3rd] = tf2ss(79.78,[1  2.348  40.85 0])

%poles ideal
p1 = -zeta*wn + wn*sqrt(1-zeta^2)*j
p2 = -zeta*wn - wn*sqrt(1-zeta^2)*j
p3 = 50*real(p2)

a = [0 1 0; 0 0 1; 0 -40.85 -2.348];
b = [0; 0; 79.78];
c = [1 0 0];
d = 0
K = acker(a,b, [p1, p2, p3])
L =transpose(acker(A3rd',C3rd',[-20 -20 -20]))

dcgain(ss(a-b*K,b,c,d))

%G3 = 79.78/(s*(s*2 + 2.348*s + 40.85))

% 5
N = 1
[n, d] = ss2tf(A3rd, B3rd, C3rd, D3rd)

tf3rd = tf(n, d)
