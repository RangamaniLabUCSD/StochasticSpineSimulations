function [t,y]= callsynapticWtsCon(ca)
close all;

tspan = 0:1e-6:0.035;
IC = 0;

[t,y] = ode23s(@(t,y)synapticWtsCon(t,y,ca,tspan), tspan, IC);

