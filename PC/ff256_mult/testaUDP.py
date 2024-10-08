#OBJETIVO: Abrir um socket UDP escrever uma mensagem e esperar resposta
#PROJETO:  FINITE FIELD GF256 COSINE TRANSFORMS
#DATA DE CRIACAO: 28/08/2024 
import socket
import numpy


msgFromClient       = "Testando comunicacao"
bytesToSend         = str.encode(msgFromClient)
serverAddressPort   = ("192.168.1.23", 9090) 
bufferSize          = len(bytesToSend)

 

# Create a UDP socket at client side
UDPClientSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

 

print("Mensagem enviada:")
print(msgFromClient)

print("Send to server using created UDP socket")
UDPClientSocket.sendto(bytesToSend, serverAddressPort)


print("Esperando receber algo:")
msgFromServer = UDPClientSocket.recvfrom(bufferSize)

 
print("Mensagem recebida")
msg = "Message from Server {}".format(msgFromServer[0])

print(msg)