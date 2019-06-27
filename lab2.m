%% Control systems prelab - 2
clear
clc
% DC motor parameters

Rm = 8.4; %Ohm
Km = 0.042; %N.m/A
Kb = 0.042; %V/rad/s
Jm = 4*10^(-6); %Kg.m^2
Lm = 1.16e-3; %H

%Load hub parameters 
mh = 0.0106; %kg
rh = 0.0111; %m

%Load disk parameters 
md = 0.053; %kg 
rd = 0.0248; %m 

% Calculate moment of inertia for the disk and the hub
Jh = 1/2*mh*(rh^2); %kg-m^2
Jd = 1/2*md*(rd^2); %kg-m^2
Jeq = Jm+Jh+Jd; %kg-m^2

%% question 1 
syms theta_m theta Tm omega omega_m s
X = [theta_m, theta]

eqn1 = Jeq*s^2;

Vm = (Rm+Lm*s)/(Kb*omega_m);
Im = Vm/(Rm+Lm*s+Kb*omega_m);
%% question 2

syms Tm

y = [Tm 0];

% -Tm = @(s) theta(Jeq*s^2)
% Vm  = (Rm+Lm*s)/(Kb*omega_m);

%% question 3
% thigns cancel and can be approximated.

%% question 4
s = tf('s');
omega_vm = (Km/Rm)/(Jeq*s+(Km*Kb/Rm))

% omega_vm = dcgain(omega_vm)
% tau = pole(omega_vm)         % pole

Kdc = (Km/Rm)/(Km*Kb/Rm)        % dc gain
tau = (-Km*Kb/(Rm))/Jeq         % pole

%% question 5
theta_vm_s = tf(Km, [Jeq*Lm Jeq*Rm Km*Kb 0]);
omega_vm_s = tf(Km, [Jeq*Lm Jeq*Rm Km*Kb]);

dcgain(theta_vm_s)
theta_pole = pole(theta_vm_s)
theta_zero = zero(theta_vm_s)

dcgain(omega_vm_s)
omega_pole = pole(omega_vm_s)
omega_zero = zero(omega_vm_s)

%% question 6
figure;
hold on;
% these arent working?????
step(3*theta_vm_s, 0.9)
step(3*omgega_vm_s, 0.9)

%% Lab 2

f = 50;
lowp = tf(f, [1 f])

%% question 3 

x_data = Speed(:,2);
x_data = x_data(1:len_speed);
t = Speed(:,1);
t = t(1:length(x_data));

 x_data_2 = x_data(1000:10000);
 t_2 = t(1:length(x_data_2))
 plot(t_2, x_data_2, 'r');

 xlabel("Time (sec)"); ylabel("Disc Speed (rpm)"); title("Truncated Speed Data");
 grid on;

%%
