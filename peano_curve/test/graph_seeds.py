#graphing the averaged results of multiple MCell test Hilbert Curve diffusion simulation seeds

import numpy as np
import matplotlib.pyplot as plt
import os

HILBERT = False

if not HILBERT:
    fileStarts = ["vm_base", "vm_circle_diff"]#, "vm_count_diff"]
    files = os.listdir('react_data_base')   # build a list of reaction data file names
else:
    fileStarts = ["vm_hilbert", "vm_circle_diff_hilbert"]#, "vm_count_diff"]
    files = os.listdir('react_data_hilbert')   # build a list of reaction data file names

files.sort()

keyDict = {
    fileStarts[0]: "r",
    fileStarts[1]: "b"
}
    #"vm_count_diff": "g"
#}

for fileStart in fileStarts:
    mol_counts = None

    for f in files:                    # iterate over the list of file names
        if f.startswith(fileStart):
            rxn_data = np.genfromtxt("./react_data/%s" % f, dtype=float)
            rxn_data = rxn_data[:, 1]  # take the second column
            plt.plot(rxn_data, '0.5')  # plot the results as a gray line
            if mol_counts is None:
                mol_counts = rxn_data
            else:
                # built up 2d array of molecule counts (one col/seed)
                mol_counts = np.column_stack((mol_counts, rxn_data))
        else:
            pass

    mol_counts = mol_counts.mean(axis=1)  # take the mean of the rows
    plt.plot(mol_counts, keyDict[fileStart])             # plot the results as a red line

x = np.linspace(0, 5000, 100)
y = np.zeros(100)
plt.plot(x, y, 'g')

plt.show() 
