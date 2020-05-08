import math
import re

a_ = [8.08, 13.4, 8.78, 34.7] #ms, scaling factor in forward exponential
b_ = [5.76, 12.6, 16.3, 3.68] #ms, scaling factor in reverse exponential
V_ = [49.14, 42.08, 55.31, 26.55] #mV, scaling factor in exponential rates

def rate(a_b, V_i, V):
    return ( 1000 * a_b * math.pow(math.e, V / V_i) )

for i in range(4):
    onfile = open("vscc_" + str(i + 1) + "_forward_scaled.txt", "w+")
    offfile = open("vscc_" + str(i + 1) + "_reverse_scaled.txt", "w+")
    with open("v_m.txt") as infile:
        for line in infile:
            group = re.split("  ", line)
            t = group[0]
            V_m = group[1]
            onfile.write(t + "  " + str(rate(a_[i], V_[i], float(V_m))) + "\n")
            offfile.write(t + "  " + str(rate(b_[i], V_[i], float(V_m))) + "\n")
