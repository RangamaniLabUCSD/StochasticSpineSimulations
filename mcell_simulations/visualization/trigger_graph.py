import matplotlib.pyplot as plt
import re
import numpy as np
import sys

INFILE = sys.argv[1]

#fig, axs = plt.subplots(2)

lists = []
with open(INFILE) as infile:
	for line in infile:
		group = re.split("  ", line)
		#print(group)
		list = []
		for val in group:
			if val != "\n":
				list.append(float(val))
		lists.append(list)

ts = lists[0]
lists.pop(0)

plt.figure(1)

for list in lists:
	plt.plot(ts, list, '0.5')

average = np.average(lists, axis=0)

derivlist = [0]
for i in range(len(average) - 1):
	derivlist.append( (average[i + 1] - average[i]) / (ts[i + 1] - ts[i]) )

#derivlists = []
#for i in range(len(lists)):
#	derivlists.append([0])
#	for j in range(len(lists[i]) - 1):
#		derivlists[i].append( (lists[i][j + 1] - lists[i][j]) / (ts[j + 1] - ts[j]) )

plt.plot(ts, average, color='red', linewidth=3)

plt.figure(2)

#for derivlist in derivlists:
#	plt.plot(ts, derivlist)

#deriv_average = np.average(derivlists, axis=0)

#plt.plot(ts, deriv_average)

plt.plot(ts, derivlist)

plt.show()

