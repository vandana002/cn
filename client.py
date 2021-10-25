# Import socket module
import socket            
 
# Create a socket object

 
# Define the port on which you want to connect
port = 34439              


s = socket.socket()        
s.connect(('127.0.0.1', port))


data=input("enter the data to send ")
# connect to the server on local computer

i=0
while(i!=len(data)):
        print("sending char",data[i])
        s.send(data[i].encode())
        y=s.recv(1024).decode()
        print(y)
        if(y=='sending acknowledgement '+data[i]):
            print("char",data[i],"sent")
            i+=1
        else:
            print("resending char",data[i])
# receive data from the server and decoding to get the string.
# close the connection
s.close()    
     
