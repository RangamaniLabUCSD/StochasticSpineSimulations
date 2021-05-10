import matplotlib.pyplot as plt
import re

fig = plt.figure(1)
ax1 = fig.add_subplot(111)
ax1.set_xlabel("Radius (um)")
ax1.set_ylabel("Height (um)")
ax1.set_aspect('equal', 'box')
ax1.set_xticks((-0.2, 0.2))
ax1.set_xlim((-0.2, 0.2))

fig = plt.figure(2)
ax2 = fig.add_subplot(111)
ax2.set_xlabel("Radius (um)")
ax2.set_ylabel("Height (um)")
ax2.set_aspect('equal', 'box')
ax2.set_xticks((-0.2, 0.2))
ax2.set_xlim((-0.2, 0.2))

fig = plt.figure(3)
ax3 = fig.add_subplot(111)
ax3.set_xlabel("Radius (um)")
ax3.set_ylabel("Height (um)")
ax3.set_aspect('equal', 'box')
ax3.set_xticks((-0.2, 0.2))
ax3.set_xlim((-0.2, 0.2))

fig = plt.figure(4)
ax4 = fig.add_subplot(111)
ax4.set_xlabel("Radius (um)")
ax4.set_ylabel("Height (um)")
ax4.set_aspect('equal', 'box')
ax4.set_xticks((-0.2, 0.2))
ax4.set_xlim((-0.2, 0.2))

points_y = []
points_x = []
with open("../../2d_profile_mesh_generation/creation/filopodial.txt") as meshfile:
	#with open("/Users/mvhsan/Papers/StochasticSpineSimulations/2d_profile_mesh_generation/creation/neck/spherical_neckx-75.txt") as meshfile:
    meshfile.seek(0)
    for line in meshfile:
        values = line.split(" ")
        points_x.append(float(values[0]) * 3 / 4)
        points_y.append(float(values[1]) * 3 / 4)

ax1.plot(points_x, points_y, c='b')
ax2.plot(points_x, points_y, c='b')
ax3.plot(points_x, points_y, c='b')
ax4.plot(points_x, points_y, c='b')

for i in range(len(points_x)):
	points_x[i] = -points_x[i]
ax1.plot(points_x, points_y, c='b')
ax2.plot(points_x, points_y, c='b')
ax3.plot(points_x, points_y, c='b')
ax4.plot(points_x, points_y, c='b')

x_list = {}
y_list = {}

for i in range(4):
	x_list[i], y_list[i] = [], []
	with open("output_" + str(i) + ".txt") as outfile:
		for line in outfile:
			group = re.split("  ", line)
			x_list[i].append(float(group[0]))
			y_list[i].append(float(group[1]) - 0.5)

ax1.scatter(x_list[0], y_list[0], s=0.8)
ax2.scatter(x_list[1], y_list[1], s=0.8)
ax3.scatter(x_list[2], y_list[2], s=0.8)
ax4.scatter(x_list[3], y_list[3], s=0.8)

print("1: ", len(x_list[0]))
print("2: ", len(x_list[1]))
print("3: ", len(x_list[2]))
print("4: ", len(x_list[3]))

plt.show()