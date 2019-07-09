
speedy = Speed(:, 2)
speedy_trunc = speedy(2000:9000)
plot(1:length(speedy_trunc), speedy_trunc-21)


%%
speedy = Speed(:, 2)
speedy_trunc = speedy(2000:9000)
plot(speedy_trunc)

%%%% Control systems prelab - 2

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
plot(y1, t)
plot(y2, t)
% these arent working?????
[y1 t] = step(3*theta_vm_s, 0.9)
[y2 t] = step(3*omgega_vm_s, 0.9)

%% Lab 2
f = 16;
lowp = tf(f, [1 f])

%% question 2 remove the ramp up
x_data = Speed(:, 3);
len_speed= length(x_data)
x_data = x_data(2000:len_speed);
t = Speed(:,1);
t = t(1:length(x_data));
plot(t, x_data, 'r')
ylim([0 80])
 xlabel("Time (sec)"); ylabel("Disc Speed (rpm)"); title("Speed Data");
 grid on;
%% question 3
 x_data_2 = x_data(1:8001);
 t_2 = t(1:length(x_data_2))
 plot(t_2, x_data_2-21.5, 'r');
ylim([0 60])
 xlabel("Time (sec)"); ylabel("Disc Speed (rpm)"); title("Truncated Speed Data");
 grid on;

%% voltage plot data
v_data = Voltage(:, 2);
len_v= length(v_data)

v_data = v_data(1000:len_v);

t = Speed(:,1);
t = t(1:length(v_data));

 x_data_2 = v_data(1000:9001);
 t_2 = t(1:length(x_data_2))
 plot(t_2, x_data_2-1, 'g');
ylim([0 3.5])
xlim([0 10])
 xlabel("Time (sec)"); ylabel("Disc Speed (rpm)"); title("Truncated Input Voltage Signa for modelling");
 grid on;
%% question 4 
kdc = 46.9/2
tau = 132*10^-3; %check!

%% questiomn 5 
kdc = 46.9/2;
tau = 132*10^-3; %check!
meas_tf = tf(kdc, [1 tau])
theta_vm_s = tf(Km, [Jeq*Lm Jeq*Rm Km*Kb 0])
omega_vm_s = tf(Km, [Jeq*Lm Jeq*Rm Km*Kb])

[y1, t1] = step(2*meas_tf, 0.9)
[y2, t2] = step(2*theta_vm_s)
[y3, t3] = step(2*omega_vm_s)

plot(t1, y1,t2,y2,t3, y3)
%% questionn 4
s = tf('s');
new_tf = 2*kdc/(s*tau+1)
[x1 t1] = step(new_tf, 0.9)
ylim([0 80])

[y1 t11] = step(3*theta_vm_s, 0.9)
[y2 t2] = step(3*omega_vm_s, 0.9)
plot(y1, t, y2, t,x1, t1)

%% q uestion 6
x_data = Speed(:, 3);
len_speed= length(x_data)
x_data = x_data(1000:len_speed);
Yact = x_data;

y_data = Speed(:, 4);
len_speed= length(y_data)
y_data = y_data(1000:len_speed);
Yact1 = y_data;

z_data = Speed(:, 5);
len_speed= length(z_data)
z_data = z_data(1000:len_speed);
Ysim = z_data;

clc
fit1 = (1-norm(Yact1-Ysim, 2)/norm(Yact1-mean(Yact1),2))*100
fit2 = (1-norm(Yact-Ysim, 2)/norm(Yact-mean(Yact),2))*100

