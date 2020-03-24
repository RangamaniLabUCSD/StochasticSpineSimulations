## script for generating an n-dimensional, m-order hilbert curve on the unit hypercube

n = 3 #dimensions
m = 4 #number of iterations

from hilbertcurve.hilbertcurve import HilbertCurve

side_length = 2**m

c = []
hilbert_curve = HilbertCurve(m, n)

for idx in range(side_length**n):
	coords = hilbert_curve.coordinates_from_distance(idx)
	point = []
	for value in coords:
		point.append(value / side_length)
	c.append(point)

print(c)
