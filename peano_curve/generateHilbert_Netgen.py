## script for using Netgen CSG to generate a geometric mesh of a 3-dimensional, m-order Hilbert Curve, extruded to a tube of a specific radius
### constructed from a collection of spheres, one located at each vertex of the Hilbert Curve, connected consecutively with cylinders
### NOTE: using spheres and cylinders of the same radius appears to cause Netgen to have difficulty finding points of intersection between shapes, so in this script spheres are made to have a radius 1.02 times larger than that of the cylinders

n = 3 #dimensions
m = 2 #number of iterations
starting_point = [0, 0, 0] #location of the lower back left of the 3D hilbert curve
scale = 1 #edge length of the hypercube in which the hilbert curve fits
radius_scale = 10 #how many times smaller the tube radius is than the distance between two points in the hilbert curve


from hilbertcurve.hilbertcurve import HilbertCurve
from enum import Enum
import math
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import netgen.libngpy as ng

side_length = 2**m - 1
radius = scale / (side_length * radius_scale)

c = []
hilbert_curve = HilbertCurve(m, n)

for idx in range((side_length + 1)**n):
    coords = hilbert_curve.coordinates_from_distance(idx)
    point = []
    #for value in coords:
    #   point.append(value / side_length)
    for i in range(len(coords)):
        point.append((coords[i] / side_length)*scale + starting_point[i])
    c.append(point)

spheres = []
cylinders = []
rects = []
for i in range(len(c)):
	point = c[i]
	#prev = c[i - 1]
	spheres.append(ng._csg.Sphere(ng._meshing.Point3d(*point), 1.02*radius))
	if i !=  0:
		prev = c[i -1]
		cylinders.append(ng._csg.Cylinder(ng._meshing.Point3d(*prev), ng._meshing.Point3d(*point), radius))
		start = []
		end = []
		difference = 0
		for index in range(len(point)):
			if abs(point[index] - prev[index]) > (0.1 / side_length):
				difference = point[index] - prev[index]
		for index in range(len(point)):
			if abs(point[index] - prev[index]) > (0.1 / side_length):
				start.append(prev[index])
				end.append(point[index])
				#difference = point[index] - prev[index]
				#print(index)
			else:
				if difference > 0:
					start.append(prev[index] - 2*radius)
					end.append(point[index] + 2*radius)
				elif difference < 0:
					start.append(prev[index] + 2*radius)
					end.append(point[index] - 2*radius)
		print(str(i - 1) + ": ", start)
		print(str(i - 1) + ": ", end)
		if difference > 0:
			rects.append(ng._csg.OrthoBrick(ng._meshing.Point3d(*start), ng._meshing.Point3d(*end)))
		elif difference < 0:
			rects.append(ng._csg.OrthoBrick(ng._meshing.Point3d(*end), ng._meshing.Point3d(*start)))

for i in range(len(spheres)):
	if i == 0:
		output = spheres[0]
	else:
		#output = output + spheres[i] + (rects[i]*cylinders[i] - spheres[i] - spheres[i + 1])
		output = output + (cylinders[i - 1]*rects[i - 1]) + spheres[i]

geo = ng._csg.CSGeometry()
geo.Add(output)
#geo.Draw()

params = ng._meshing.MeshingParameters(maxh=0.5, optsteps2d=3)

mesh = ng._csg.GenerateMesh(geo, params)

mesh.Export('hilbert_netgen.stl', 'STL Format')


