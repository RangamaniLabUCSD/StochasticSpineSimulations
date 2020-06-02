NUM_TIMESTEPS = 10000
DT = 1e-6

import math

V_rest = -65 # resting membrane voltage (mV)

BPAP_max = 38 # maximum back-propogating action potential (mV)
tdelaybp = 2 # bpap delay time (ms)
I_bsf = 0.75 # scaling constant (unitless)
I_bss = 0.25 # scaling constant (unitless)
t_bsf = 3 # time coefficient (ms)
t_bss = 25 # time coefficient (ms)
def BPAP(t):
	num = BPAP_max * (I_bsf * math.pow(math.e, -1 * (t - tdelaybp) / t_bsf) + \
		I_bss * math.pow(math.e, -1 * (t - tdelaybp) / t_bss))
	return num

s_term = 25 # (mV)
tdelay = 0 # no delay for epsp (ms)
tep1 = 50 # time coefficient (ms)
tep2 = 5 # time coefficient (ms)
def EPSP(t):
	num = s_term * (math.pow(math.e, -1 * (t - tdelay) / tep1) - \
		math.pow(math.e, -1 * (t - tdelay) / tep2))
	return num

file = open("v_m.txt", "w+")

for i in range(NUM_TIMESTEPS):
    time = (i + 1) / math.pow(DT, -1) #/ 1000000 #timestep 1e-6
    line = str(time) + "  " + str(V_rest + BPAP(time * 1000) + EPSP(time * 1000)) + "\n"
    file.write(line)
