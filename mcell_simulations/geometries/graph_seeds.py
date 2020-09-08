#graphing the averaged results of multiple MCell test Hilbert Curve diffusion simulation seeds

import numpy as np
import matplotlib.pyplot as plt
import os
import re
import sys

#HILBERT = False

#if not HILBERT:
#    fileStarts = ["vm_base", "vm_circle_diff"]#, "vm_count_diff"]
#    files = os.listdir('react_data_base')   # build a list of reaction data file names
#else:
#    fileStarts = ["vm_hilbert", "vm_circle_diff_hilbert"]#, "vm_count_diff"]
#    files = os.listdir('react_data_hilbert')   # build a list of reaction data file names

#fileStarts = ["VSCC."]
#react_data_dir = "glu_react_data"

react_data_dir = sys.argv[1]
fileStarts = []
fileStarts.append(str(sys.argv[2]))
if(len(sys.argv)) >= 4:
    fileCounts = int(sys.argv[3])
else:
    fileCounts = 1e9
if(len(sys.argv)) == 5:
    fileStarts.append(str(sys.argv[4]))

files = []
files = os.listdir(react_data_dir)

files.sort()

keyDict = {
    fileStarts[0]: "r"
    #fileStarts[1]: "b"
}
    #"vm_count_diff": "g"
#}
xs = []

fig = plt.figure(1)
ax1 = fig.add_subplot(111)
ax1.set_xlabel("Time (ms)")

scaling = False
if fileStarts[0].startswith("Ca2"):
	ax1.set_ylabel("Ca2+ Molecules")#, color='r')
elif fileStarts[0].startswith("NMDAR."):
	ax1.set_ylabel("Activated NMDAR Count")
elif fileStarts[0].startswith("NMDAR_"):
	ax1.set_ylabel("Doubly-bound NMDAR Count")
elif fileStarts[0].startswith("VSCC"):
	ax1.set_ylabel("Activated VSCC Count")

fig = plt.figure(2)
ax2 = fig.add_subplot(111)
ax2.set_xlabel("Time (ms)")
ax2.set_ylabel("Variance (uM)")

#ax3 = ax1.twinx()
#ax3.set_ylabel("Membrane Voltage (mV)", color='b')

volume = (0.035) / (1e15) # convert from um^3 to L

scale = ( (1e6) / (6.022e23) ) / volume # to get concentration in uM

print(fileStarts)

seeds = []

mol_counts = []
i = 0
for fileStart in fileStarts:
    mol_counts.append(None)
    print(mol_counts)
    counter = 0
    print('itr: ', fileStart)

    for f in files:                    # iterate over the list of file names
        if f.startswith(fileStart) and counter < fileCounts:
            counter = counter + 1
            rxn_data = np.genfromtxt("./" + react_data_dir + "/%s" % f, dtype=float)
            
            xs = rxn_data[:,0]
            rxn_data = rxn_data[:, 1]  # take the second column
            #if i == 0:
                #seeds.append(rxn_data)#(xs*1000, rxn_data, '0.5')
                #ax1.plot(xs*1000, rxn_data, '0.5')  # plot the results as a gray line
            if mol_counts[i] is None:
                mol_counts[i] = rxn_data
            else:
                # built up 2d array of molecule counts (one col/seed)
                #print(mol_counts[i])
                mol_counts[i] = np.column_stack((mol_counts[i], rxn_data))
        else:
            pass
    i = i + 1

#mol_counts[0] = mol_counts[0] - mol_counts[1]

var_mol_counts = mol_counts[0].var(axis=1)
avg_mol_counts = mol_counts[0].mean(axis=1)  # take the mean of the rows
if len(mol_counts) == 2:
    avg_mol_counts2 = mol_counts[1].mean(axis=1)
#plt.plot(mol_counts, keyDict[fileStart])             # plot the results as a red line

'''
vs = []
counter=0
with open("python_scripts/v_m.txt") as infile: #TODO
    for line in infile:
        group = re.split("  ", line)
        #print(float(group[0]), float(group[1]))
        t = group[0]
        V = group[1]
        if counter == 0:
            vs.append(float(V))
            counter = counter + 1
        vs.append(float(V))
'''
#plt.ylim(0, 4)
#for seed in seeds:
#	ax1.plot(xs*1000, seed - avg_mol_counts2, "0.5")
ax1.plot(xs*1000, avg_mol_counts, "r")
#ax1.tick_params(axis='y', labelcolor='r')

ax2.set_ylim([0, 1000])
ax2.plot(xs*1000, var_mol_counts*scale, "r")
#ax2.plot(xs*1000, avg_mol_counts2, "b") 

#ax3.plot(xs*1000, vs, 'b')
#ax3.tick_params(axis='y', labelcolor='b')
#x = np.linspace(0, 5000, 100)
#y = np.zeros(100)
#plt.plot(x, y, 'g')

plt.show() 
