import math
import os
import sys
import time

NAME = sys.argv[1]#"filopodial/size_0.75"#sys.argv[4]#"viz_data_control_thin"
itrs = [30000, 60000]
# startseedrange = 34#37
# endseedrange = 35

SEED = int(sys.argv[2])

#startseedrange = int(sys.argv[5])
#endseedrange = startseedrange + 1
"""if len(sys.argv) >= 7:
	itrs = []
	itrs.append(int(sys.argv[6]))"""

mols_total = ["mol_CaBf", "mol_CaBm", "mol_Ca2"]
mols = ["mol_Ca2"]

print('hello world!!!!')

xs, ys = {}, {}

os.system('rm -rf output_files/mcell/output_data/viz_data/*')
os.system('mkdir output_files/mcell/output_data/viz_data/seed_%05d' % SEED)
for itr in itrs:
	os.system('cp ' + NAME + '/seed_%05d/Scene.cellbin.%05d.dat output_files/mcell/output_data/viz_data/seed_%05d' % (SEED, itr, SEED))