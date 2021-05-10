function dydt= synapticWtsCon(t,y,ca,tv)


dydt=zeros(1,1);

w= y(1);

% cat = linspace(0,0.5e-7,0.035);
% caf = ca(t);
ca_inter = interp1(tv(:),ca(:),t);
Avo = 6.0233e23;
volCon = 0.09;
molum3touM = 1e15*1e6;

theta_P = 400*molum3touM/(Avo*volCon); %converted 400 ions to uM
theta_D = 100*molum3touM/(Avo*volCon);%2e-3*6.022e23*0.05578*1e-18; %67
beta_P = 60/(molum3touM/(Avo*volCon)); %0.2977
beta_D = 60/(molum3touM/(Avo*volCon)); %0.2977

tau_w = 1 + 10/(0.001 + ((2*ca_inter)/(theta_D + theta_P))^2);
%Shouval tau
%tau_w = 1 + 0.1/((0.1/1e-4) + (ca_inter)^3);

omega_w = (1/(1+exp(-beta_P*(ca_inter - theta_P))))-(0.5/(1+exp(-beta_D*(ca_inter - theta_D))));

dydt(1) = (-w + omega_w)/tau_w; 
