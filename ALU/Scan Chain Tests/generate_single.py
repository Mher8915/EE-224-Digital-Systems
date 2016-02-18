def to_hex(num, number = True):
	test = hex(num)[2:].upper()
	if len(test) == 1 and number:
		test = "0" + test
	return test

def calculate(first, second, op_code):
	result = 0
	if (op_code == 0):
		result  = (first + second) % 256
	elif (op_code == 1):
		k = 256 - second
		result = (first + k) % 256
	elif (op_code == 2):
		m = first
		l = second % 8
		for k in range(0, l):
			m = m * 2
		result = m % 256
	elif (op_code == 3):
		m = first
		l = second % 8
		for k in range(0, l):
			m = m / 2
		result = m % 256
	text = "# some python swag\n"
	print op_code
	text += "SDR 20 TDI(" + str(op_code) + to_hex(first) + to_hex(second) + ") "
	text += "8 TDO(" + to_hex(result) + ") MASK(FF)\nRUNTEST 1 MSEC\n"
	return text
first = input("Enter first number ")
second = input("Enter second number ")
op_code = input("Enter op code ")
text = calculate(first, second, op_code)
with open("in.txt", "a") as myfile:
    myfile.write(text)