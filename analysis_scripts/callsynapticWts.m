function [t,y]= callsynapticWts(ca)
close all;

tspan = 0:1e-6:0.035;
IC = 0;

[t,y] = ode23s(@(t,y)synapticWts(t,y,ca,tspan), tspan, IC);


% set(findall(gcf,'type','text'),'FontSize',32,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 32)
% set(findall(gca, 'Type', 'Line'),'LineWidth',5)
% figure
% plot(t,y)
% ylabel('Synaptic Weight (1)')
% xlabel('Time (s)');
% title('Synaptic weight')
% %legend('')
% set(findall(gcf,'type','text'),'FontSize',32,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 32)
% set(findall(gca, 'Type', 'Line'),'LineWidth',5)
