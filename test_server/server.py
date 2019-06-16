import socket

port = 5000

s = socket.socket()

s.bind(('', port))

#lets 10 things connect at once
s.listen(10)

print("listening on port " + str(port))

while True:
	c, addr = s.accept()
	print("Connection from " + str(addr))
	while True:
		response = input("send message: ")
		if response is "q":
			break

		c.send(response.encode('utf-8'))
		



