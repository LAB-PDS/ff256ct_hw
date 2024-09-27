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
    print('Criando ao socket UDP')
    msgFromClient       = "Testando comunicacao"
    bytesToSend         = str.encode(msgFromClient)
    serverAddressPort   = ("192.168.1.21", 9090) #("192.168.0.106", 9090)
    bufferSize          = len(bytesToSend)
    # Create a UDP socket at client side
    UDPClientSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

    print("ATENCAO! O IP ESTÁ CORRETO???")
    print(serverAddressPort)
    print('Abrindo o arquivo com os valores de A*B = C')
    filename = "multiplicacoes_gf256.txt"
    input_file = open(filename, 'r')

    lines = input_file.readlines()

    resultadoGeral = []
    for line in lines:
        # AB = convertStringHex(line[0:4])
        # A =  convertStringHex(line[0:2])
        # B =  convertStringHex(line[2:4])
        # C =  convertStringHex(line[4:6])
        bytesToSend   = str.encode(line[0:4])
        print("Enviando: {}".format(bytesToSend))
        UDPClientSocket.sendto(bytesToSend, serverAddressPort)
        msgFromServer = UDPClientSocket.recvfrom(bufferSize)
        msg = "Recebido: {}".format(msgFromServer[0])
        print(msg)
        
        if(bytesToSend != msgFromServer[0]):
            print('Valor enviador diferente do recebido!')
            break;
        else:
            print('Trantando resultado:')
            print('Esperado: {}'.format(line[4:6]))
            msgFromServer = UDPClientSocket.recvfrom(bufferSize)
            msg = "Resultado: {}".format(msgFromServer[0])
            print(msg)
            print(msgFromServer[0][0:2] == str.encode(line[4:6]))
            resultadoGeral.append(msgFromServer[0][0:2] == str.encode(line[4:6]))



    # resultadoGeral = []
    # for n in range(nblocos):#nblocos):
    #     print("Enviando o bloco {}".format(n))
    #     for m in range(ncol):
    #         bytesToSend   = str.encode(hex_to_str(input_array[:,m,n]))
    #         #print("Enviando: {}".format(bytesToSend))
    #         UDPClientSocket.sendto(bytesToSend, serverAddressPort)
    #         msgFromServer = UDPClientSocket.recvfrom(bufferSize)
    #         #msg = "Resposta: {}".format(msgFromServer[0])
    #         #print(msgFromServer[0]==bytesToSend)
    #     print("Recebendo o bloco {}".format(n))
    #     resultadoBloco = []
    #     for m in range(ncol):
    #         bytesToReceive    = str.encode(hex_to_str(output_array_clipped[:,m,n]))
    #         msgFromServer = UDPClientSocket.recvfrom(bufferSize)
    #         resultadoLinha = msgFromServer[0]==bytesToReceive
    #         resultadoBloco.append(resultadoLinha)
    #         #print("Bloco transfomado corretamente",resultadoLinha)
    #     resultadoGeral.append(resultadoBloco)


