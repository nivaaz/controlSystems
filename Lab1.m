load('C:\Users\nkseh\OneDrive\Documents\Uni-Vazzy\Control 2019\PreLab1_Data.mat')
clc;
close all;
len_speed = length(discSpeed)

x_data = discSpeed(:,2);
x_data = x_data(1:len_speed);
t = discSpeed(:,1);
t = t(1:length(x_data));

%% first plot
subplot(2, 1, 1);
plot(discSpeed(:,1), discSpeed(:,2), 'r');
xlabel("Time (sec)"); ylabel("Disc Speed (rpm)"); title("Measured Speed Data");
grid on;

%second plot
 subplot(2, 1, 2);
 x_data_2 = x_data(1000:10000);
 t_2 = t(1:length(x_data_2))
 plot(t_2, x_data_2, 'r');
 ylim([0 800]); xlim([0 10]);
 xlabel("Time (sec)"); ylabel("Disc Speed (rpm)"); title("Truncated Speed Data");
 grid on;
%% QUESTION 3
% OFFEST REMOVAL
clc
dc_offset = 200;
x_data_3 = x_data_2 - dc_offset;
t_3 = t_2;

f1 = figure;
subplot(2, 1, 1);
plot(t_3, x_data_3, 'r');
 ylim([0 800]); xlim([0 10]);
 xlabel("Time (sec)"); ylabel("Disc Speed (rpm)"); title("Offset-free Speed Data");
 grid on;
 
%% QUESTION 4
x_data_4 = x_data_3(1000:length(t_3));
t_4 = t_3(1:length(x_data_4));

 subplot(2, 1, 2);
plot(t_4, x_data_4, 'r');
 ylim([0 500]); xlim([0 10]);
 xlabel("Time (sec)"); ylabel("Disc Speed (rpm)"); title("Truncated offset-free Speed Data");
 grid on;

 %%     low pass filter
clc
close all
 x_fft = fft(x_data_4);
 x_plot_5 = abs(log(x_fft))
 plot(x_plot_5);
%10k Hz is the frequency 

w = 2*pi*10000;
 %%
%x_pass = lowpass(x_data, 2*pi*10000, fs)

 x_pass = lowpass(x_data_4, 0.01);
% x_pass = lowpass(x_data_4, 0.01);
plot(t(1:length(x_data_4)), x_pass);
 ylim([0 800]); xlim([0 8]);
 xlabel("Time (sec)"); ylabel("Disc Speed (rpm)"); title("Filterd & Truncated offset-free Speed Data");


%%  LAB 1
%
%
%
%
% 
clc
clear

syms s  t                           %symbol.
Km = 5; J = 1 ;L = 1e-3;           %constants 
R = 1; B=20;  Ka = 10;

H = @(s) 1
G  = @(s) Km/(s*(J*s+B)*(L*s+R)) %function of s
G_s = (Km/(s*(J*s+B)*(L*s+R)));

num_g = Km;                      %numerator 
denom_g = [J*L B*L+J*R B*R 0];   %denominator 
G_tf = tf(num_g, denom_g)        %make a transfer function 

G_poles = pole(G_s)               %poles
[G_zeros, G_gain] = zero(G_s)     %gain & zeros.

r_s = 1/s;                      %step response
Y_s = r_s * G_s;                %input* openloop.
Y_t = @(t) ilaplace(Y_s, t)     %laplace transform & response
%%question 2
G_step = step(G_tf,3, 'r');     %step response of G(s) in s domain.
%% question 3
G_3 = G_step(length(G_step));   %value at 3 seconds.

%% Question 4

%I would assume the amplitude would saturate at some point, 
% how ever, it doesnt seem like it from the graph at hand.
% the graph doesn't reach steasy state

%% question 5 - not done.
G_s = (Km/(s*(J*s+B)*(L*s+R)));
T_s = @(K_a) K_a*G_s*H/(1+K_a*G_s*H)                %input* openloop.

Ka_10 = T_s(10);
Ka_19 = T_s(19.8);
Ka_40 = T_s(40);
Ka2 = 19.8;


%%
%%  LAB 1

clc
clear

syms s  t                           %symbol.
Km = 5; J = 1 ;L = 1e-3;           %constants 
R = 1; B=20;  Ka = 10;

H = @(s) 1
G  = @(s) Km/(s*(J*s+B)*(L*s+R)) %function of s
G_s = (Km/(s*(J*s+B)*(L*s+R)));

num_g = Km;                      %numerator 
denom_g = [J*L B*L+J*R B*R 0];   %denominator 
G_tf = tf(num_g, denom_g)        %make a transfer function 

%%question 2
G_poles = poles(G_s, s)               %poles
[G_zeros, G_gain] = zero(G_tf)     %gain & zeros.

step(G_tf,3)
%% Question 3 - repsonse @ t=3

G_3 = step(G_tf,3);
G_3(length(G_3))

%% something???
r_s = 1/s;                      %step response
Y_s = r_s * G_s;                %input* openloop.
Y_t = @(t) ilaplace(Y_s, t)     %laplace transform & response

%%
%step response of G(s) in s domain.

G_3 = plot(G_step(length(G_step)))   %value at 3 seconds.

%% Question 4

%I would assume the amplitude would saturate at some point, 
% how ever, it doesnt seem like it from the graph at hand.
% the graph doesn't reach steasy state
step(G_tf,100) % doesnt seem to be saturating!!

%% question 5 - not done.
s=tf('s')
H=1;
Km = 5; J = 1 ;L = 1e-3;           %constants 
R = 1; B=20;  
G_s = (Km/(s*(J*s+B)*(L*s+R)));
K_a = [10 19.8 40]               %input* openloop.

% Ka_10 = T_s(10)
% Ka_19 = T_s(19.8)
% Ka_40 = T_s(40)
T_s1 = K_a(1)*G_s*H/(1+K_a(1)*G_s*H) 
T_s2 = K_a(2)*G_s*H/(1+K_a(2)*G_s*H)
T_s3 = K_a(3)*G_s*H/(1+K_a(3)*G_s*H)

%% questin 6
pole(T_s1)
[z, g] = zero(T_s1)
%%
pole(T_s2)
[z, g] = zero(T_s2)
%%
pole(T_s3)
[z, g] = zero(T_s3)

%% question 7
% units are in radians, so you would use radians unless you included a rad to degree conversion 

%% question 8 
r = degtorad(5.73);

figure;
hold on;
step(r*T_s1, 2)
step(r*T_s2, 2)
step(r*T_s3, 2)

%% question 9
% criical 19.8
% overdamped 40 
% under is 10

%% question 10 
% under performing one 

%%
