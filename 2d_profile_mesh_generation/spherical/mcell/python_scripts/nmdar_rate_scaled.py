import math
import re

A_psd = 100 # VARIABLE the area of the post-synaptic density (um^2)
n_NMDAR = 1 # number of receptors (receptors)
Beta = 85 # coefficient (unitless)

G0 = 65.6 # limiting conductance for low [Ca] (pS)
g_Inf = 15.2 # limiting conductance for high [Ca] (pS)
h = 11.3 # coefficient for how fast limiting cases are reached (pS/mM)
r = 0.5 # scaling factor (unitless)
Ca2_EC = 2 # extracellular concentration, assumed constant (mM) (TODO: make sure it's constant) 
n0 = r * Ca2_EC # number based on EC [Ca2+]
zeta_i = (G0 + (n0*h) ) / (1 + ( (n0*h) / g_Inf ) )
#G_NMDAR = (zeta_i * 10e19) / ( (2 * 1.602)  ) # conductance of NMDAR (moles / V*s ??) TODO: make sure the weird bracket thing is just units
G_NMDAR = (zeta_i * 1e19) / ( (2 * 1.602) * 1e12) #divide by 1e12 because pS

Km = 0.092 # part of B(V) (mV^-1)
Mg = 1 # concentration of Mg, part of B(V), constant (mM)
Mg_scale = 3.57 # scaling factor, part of B(V) (mM)
def B(V):
	num = 1 + math.pow(math.e, -1 * Km * V) * (Mg/Mg_scale)
	return (1 / num)

P0 = 0.5 # probability coefficient (unitless)
I_f = 0.5 # scaling factor (unitless)
I_s = 0.5 # scaling factor (unitless)
T_f = 50 # ms
T_s = 200 # ms
V_r = 90 # reference voltage or something? (mV)
def gamma_i(t, V):
	#num = P0 * G_NMDAR * B(V) * (V - V_r) TODO: the time exponential thing is almost equal to 1 most of the time; should it be included or not?
	num = P0 * G_NMDAR * (I_f * math.pow(math.e, -1 * t / T_f) + I_s * math.pow(math.e, -1 * t / T_s)) * B(V) * (V - V_r)
	return num / 50

N_A = 6.022e23
N_F = 96485

def J_NMDAR(t, V):
	num = gamma_i(t, V) * n_NMDAR / (Beta * A_psd)
	return num

DT, ms_scale = 0, 0
outfile = open("nmdar_rate_scaled.txt", "w+")
with open("v_m.txt") as infile: #TODO
	for line in infile:
		group = re.split("  ", line)
		#print(float(group[0]), float(group[1]))
		t = group[0]
		V = group[1]
		if DT == 0:
			DT = float(t)
			ms_scale = (1e-3) / DT
		outfile.write(t + "  " + str(abs(0.002 * gamma_i(ms_scale * float(t), float(V)))) + "\n")
