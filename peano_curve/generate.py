##### script for generating a 2-D Peano Curve on the unit square

s = 1 #distance between centers of two adjacent squares
c = [(0.5, 0.5)] #array of square center tuples
col = [0.5] #list of columns
keydict = {}

#			lLuR: lower left to upper right
#			lRuL: lower right to upper left
#			uLlR: upper left to lower right
#			uRlL: upper right to lower left

lLuR = [(-1, -1, -1, 0, 0, 0, 1, 1, 1), (-1, 0, 1, 1, 0, -1, -1, 0, 1)]
lRuL = [(1, 1, 1, 0, 0, 0, -1, -1, -1), (-1, 0, 1, 1, 0, -1, -1, 0, 1)]
uLlR = [(-1, -1, -1, 0, 0, 0, 1, 1, 1), (1, 0, -1, -1, 0, 1, 1, 0, -1)]
uRlL = [(1, 1, 1, 0, 0, 0, -1, -1, -1), (1, 0, -1, -1, 0, 1, 1, 0, -1)]

keydict[0] = lLuR

for i in range(3):
	s = s / 3
	new_c = []
	new_keydict = {}
	for j in range(len(c)):
		coeff = keydict[j]
		if coeff == lLuR:
			new_entry = [lLuR, lRuL, lLuR, uLlR, uRlL, uLlR, lLuR, lRuL, lLuR]
		elif coeff == lRuL:
			new_entry = [lRuL, lLuR, lRuL, uRlL, uLlR, uRlL, lRuL, lLuR, lRuL]
		elif coeff == uLlR:
			new_entry = [uLlR, uRlL, uLlR, lLuR, lRuL, lLuR, uLlR, uRlL, uLlR]
		elif coeff == uRlL:
			new_entry = [uRlL, uLlR, uRlL, lRuL, lLuR, lRuL, uRlL, uLlR, uRlL]
		else:
			print("something went wrong; the dictionary coefficients aren't returning as expected")
		for k in range(9):
			new_c.append( (coeff[0][k]*s + c[j][0], coeff[1][k]*s + c[j][1]) )
			new_keydict[9*j + k] = new_entry[k]

	c = new_c
	keydict = new_keydict

	print(c)
	print(s)
