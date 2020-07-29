##something such that I create point choosing density function based on how close together the points are, and a maximum number of points to choose

import netgen as ng
import matplotlib.pyplot as plt
import math

NUM_POINTS = 50

points = []
y_origs = []

with open("../spherical.txt") as meshfile:
	meshfile.seek(0)
	for line in meshfile:
		values = line.split(" ")
		points.append((float(values[0])*math.pow(0.1, 1/3)*0.75, 1.25*float(values[1])*math.pow(0.1, 1/3)*0.75))
		y_origs.append(1.25*float(values[1])*math.pow(0.1, 1/3))

disp = 1.5*max(y_origs)

#for i in range(len(points)):
#	points[i] = (points[i][0], points[i][1] + disp)

num_points = len(points)

print(num_points)

cutoff = int(num_points / 24)

pnt_ys = []
for point in points:
    pnt_ys.append(point[1])

max_y = max(pnt_ys)

for i in range(len(points)):
	point = points[i]
	if i < cutoff:
		points[i] = (point[0], point[1] + (disp - max_y) * (1 if i == 0 else i) / cutoff)
	else:
		points[i] = (point[0], point[1] + (disp - max_y))

distances = []
distances.append(0)
totals = []
totals.append(0)
total = 0
for i in range(len(points) - 1):
	distance = math.sqrt((points[i][0] - points[i + 1][0])**2 + \
							(points[i][1] - points[i + 1][1])**2)
	distances.append(distance)
	total = total + distance
	totals.append(total)

indices = []
j = 0
for i in range(NUM_POINTS):
	expected = i * (total / NUM_POINTS)
	while True:
		if totals[j] <= expected:
			j = j + 1
		else:
			#new_index = j if (totals[j] - expected > expected - totals[j - 1])\
			#	else j - 1
			#if i == 0  or distances[j] > total / (10*NUM_POINTS):
			if len(indices) > 1:
				if math.sqrt((points[indices[len(indices) - 1]][0] - points[j - 1][0])**2 + \
                            (points[indices[len(indices) - 1]][1] - points[j - 1][1])**2) > \
							total / (2*NUM_POINTS):
					indices.append(j - 1)
			else:
				indices.append(j - 1)
			#indices.append(new_index)
			j = j + 1
			break;

#indices.append(num_points - 2)
indices.append(num_points - 1)

print(indices)

new_points = []

fig, ax = plt.subplots()

#x, y = [], []
#for point in points:
#	x.append(point[0])
#	y.append(point[1])

#lim = max( [max(x), max(y)] )

#ax.set(xlim = (0, 1.05*lim), ylim = (0, 1.05*lim))

for index in indices:
	if len(new_points) == 0 or abs(new_points[len(new_points) - 1][1] - \
				points[index][0]) > 1e-4:
		new_points.append([points[index][1], points[index][0]])
	#ax.plot(points[index][1], points[index][0], 'ro')
#plt.show()

#new_points = [(0, 0), (1, 4), (1.5, 5), (2.5, 5), (3, 4), (4, 0)]

x, y = [], []
for point in new_points:
    x.append(point[0])
    y.append(point[1])

lim = max( [max(x), max(y)] )

ax.set(xlim = (0, 1.05*lim), ylim = (0, 1.05*lim))

for point in new_points:
	ax.plot(point[0], point[1], 'ro')
plt.show()

print(new_points)

segs = []
for i in range(len(new_points) - 1):
	segs.append([i, i + 1])

print(segs)

spline = ng.libngpy._csg.SplineCurve2d()

for point in new_points:
    spline.AddPoint(*point)

for seg in segs:
    spline.AddSegment(*seg)

rev = ng.libngpy._csg.Revolution(ng.libngpy._meshing.Point3d(0, 0, 0.5), ng.libngpy._meshing.Point3d(0, 0, 1), spline)

geo = ng.libngpy._csg.CSGeometry()
geo.Add(rev.col([1, 0, 0]))
#geo.Draw()

params = ng.libngpy._meshing.MeshingParameters(maxh=0.05, optsteps2d=3)

mesh = ng.libngpy._csg.GenerateMesh(geo, params)

mesh.Export('SA_size.stl', 'STL Format')

