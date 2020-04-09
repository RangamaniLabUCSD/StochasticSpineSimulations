#script to run an input MCell file for number of different seeds

import os, sys

#MCELL = sys.argv[1]
FILE = sys.argv[1]
NUM_SEEDS = sys.argv[2]
if len(sys.argv) >= 4:
	MCELL = sys.argv[3]
else:
	MCELL = "mcell"

for i in range(1, int(NUM_SEEDS) + 1):
	os.system(MCELL + " -seed %i %s" % (i, FILE))
