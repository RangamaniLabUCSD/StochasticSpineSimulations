## script for graphing the first three iterations of the three-dimensional Hilbert Curve superimposed on each other using matplotlib

n = 3 #dimensions
m_max = 3 #max number of iterations to graph
starting_point = [0, 0, 0] #location of the lower back left of the 3D hilbert curve
scale = 1 #edge length of the hypercube in which the hilbert curve fits

from hilbertcurve.hilbertcurve import HilbertCurve
from enum import Enum
import math
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

for m in range(1, m_max + 1):
	side_length = 2**m

	c = []
	hilbert_curve = HilbertCurve(m, n)

	for idx in range(side_length**n):
		coords = hilbert_curve.coordinates_from_distance(idx)
		point = []
		#for value in coords:
		#	point.append(value / side_length)
		for i in range(len(coords)):
			point.append((coords[i] / (side_length - 1))*scale + starting_point[i])
		c.append(point)

	#print(c)

	xs, ys, zs = [], [], []

	for point in c:
		xs.append(point[0])
		ys.append(point[1])
		zs.append(point[2])

	ax.plot(xs, ys, zs=zs, linewidth=(2*m_max + 1 - 2*m))
plt.show()


