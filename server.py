# first of all import the socket library
import socket            
 
# next create a socket object
s = socket.socket()        
print ("Socket successfully created")
 
# reserve a port on your computer in our
# case it is 123 but it can be anything
port = 34439            
s.bind(('', port))        
print ("socket binded to %s" %(port))
 
# put the socket into listening mode
s.listen(5)    
print ("socket is listening")           
 
# a forever loop until we interrupt it or
# an error occurs
c, addr = s.accept()  
print ('Got connection from', addr )
y=''
while True:
    
    x=c.recv(1024).decode()
    print("received char",x)
    y='sending acknowledgement '+x
    print(y)
    
    c.send(y.encode())
    if y=='sending acknowledgement ;':
        print('yes')
        break
c.close()
