import random
last_four = []
output = ""
output2 = ""
op = 0
for k in range(0, 50000):
	output += "1 0"
	i = random.randrange(0, 2)
	output += str(i) + " "
	if len(last_four) < 4:
		last_four.append(i)
		op = 0
	else:
		last_four.pop(0)
		last_four.append(i)
		if last_four == [0, 1, 0, 1] or last_four == [1, 0, 1, 0]:
			op = 1
		else:
			op = 0
	output += str(op) + "\n0 0" + str(i) + " " + str(op) + "\n"

f = open('TRACEFILE1.txt', 'w')
f.write(output)
f.close()