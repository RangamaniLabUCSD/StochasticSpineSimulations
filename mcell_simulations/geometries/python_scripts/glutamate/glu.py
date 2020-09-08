import re
import math

max_conc = 0.2e-3 #1.1e-3 #M, maximum initial concentration of glutamate in synapse
t_decay = 0.2 #1.2 #ms, time decay constant of glutamate (simple exponential decay)

times = []
with open('../v_m.txt') as infile:
	for line in infile:
		group = re.split('  ', line)
		times.append(group[0])

outfile = open('glu.txt', 'w+')
for time in times:
	conc = max_conc * math.pow(math.e, -1 * 1e3 * float(time) / t_decay)
	outfile.write(time + '  ' + str(conc) + '\n')
