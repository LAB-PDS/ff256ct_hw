#OBJETIVO: Testar FF256 Multiplier
#PROJETO:  FINITE FIELD GF256 COSINE TRANSFORMS
#DATA DE CRIACAO: 27/08/2024 

import socket
import numpy as np
import os   #manipular aquivos 


def int_to_hex(int_in):
    if int_in <= 15:
        saida = '0'+hex(int_in)[-1]
    elif int_in > 255:
        saida = 'XX'
    else:
        saida = hex(int_in)[-2:]
    return saida

def hex_to_str(linha):
    saida = ""
    for n in linha:
        type(n)
        saida += int_to_hex(n)
    return saida


def convertStringHex(S):
    '''converte uma strig 'S' de numeros em hexadecimal em um inteiro'''
    outInt = 0
    for n in range(len(S)):
        outInt += (16**n)*convertASCIItoInt(S[len(S)-n-1])
    return outInt

def convertASCIItoInt(xChar):
    '''converte um digito ascii em hexadecimal em um inteiro'''
    xAscii = ord(xChar)
    if (xAscii >= ord('0')) and (xAscii <= ord('9')):
        xInt = xAscii - ord('0')
    elif (xAscii >= ord('a')) and (xAscii <= ord('f')):
        xInt = xAscii - ord('a') + 10
    else :
        xInt =  float('nan') #se nao for hexadecimal, vai dar pau
    return xInt

if __name__ == '__main__':
    print('Creating the UDP socket')
    msgFromClient       = "00112233"
    bytesToSend         = str.encode(msgFromClient)
    serverAddressPort   = ("192.168.1.27", 9090) #("192.168.0.106", 9090)
    bufferSize          = len(bytesToSend)
    # Create a UDP socket at client side
    UDPClientSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

    print("ATTENTION! IS THE IP CORRECT???")
    print(serverAddressPort)
    print('Opening the file with the values: [in,in*cnt1,in*cnt2,..,in*cnt8]')
    filename = "ff256_mult_by_const.txt"
    input_file = open(filename, 'r')

    lines = input_file.readlines()

    resultadoGeral = []
    for line in lines:
        bytesToSend   = str.encode(line[0:2])
        print("Sending: {}".format(bytesToSend))
        UDPClientSocket.sendto(bytesToSend, serverAddressPort)
        #msgFromServer = UDPClientSocket.recvfrom(bufferSize)
        #msg = "Recebido: {}".format(msgFromServer[0])
        #print(msg)
        
        # if(bytesToSend != msgFromServer[0][0:2]):
        #     print('The value sent is different from the one received!')
        #     break;
        # else:
        print('Comparing the results:')
        print('spected 0: {}'.format(line[2:10]))
        msgFromServer = UDPClientSocket.recvfrom(bufferSize)
        msg = "result addr 0: {}".format(msgFromServer[0])
        print(msg)
        print(msgFromServer[0][0:8] == str.encode(line[2:10]))
        resultadoGeral.append(msgFromServer[0][0:8] == str.encode(line[2:10]))
        print('spected 1: {}'.format(line[10:18]))
        msgFromServer = UDPClientSocket.recvfrom(bufferSize)
        msg = "result addr 4: {}".format(msgFromServer[0])
        print(msg)
        print(msgFromServer[0][0:8] == str.encode(line[10:18]))
        resultadoGeral.append(msgFromServer[0][0:8] == str.encode(line[10:18]))
        


