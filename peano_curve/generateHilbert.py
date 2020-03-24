### code for generating an n-dimensional, m-order Hilbert curve on the unit hypercube (credit for code goes to Aldo Cortesi)

dim = 2 #dimension
order = 5 #order of the curve
sidelength = 2**order

import hilbert

c = [] #ordered list of points on the hilbert curve

for idx in range(sidelength**dim):
	point = hilbert.hilbert_point(dim, order, idx)
	for i in range(len(point)):
		point[i] = point[i] / sidelength
	c.append(point)

print(c)
