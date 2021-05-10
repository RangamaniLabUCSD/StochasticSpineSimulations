import bpy
import math
import os
import sys
import time

NAME = sys.argv[4]#"filopodial/size_0.75"#sys.argv[4]#"viz_data_control_thin"
itrs = [30000, 60000]
# startseedrange = 34#37
# endseedrange = 35

SEED = int(sys.argv[5])

#startseedrange = int(sys.argv[5])
#endseedrange = startseedrange + 1
"""if len(sys.argv) >= 7:
	itrs = []
	itrs.append(int(sys.argv[6]))"""

mols_total = ["mol_CaBf", "mol_CaBm", "mol_Ca2"]
mols = ["mol_Ca2"]

print('hello world!!!!')

xs, ys = {}, {}

xs[0], ys[0] = [], []
xs[1], ys[1] = [], []
xs[2], ys[2] = [], []
xs[3], ys[3] = [], []

for mol in mols:
	bpy.context.scene.frame_set(0)
	num_mols = len(bpy.data.objects[mol].data.vertices)
	for i in range(num_mols):
		xs[0].append(bpy.data.objects[mol].data.vertices[i].co.y)
		ys[0].append(bpy.data.objects[mol].data.vertices[i].co.z)
	# bpy.data.objects["mol_Ca2"].select = True
	# bpy.ops.object.delete()

	bpy.context.scene.frame_set(1)
	num_mols = len(bpy.data.objects[mol].data.vertices)
	for i in range(num_mols):
		xs[1].append(bpy.data.objects[mol].data.vertices[i].co.y)
		ys[1].append(bpy.data.objects[mol].data.vertices[i].co.z)
	# bpy.data.objects["mol_Ca2"].select = True
	# bpy.ops.object.delete()

for mol in mols_total:
	bpy.context.scene.frame_set(0)
	num_mols = len(bpy.data.objects[mol].data.vertices)
	for i in range(num_mols):
		xs[2].append(bpy.data.objects[mol].data.vertices[i].co.y)
		ys[2].append(bpy.data.objects[mol].data.vertices[i].co.z)
	# bpy.data.objects["mol_Ca2"].select = True
	# bpy.ops.object.delete()

	bpy.context.scene.frame_set(1)
	num_mols = len(bpy.data.objects[mol].data.vertices)
	for i in range(num_mols):
		xs[3].append(bpy.data.objects[mol].data.vertices[i].co.y)
		ys[3].append(bpy.data.objects[mol].data.vertices[i].co.z)
	# bpy.data.objects["mol_Ca2"].select = True
	# bpy.ops.object.delete()

"""
bpy.ops.wm.open_mainfile(filepath='/Users/mvhsan/Papers/StochasticSpineSimulations/mcell_simulations/output.blend')

num_mols = len(bpy.data.objects["Ca2"].data.vertices)
print("number of molecules: ", num_mols)

num_frames = bpy.context.scene.frame_end - bpy.context.scene.frame_start
print("number of frames: ", num_frames)

MSD = {}

bpy.context.scene.frame_set(0)
xs, ys = {}, {}
for mol in range(num_mols):
	xs[0], ys[0] = [], []
	xs[0].append(bpy.data.objects["Ca2"].data.vertices[mol].co.x)
	ys[0].append(bpy.data.objects["Ca2"].data.vertices[mol].co.y)
	#zs_i.append(bpy.data.objects["Ca2"].data.vertices[mol].co.z)

'''
for frame in range(num_frames):
	bpy.context.scene.frame_set(frame + 1)
	xs, ys, zs = [], [], []
	current_msd = 0
	for mol in range(num_mols):
		xs.append(bpy.data.objects["mol_vm"].data.vertices[mol].co.x)
		ys.append(bpy.data.objects["mol_vm"].data.vertices[mol].co.y)
		zs.append(bpy.data.objects["mol_vm"].data.vertices[mol].co.z)
		
		mol_msd = (xs[mol] - xs_i[mol])**2 + (ys[mol] - ys_i[mol])**2 + \
						(zs[mol] - zs_i[mol])**2
		current_msd = current_msd + mol_msd
	
	MSD[frame + 1] = current_msd / num_mols
	#xs_prev, ys_prev, zs_prev = xs, ys, zs
'''

bpy.context.scene.frame_set(200)
for mol in range(num_mols):
    xs[200].append(bpy.data.objects["Ca2"].data.vertices[mol].co.x)
    ys[200].append(bpy.data.objects["Ca2"].data.vertices[mol].co.y)
"""

#with open("MSD_output.txt", "w+") as outfile:
#	for frame in MSD:
#		outfile.write(str(frame) + "  " + str(MSD[frame]) + "\n")

# fig = plt.figure(2)
# ax2 = fig.add_subplot(111)
# ax2.set_xlabel("Radius (um)")
# ax2.set_ylabel("Height (um)")

# fig = plt.figure(3)
# ax2 = fig.add_subplot(111)
# ax2.set_xlabel("Radius (um)")
# ax2.set_ylabel("Height (um)")

#print(xs)
#print(ys)

# xtot = [0, 0, 0, 0]
# for seed in range(startseedrange, endseedrange):
# 	xtot[0] = xtot[0] + len(xs[seed][0])
# 	xtot[1] = xtot[1] + len(xs[seed][1])
# 	xtot[2] = xtot[2] + len(xs[seed][2])
# 	xtot[3] = xtot[3] + len(xs[seed][3])

# print("totals: ", xtot)

x_list = {}
y_list = {}
for n in range(4):
	x_list[n], y_list[n] = [], []
	for i in range(len(xs[n])):
		x_list[n].append(xs[n][i])
	for i in range(len(ys[n])):
		y_list[n].append(ys[n][i])

for key in x_list:
	with open("output_" + str(key) + ".txt", "w+") as outfile:
		for i in range(len(x_list[key])):
			outfile.write(str(x_list[key][i]) + "  " + str(y_list[key][i]) + "\n")

bpy.ops.wm.quit_blender()