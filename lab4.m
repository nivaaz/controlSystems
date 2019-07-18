%% Question 1
s = tf('s');

kdc = 46.9/2;
tau = 132*10^-3;
ts = 0.35;
os = 0.03;

zeta = -log(os)/(sqrt(pi^2 + log(os)^2))
wn = 4/(zeta*ts)

kp = (2*zeta*wn*tau-1)/kdc
ki = wn^2*tau/kdc

zeta1 = (kp*kdc+1)/(2*sqrt(ki*kdc*tau))
wn1 = sqrt(kdc*ki/tau)
K = kdc*kp/tau
a = ki/kp
tf1 = K*(s+a)/(s^2 + 2*wn1*s*zeta1 + wn1^2)


% motor = Kdc/(tau*s+1);

figure
step(tf1*50);


%%


