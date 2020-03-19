import math
import re

N_A = 6.022e23 # avogadro's number (ions/mol)
A_membrane = 1 # VARIABLE area of the membrane (um^2)
gamma = 3.72 # conductivity of VSCC (pS)
F = 96485.3322 # Faraday's number (C/mol)
def k_Ca2(V_m):
	num = (1e-12) * gamma * V_m * N_A * (0.393 - math.pow(math.e, -1 * V_m \
		/ 80.36)) / (2 * F * (1 - math.pow(math.e, V_m / 80.36)))
	return num / 4 # using 20 VSCCs instead of 5

# TODO: is final rate multiplied by the time biexponential or not?

alpha_4 = 34.7 # biexponential coefficient term (ms^-1)
beta_4 = 3.68 # biexponential coefficient term (ms^-1)
VSCC = 2/(6.022e23) # VSCC area molarity (mol/um^2)
def J_VSCC(t, V_m):
	num = k_Ca2(V_m) * VSCC * (math.pow(math.e, -1 * alpha_4 * t) - \
		math.pow(math.e, -1 * beta_4 * t))
	return num

outfile = open("vscc_rate_scaled.txt", "w+")
with open("v_m.txt") as infile:
    for line in infile:
        group = re.split("  ", line)
        t = group[0]
        V_m = group[1]
        #outfile.write(t + "  " + str(0.002 * k_Ca2(float(V_m))) + "\n")
        outfile.write(t + "  " + str(0.002 * abs(k_Ca2(float(V_m)) * (math.pow(math.e, -1 * alpha_4 * float(t) * 1000) - math.pow(math.e, -1 * beta_4 * float(t) * 1000))) ) + "\n")
