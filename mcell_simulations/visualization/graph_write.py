import matplotlib as mpl
import matplotlib.pyplot as plt
from matplotlib.offsetbox import AnchoredText
import re, sys, os
import numpy as np

geoName = re.split("/", sys.argv[1])[0]
simName = re.split("/", sys.argv[1])[1]

SEED = int(sys.argv[2])

mpl.rcParams['xtick.labelsize'] = 10
mpl.rcParams['ytick.labelsize'] = 10
mpl.rcParams['axes.labelsize'] = 10
mpl.rcParams['axes.titlesize'] = 10
mpl.rcParams['font.sans-serif'] = "Arial"
mpl.rcParams['figure.dpi'] = 300


multiplier = 1
fileName = geoName + "_" + simName + ".txt"
#if "neck" not in simName and "control" not in simName:
if "size" in simName:
	multiplier = float(simName.replace("size_", ""))
	fileName = geoName + "_control.txt"

points_y = []
points_x = []
with open("../../2d_profile_mesh_generation/creation/textfiles/%s" % fileName) as meshfile:
	#with open("/Users/mvhsan/Papers/StochasticSpineSimulations/2d_profile_mesh_generation/creation/neck/spherical_neckx-75.txt") as meshfile:
    meshfile.seek(0)
    for line in meshfile:
        values = line.split(" ")
        points_x.append(float(values[0]) * multiplier)
        points_y.append(float(values[1]) * multiplier)

if "neck" in simName:
	if "thick" in simName:
		multiplier = 0.82
	elif "thin" in simName:
		multiplier = 1.4

if "filopodial" in geoName:
	dim = 2.2 * multiplier
elif "thin" in geoName:
	dim = 1.1 * multiplier
elif "mushroom" in geoName:
	if multiplier == 0.66 or "thick" in simName:
		dim = 1.76
	else:
		dim = 1.65 * multiplier

fig = plt.figure(1, figsize=(dim,dim))
ax1 = fig.add_subplot(111)#, label='1')
ax1.set_xlabel("Radius (\u03BCm)")
ax1.set_ylabel("Height (\u03BCm)")
ax1.set_aspect('equal', 'box')
#ax1.xaxis.set_visible(False)
#ax1.get_yaxis().set_visible(False)

#plt.axis('off')

fig = plt.figure(2, figsize=(dim,dim))
ax2 = fig.add_subplot(111)#, label='2')
ax2.set_xlabel("Radius (\u03BCm)")
ax2.set_ylabel("Height (\u03BCm)")
ax2.set_aspect('equal', 'box')

#plt.axis('off')

fig = plt.figure(3, figsize=(dim,dim))
ax3 = fig.add_subplot(111)#, label='3')
ax3.set_xlabel("Radius (\u03BCm)")
ax3.set_ylabel("Height (\u03BCm)")
ax3.set_aspect('equal', 'box')

#plt.axis('off')

fig = plt.figure(4, figsize=(dim,dim))
ax4 = fig.add_subplot(111)#, label='4')
ax4.set_xlabel("Radius (\u03BCm)")
ax4.set_ylabel("Height (\u03BCm)")
ax4.set_aspect('equal', 'box')

#plt.axis('off')

if "filopodial" in geoName:
	tick = 0.4
	barX = 0.4
	height = 4.6 * multiplier
	line_y = np.linspace(0, 2, 100)

elif "thin" in geoName:
	tick = 0.41 #* multiplier
	barX = 0.25 #* multiplier
	height = 0.81 * multiplier
	line_y = np.linspace(0, 0.5, 100)

elif "mushroom" in geoName:
	tick = 0.65 #* multiplier
	barX = 0.35 #* multiplier
	height = 1.22 * multiplier
	line_y = np.linspace(0, 0.5, 100)

line_x = [-1*barX]*100
ax1.set_ylim((0, height))
ax1.plot(line_x, line_y, linewidth=(1.5 if tick == 0.4 else 1), color=(0,0,0))
ax2.set_ylim((0, height))
ax2.plot(line_x, line_y, linewidth=(1.5 if tick == 0.4 else 1), color=(0,0,0))
ax3.set_ylim((0, height))
ax3.plot(line_x, line_y, linewidth=(1.5 if tick == 0.4 else 1), color=(0,0,0))
ax4.set_ylim((0, height))
ax4.plot(line_x, line_y, linewidth=(1.5 if tick == 0.4 else 1), color=(0,0,0))


ax1.set_xticks((-1*tick, tick))
ax1.set_xlim((-1*tick, tick))#ax1.set_xlim((-0.3,1))
ax2.set_xticks((-1*tick, tick))
ax2.set_xlim((-1*tick, tick))
ax3.set_xticks((-1*tick, tick))
ax3.set_xlim((-1*tick, tick))
ax4.set_xticks((-1*tick, tick))
ax4.set_xlim((-1*tick, tick))

#outBox = mpl.transforms.Bbox([[-2.2,-2.2],[2.2,2.2]])#mpl.transforms.Bbox([[-1*tick,0], [tick,height]])

# with open("output_txtfile.txt") as outfile:
# 	for i in range(len(points_x)):
# 		outfile.write(str(points_x[i]) + " " + str(points_y[i]))


ax1.plot(points_x, points_y, c='b', linewidth=1)
ax2.plot(points_x, points_y, c='b', linewidth=1)
ax3.plot(points_x, points_y, c='b', linewidth=1)
ax4.plot(points_x, points_y, c='b', linewidth=1)

for i in range(len(points_x)):
	points_x[i] = -points_x[i]
ax1.plot(points_x, points_y, c='b', linewidth=1)
ax2.plot(points_x, points_y, c='b', linewidth=1)
ax3.plot(points_x, points_y, c='b', linewidth=1)
ax4.plot(points_x, points_y, c='b', linewidth=1)

maxX = max(points_x)
maxY = max(points_y)

if "SA" in simName:
	points_y = []
	points_x = []

	with open("../../2d_profile_mesh_generation/creation/textfiles/%s" % (geoName + "_control.txt")) as meshfile:
	    meshfile.seek(0)
	    for line in meshfile:
	        values = line.split(" ")
	        points_x.append(float(values[0]))
	        points_y.append(float(values[1]))

	ax1.plot(points_x, points_y, c='b', linewidth=1)
	ax2.plot(points_x, points_y, c='b', linewidth=1)
	ax3.plot(points_x, points_y, c='b', linewidth=1)
	ax4.plot(points_x, points_y, c='b', linewidth=1)

	for i in range(len(points_x)):
		points_x[i] = -points_x[i]
	ax1.plot(points_x, points_y, c='b', linewidth=1)
	ax2.plot(points_x, points_y, c='b', linewidth=1)
	ax3.plot(points_x, points_y, c='b', linewidth=1)
	ax4.plot(points_x, points_y, c='b', linewidth=1)


x_list = {}
y_list = {}

for i in range(4):
	x_list[i], y_list[i] = [], []
	with open("output_" + str(i) + ".txt") as outfile:
		for line in outfile:
			group = re.split("  ", line)
			x_list[i].append(float(group[0]))
			y_list[i].append(float(group[1]) - 0.5)

colors = (1, 0, 0.75)#(0.75, 0, 1)#(0, 0.8, 0.1) #(1, 0, 0.75)
ax1.scatter(x_list[0], y_list[0], s=0.8, edgecolors='none', facecolors=colors)
ax2.scatter(x_list[1], y_list[1], s=0.8, edgecolors='none', facecolors=colors)
ax3.scatter(x_list[2], y_list[2], s=0.8, edgecolors='none', facecolors=colors)
ax4.scatter(x_list[3], y_list[3], s=0.8, edgecolors='none', facecolors=colors)

ax1.set_title(str(len(x_list[0])))
ax2.set_title(str(len(x_list[1])))
ax3.set_title(str(len(x_list[2])))
ax4.set_title(str(len(x_list[3])))

# if geoName != "filopodial":
# 	text_box = AnchoredText(str(len(x_list[0])), prop=dict(size=14), frameon=False, loc=4, pad=0)
# 	plt.setp(text_box.patch, facecolor='white', alpha=0.5)
# 	ax1.add_artist(text_box)
# 	text_box = AnchoredText(str(len(x_list[1])), prop=dict(size=14), frameon=False, loc=4, pad=0)
# 	plt.setp(text_box.patch, facecolor='white', alpha=0.5)
# 	ax2.add_artist(text_box)
# 	text_box = AnchoredText(str(len(x_list[2])), prop=dict(size=14), frameon=False, loc=4, pad=0)
# 	plt.setp(text_box.patch, facecolor='white', alpha=0.5)
# 	ax3.add_artist(text_box)
# 	text_box = AnchoredText(str(len(x_list[3  ])), prop=dict(size=14), frameon=False, loc=4, pad=0)
# 	plt.setp(text_box.patch, facecolor='white', alpha=0.5)
# 	ax4.add_artist(text_box)
# else:
# 	bbox = ax1.get_window_extent().transformed(fig.dpi_scale_trans.inverted())
# 	width, height = 0.25, 0#maxX*1.1, 0

# 	ax1.text(width, height, str(len(x_list[0])), fontsize=14)
# 	ax2.text(width, height, str(len(x_list[1])), fontsize=14)
# 	ax3.text(width, height, str(len(x_list[2])), fontsize=14)
# 	ax4.text(width, height, str(len(x_list[3])), fontsize=14)


print("1: ", len(x_list[0]))
print("2: ", len(x_list[1]))
print("3: ", len(x_list[2]))
print("4: ", len(x_list[3]))

outName = geoName + "_" + simName
timeMs = [15, 30]

os.system("mkdir figure_output/%s" % outName)
os.system("mkdir figure_output/supp/%s" % outName)

for i in range(4):
	plt.figure(i+1, figsize=(1,1))
	plt.axis('off')
	total = ""
	supp = ""
	if i > 1:
		total = "_total"
		supp = "supp/"
	plt.savefig( ("figure_output/%s%s/%s_seed%d_%dms%s_%d.png" % (supp, outName, outName, SEED, timeMs[i % 2], total, len(x_list[i]))), bbox_inches='tight' )

#plt.show()