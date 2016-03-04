import random
last_four = []
output = ""
output2 = ""
op = 0
bomb = 0
gun = 0
knife = 0
terror = 0
sentence = raw_input("Please enter your string:- ").lower()
for letter in sentence:
	x = '{0:06b}'.format(ord(letter)-96)
	if letter == ' ':
		x = "011011"
	# changing states
	if ((bomb==0 and letter=='b') or (bomb==1 and letter=='o') or
		(bomb==2 and letter=='m') or (bomb==3 and letter=='b')):
		bomb += 1
	if ((gun==0 and letter=='g') or (gun==1 and letter=='u') or
		(gun==2 and letter=='n')):
		gun += 1
	if ((knife==0 and letter=='k') or (knife==1 and letter=='n') or
		(knife==2 and letter=='i') or (knife==3 and letter=='f') or
		(knife==4 and letter=='e')):
		knife += 1
	if ((terror==0 and letter=='t') or (terror==1 and letter=='e') or
		(terror==2 and letter=='r') or (terror==3 and letter=='r') or
		(terror==4 and letter=='o') or (terror==5 and letter=='r')):
		terror += 1
	# Deciding output
	result = 0
	if bomb == 4:
		result = 1
		bomb = 1
	if gun == 3:
		result = 1
		gun = 0
	if knife == 5:
		result = 1
		knife = 0
	if terror == 6:
		result = 1
		terror  = 0
	output += "0 " + x + " " + str(result) + "\n"
	output += "1 " + x + " " + str(result) + "\n"
f = open('TRACEFILE.txt', 'w')
f.write(output)
f.close()