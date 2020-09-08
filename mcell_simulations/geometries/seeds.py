#script to run an input MCell file for number of different seeds
# arg 1: mdl file to run
# arg 2: number of seeds to use
# arg 3 (optional): path to the mcell binary to use, if it isn't in the shell environment path 

import os, sys

if len(sys.argv) < 3 or len(sys.argv) > 4:
	raise Exception("Length of input must be either 2 or 3")

#MCELL = sys.argv[1]
FILE = sys.argv[1]
NUM_SEEDS = sys.argv[2]
if len(sys.argv) == 4:
	MCELL = sys.argv[3]
else:
	MCELL = "mcell"

for i in range(1, int(NUM_SEEDS) + 1):
	os.system(MCELL + " -seed %i %s" % (i, FILE))
