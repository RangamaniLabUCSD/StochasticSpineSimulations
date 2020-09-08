import matplotlib.pyplot as plt
import numpy as np

rxn_data = np.genfromtxt("react_data/small_nmdar_biexp_seed_00001/Ca2.spine.dat", dtype=float)

fig = plt.figure()
ax1 = fig.add_subplot(111)
ax1.set_xlabel("Time (s)")
ax1.set_ylabel("Ca2+ Concentration (uM)")

volume = 0.035 / (1e15) #convert from um^3 to L

scale = ( (1e6) / (6.022e23) ) / volume #to get concentration in uM

ax1.plot(rxn_data[:, 0], rxn_data[:, 1]*scale, 'b')

plt.show()
