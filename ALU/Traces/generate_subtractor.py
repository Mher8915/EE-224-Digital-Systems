output = ""
for i in range(0, 256):
	for j in range(0, 256):
		k = 256 - j
		sum1 = (i + k) % 256
		output += "{0:08b}".format(i) + " " + "{0:08b}".format(j) + " " + "{0:08b}".format(sum1) + "\n"
f = open('TRACEFILE_Subtractor.txt', 'w')
f.write(output)
f.close()