output = ""
for i in range(0, 256):
	for j in range(0, 256):
		sum1 = (i + j) % 256
		output += "{0:08b}".format(i) + " " + "{0:08b}".format(j) + " 00 " + "{0:08b}".format(sum1) + "\n"
for i in range(0, 256):
	for j in range(0, 256):
		k = 256 - j
		sum1 = (i + k) % 256
		output += "{0:08b}".format(i) + " " + "{0:08b}".format(j) + " 01 " + "{0:08b}".format(sum1) + "\n"
for i in range(0, 256):
	for j in range(0, 256):
		m = i
		l = j % 8;
		for k in range(0, l):
			m = m * 2
		sum1 = m % 256;
		output += "{0:08b}".format(i) + " " + "{0:08b}".format(j) + " 10 " + "{0:08b}".format(sum1) + "\n"
for i in range(0, 256):
	for j in range(0, 256):
		m = i
		l = j % 8
		for k in range(0, l):
			m = m / 2
		sum1 = m % 256;
		output += "{0:08b}".format(i) + " " + "{0:08b}".format(j) + " 11 " + "{0:08b}".format(sum1) + "\n"
f = open('TRACEFILE_ALU.txt', 'w')
f.write(output)
f.close()