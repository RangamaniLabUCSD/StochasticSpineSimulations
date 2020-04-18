## script for generating 5 3rd-order, 3-dimensional Hilbert Curves horizontally displaced from each other for diffusion testing purposes

n = 3 #dimensions
m = 3 #number of iterations
curves = 5
#starting_point = [-0.25, -0.25, -0.25] #location of the lower back left of the 3D hilbert curve
#scale = 0.5 #edge length of the hypercube in which the hilbert curve fits

from hilbertcurve.hilbertcurve import HilbertCurve
from enum import Enum
import math
import sys

scale = 0.5
point_x = -0.25 - 2*scale

side_length = 2**m

#c = []
hilbert_curve = HilbertCurve(m, n)

coord_dict = {}
face_dict = {}

for number in range(curves):

	starting_point = [float(point_x), -0.25, -0.25]

	c = []

	for idx in range(side_length**n):
		coords = hilbert_curve.coordinates_from_distance(idx)
		point = []
		#for value in coords:
		#	point.append(value / side_length)
		for i in range(len(coords)):
			point.append((coords[i] / side_length)*scale + starting_point[i])
		c.append(point)

	#print(c)

	# with open('hilbertSimple.mdl', 'w+') as outfile:
	# 	outfile.write('hilbertcurve POLYGON_LIST\n{\n  VERTEX_LIST\n  {\n')
	# 	for point in c:
	# 		outfile.write('    [ ' + str(point[0]) + ', ' + str(point[1]) + ', '\
	# 			+ str(point[2]) + ' ]\n')
	# 	outfile.write('  }\n  ELEMENT_CONNECTIONS\n  {\n')
	# 	for i in range(len(c) - 1):
	# 		outfile.write('    [ ' + str(i) + ', ' + str(i + 1) + ' ]\n')
	# 	outfile.write('  }\n}')

	sign_array = [ [1, 1, 1], [-1, 1, 1], [-1, -1, 1], [1, -1, 1], [1, 1, -1], [-1, 1, -1], [-1, -1, -1], [1, -1, -1] ]

	class Sides(Enum):
		UP = [1, 2, 3, 4]
		DOWN = [5, 6, 7, 8]
		LEFT = [2, 6, 7, 3]
		RIGHT = [1, 5, 8, 4]
		FORWARD = [1, 2, 6, 5]
		BACK = [4, 3, 7, 8]
		
	opp = {
		Sides.UP: Sides.DOWN,
		Sides.DOWN: Sides.UP,
		Sides.RIGHT: Sides.LEFT,
		Sides.LEFT: Sides.RIGHT,
		Sides.FORWARD: Sides.BACK,
		Sides.BACK: Sides.FORWARD
	}

	disp = scale / (side_length * 10)
	cubes = []
	connections = []
	for i in range(len(c)):
		if i != 0:
			if abs(c[i][0] - c[i - 1][0]) > 1 / (side_length * 1000):
				connections.append(Sides.RIGHT if (c[i][0] - c[i - 1][0] > 0)\
									else Sides.LEFT)
			elif abs(c[i][1] - c[i - 1][1]) > 1 / (side_length * 1000):
				connections.append(Sides.FORWARD if (c[i][1] - c[i - 1][1] > 0)\
									else Sides.BACK)
			elif abs(c[i][2] - c[i - 1][2]) > 1 / (side_length * 1000):
				connections.append(Sides.UP if (c[i][2] - c[i - 1][2] > 0)\
									else Sides.DOWN)
		cubes.append([])
		for signs in sign_array:
			cubes[i].append( [ c[i][0] + signs[0]*disp, c[i][1] + signs[1]*disp, \
							c[i][2] + signs[2]*disp ] )

	print(len(connections))
	#print(connections)

	coords = []
	faces = []
	for i in range(len(cubes)):
		for vertex in cubes[i]:
			coords.append(vertex)
		d = 8*i - 1
		for side in Sides:
			#if i != 0 and i != len(cubes) - 1:
			if (side != (connections[i] if (i != len(cubes) - 1) else None)) and \
						(side != (opp[connections[i - 1]] if (i != 0) else None)):
				faces.append( [side.value[0]+d, side.value[1]+d, side.value[2]+d] )
				faces.append( [side.value[2]+d, side.value[3]+d, side.value[0]+d] )
		if i != len(cubes) - 1:
			for j in range(3):
				faces.append( [connections[i].value[j]+d, connections[i].value[j + 1]+d, \
							opp[connections[i]].value[j + 1]+d+8] )
				faces.append( [opp[connections[i]].value[j + 1]+d+8, \
							opp[connections[i]].value[j]+d+8, \
							connections[i].value[j]+d] )
			faces.append( [connections[i].value[3]+d, connections[i].value[0]+d, \
						opp[connections[i]].value[0]+d+8] )
			faces.append( [opp[connections[i]].value[0]+d+8, \
						opp[connections[i]].value[3]+d+8, \
						connections[i].value[3]+d] )
		if i == 0:
			print(faces)
	#for vertex in cubes[len(cubes) - 1]:
	#	coords.append(vertex)


	print(len(coords))
	#print(coords)
	print(len(faces))
	#print(faces)

	coord_dict[number] = coords
	face_dict[number] = faces
	point_x = point_x + scale

with open('hilbertGeo.mdl', 'w+') as outfile:
	for number in range(curves):
		coords = coord_dict[number]
		faces = face_dict[number]
		outfile.write('hilbertcurve' + str(number) + ' POLYGON_LIST\n{\n  VERTEX_LIST\n  {\n')
		for coord in coords:
			outfile.write('    [ ' + str(coord[0]) + ', ' + str(coord[1]) + ', '\
	            + str(coord[2]) + ' ]\n')
		outfile.write('  }\n  ELEMENT_CONNECTIONS\n  {\n')
		for face in faces:
			outfile.write('    [ ' + str(face[0]) + ', ' + str(face[1]) + ', '\
				+ str(face[2]) + ' ]\n')
		outfile.write('  }\n}\n\n')


