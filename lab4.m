    
%% Question 1
s = tf('s');

Kdc_Iden = 46.9/2;
tau_Iden = 132*10^-3;
ts = 0.35;
os = 0.03;

zeta = -log(os)/(sqrt(pi^2 + log(os)^2))
wn = 4/(zeta*ts)

Kp = (2*zeta*wn*tau_Iden-1)/Kdc_Iden
Ki = wn^2*tau_Iden/Kdc_Iden

zeta1 = (Kp*Kdc_Iden+1)/(2*sqrt(Ki*Kdc_Iden*tau_Iden))
wn1 = sqrt(Kdc_Iden*Ki/tau_Iden)
K = Kdc_Iden*Kp/tau_Iden
a = Ki/Kp
tf1 = K*(s+a)/(s^2 + 2*wn1*s*zeta1 + wn1^2)


% motor = Kdc/(tau*s+1);

figure
step(tf1*50);


%%
