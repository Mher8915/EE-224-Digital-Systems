import random
output = "";
for k in range(0, 10000):
	i = random.randrange(0, 65536)
	j = random.randrange(0, 65536)
	#if j > i:
	#	i,j = j,i
	m = i / j;
	n = i % j;
	output += '{0:016b}'.format(i) + " ";
	output += '{0:016b}'.format(j) + " ";
	output += '{0:016b}'.format(m) + " ";
	output += '{0:016b}'.format(n) + "\n";
f = open('TRACEFILE.txt', 'w')
f.write(output)
f.close()