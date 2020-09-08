import math
import re

times = []
concs = []
with open('glu.txt') as infile:
	for line in infile:
		group = re.split('  ', line)
		time = group[0]
		conc = group[1]
		concs.append(float(conc))
		times.append(time)

kc0f = 2e7
kc1f = 1e7

c0f = open('C0-C1_forward.txt', 'w+')
c1f = open('C1-C2_forward.txt', 'w+')

for i in range(len(times)):
	c0f.write(times[i] + '  ' + str(kc0f * concs[i]) + '\n')
	c1f.write(times[i] + '  ' + str(kc1f * concs[i]) + '\n')

vs = []
with open('../v_m.txt') as infile:
	for line in infile:
		group = re.split('  ', line)
		vs.append(float(group[1]))

k_b = open('k_B_rate.txt', 'w+')
k_u = open('k_U_rate.txt', 'w+')

for i in range(len(times)):
	k_b.write(times[i] + '  ' + str(1200*math.pow(math.e, -1 * vs[i] / 17)) + '\n')
	k_u.write(times[i] + '  ' + str(10800*math.pow(math.e, vs[i] / 47)) + '\n')

