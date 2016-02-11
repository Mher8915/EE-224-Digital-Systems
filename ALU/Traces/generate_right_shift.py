output = ""
for i in range(0, 256):
	for j in range(0, 128):
		m = i
		l = j % 8
		for k in range(0, l):
			m = m / 2
		sum1 = m % 256;
		output += "{0:08b}".format(i) + " " + "{0:08b}".format(j) + " " + "{0:08b}".format(sum1) + "\n"
f = open('TRACEFILE_Right_Shift.txt', 'w')
f.write(output)
f.close()