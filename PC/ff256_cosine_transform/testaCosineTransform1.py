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
    msgFromClient       = "0011223344556677"
    bytesToSend         = str.encode(msgFromClient)
    serverAddressPort   = ("192.168.1.24", 9090) #("192.168.0.106", 9090)
    bufferSize          = len(bytesToSend)
    # Create a UDP socket at client side
    UDPClientSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

    print("ATTENTION! IS THE IP CORRECT???")
    print(serverAddressPort)
    print('Opening the file with the values: [x_in[0:8],X_out[0:8]]')
    filename = "ff256ct1_testdata.txt" #"ff256ct1_testdata_reduzido.txt"
    input_file = open(filename, 'r')

    lines = input_file.readlines()

    resultadoGeral = []
    for line in lines:
        bytesToSend   = str.encode(line[0:16])
        print("Sending: {}".format(bytesToSend))
        UDPClientSocket.sendto(bytesToSend, serverAddressPort)
        print('Comparing the results:')
        print('spected: {}'.format(line[16:32]))
        msgFromServer = UDPClientSocket.recvfrom(bufferSize)
        msg = "result : {}".format(msgFromServer[0])
        print(msg)
        print(msgFromServer[0][0:16] == str.encode(line[16:32]))
        resultadoGeral.append(msgFromServer[0][0:16] == str.encode(line[16:32]))
        if((msgFromServer[0][0:16] == str.encode(line[16:32])) == False):
            print('Input  : {}'.format(bytesToSend))
            print('Output : {}'.format(msgFromServer[0][0:16]))
            print('Spected: {}'.format(str.encode(line[16:32])))
            break;

    
    print('Pass all tests:',set(resultadoGeral))
        


