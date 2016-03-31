# import random
# from fractions import gcd
# output = "";
# for k in range(0, 1000):
# 	i = random.randrange(1, 1000)
# 	pos = random.randrange(0,8)
# 	if pos == 0:
# 		output += '{0:016b}'.format(i) + " "
# 	for l in range(1,8):
# 		z = random.randrange(1, 65536/i)
# 		z = z*i
# 		output += '{0:016b}'.format(z) + " "
# 		if l == pos:
# 			output += '{0:016b}'.format(i) + " "
# 	output += '{0:016b}'.format(i) + "\n"
# f = open('TRACEFILE_GCD.txt', 'w')
# f.write(output)
# f.close()

import random
from fractions import gcd
output = "";
for k in range(0, 100):
	i = random.randrange(1, 1000)
	gcd_val = 0
	for l in range(0,8):
		z = random.randrange(1, 65536/i)
		z = z*i
		output += '{0:016b}'.format(z) + " "
		if gcd_val == 0:
			gcd_val = z
		else:
			gcd_val = gcd(gcd_val, z)
	output += '{0:016b}'.format(gcd_val) + "\n"
f = open('TRACEFILE_GCD.txt', 'w')
f.write(output)
f.close()