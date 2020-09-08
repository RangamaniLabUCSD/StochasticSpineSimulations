#script to run all MCell simulation files in the geometry variation directory
# arg 1: number of seeds to use per file
# arg 2 (optional): path to the mcell binary to use, if it isn't in the shell environment path 

import os, sys, time

if len(sys.argv) < 2 or len(sys.argv) > 3:
	raise Exception("Length of input must be either 1 or 2")

NUM_SEEDS = sys.argv[1]
if len(sys.argv) == 3:
	MCELL = sys.argv[2]
else:
	MCELL = "mcell"

shapes = ["thin", "mushroom", "filopodial"]
variations = {
	"thin": ["control", "size", "neck", "SA"],
	"mushroom": ["control", "size", "neck", "SA"],
	"filopodial": ["control", "size"]
}

filesToRun = []

for shape in shapes:
	for var in variations[shape]:
		files = os.listdir(shape + '/' + var)
		for file in files:
			if file.endswith("main.mdl"):
				filesToRun.append(shape + '/' + var + '/' + file)

print("\n##########################################\nSimulation files to run: \n")
for file in filesToRun:
	print(file)

with open("times.txt", "w+") as timeFile:
	timeFile.write("simulation name \t\ttime (s)\n")

for file in filesToRun:
	start_time = time.time()
	for i in range(1, int(NUM_SEEDS) + 1):
		os.system(MCELL + " -seed %i %s" % (i, file))
	elapsed_time = time.time() - start_time
	with open("times.txt", "a") as timeFile:
		timeFile.write(file + "\t\t" + str(elapsed_time) + "\n")