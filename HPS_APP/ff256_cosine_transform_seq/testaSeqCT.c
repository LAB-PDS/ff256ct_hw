/*
* FUNCAO : Tests of the direct computation of the FF256CT
* PROJETO: Finite Field 256 Cosine Transforms
* DATA DE CRIACAO: 30/08/2024
*/


//Do codigo basico
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "hwlib.h"
#include "socal.h"
#include "hps.h"
#include "alt_gpio.h"
#include "hps_0.h"

//do codigo de Breno
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h> 
#include <sys/shm.h> 
#include <time.h> 
#include <math.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

#include <unistd.h>

//Feitas por mim
#include "trataHEX.h"
#include "ram.h"
#include "peripheral.h"

#define PORT_1_MEM_BASE  0x5b000
#define PORT_1_ADDR_SPAN 1
#define PORT_1_MEM_SPAN PORT_1_ADDR_SPAN*32

//UDP
#define N 		 64
#define N_PACKET 8
#define N_BUF    16

int main() 
{

	uint32_t i;        //para iteracoes
	uint32_t entrada;        //para iteracoes
	uint32_t mem_read;
	uint32_t mem_read_lsw;
	uint32_t mem_read_msw;
	uint32_t mem_write;
	uint16_t mem_read16;
	uint8_t  mem_read8;
	peripheral port01;
	peripheral port02;

	//Codigo UDP:
	int sock, length, n, flags;
	socklen_t fromlen;
	struct sockaddr_in server;
	struct sockaddr_in from;
	char buf[N_BUF];
	int  buf_int;
	

	sock=socket(AF_INET, SOCK_DGRAM, 0);
	if (sock < 0) printf("Opening socket");

	length = sizeof(server);
	bzero(&server,length);
	server.sin_family=AF_INET;
	server.sin_addr.s_addr=INADDR_ANY;
	server.sin_port=htons(9090);
	if (bind(sock,(struct sockaddr *)&server,length)<0) 
	    printf("binding");
	fromlen = sizeof(struct sockaddr_in);
	//

	printf("defining the access to the memory peripherals\n");
	port01 = peripheral_create(PORT_1_MEM_BASE, PORT_1_MEM_SPAN);

	printf("*---------------------------------------------------------------------\n");
	printf("* FUNCTION       : SEQUENTIAL COMPUTATION OF THE FF2CT TEST\n");
	printf("* PROJECT        : FINITE FIELD GF256 COSINE TRANSFORMS\n");
	printf("* DATE           : 30/08/2024\n");
	printf("*---------------------------------------------------------------------\n");

	while(1)
	{
printf("Waiting package from PC...\n");
		bzero(buf,N_BUF);
	   	n = recvfrom(sock,buf,N_BUF,0,(struct sockaddr *)&from,&fromlen);
	   	if (n < 0) printf("recvfrom");
	   	else
	   	{
			printf("Reseting: %x, data: %x\n",8, 0);
			peripheral_write32(port01,2,0);
			printf("%s\n", buf);
			printf("Processing the received data\n");
			buf_int = converteVetorToInt(buf,8,0);
			printf("value received %x\n",buf_int);
			printf("Writing address: %x, data: %x\n",0, buf_int);
			peripheral_write32(port01,0,buf_int);
			buf_int = converteVetorToInt(&buf[8],8,0);
			printf("Writing address: %x, data: %x\n",4, buf_int);
			peripheral_write32(port01,1,buf_int);
			buf_int =  1;
			printf("Starting: %x, data: %x\n",2*4, buf_int);
			peripheral_write32(port01,2,buf_int);
			usleep(1000);

			mem_read =  peripheral_read32(port01,2);
			while((0x1 && mem_read) == 0)
			{
				buf_int =  1;
				printf("Starting: %x, data: %x\n",2*4, buf_int);
				peripheral_write32(port01,2,buf_int);
				usleep(1000);
				mem_read =  peripheral_read32(port01,2);
				printf("Reading address: %X, data: %X\n", 2*4, mem_read);
				usleep(1000);
			}
			printf("Reading the transform results...\n");
			mem_read =  peripheral_read32(port01,3);	
			printf("Reading address: %X, data: %X\n", 3*4, mem_read);		
			converteInttoASCII(buf, mem_read, 4);
			printf("Buffer: %s\n",buf);
			mem_read =  peripheral_read32(port01,4);	
			printf("Reading address: %X, data: %X\n", 4*4, mem_read);		
			converteInttoASCII(&buf[8], mem_read, 4);
			printf("Buffer: %s\n",buf);
			usleep(1000);
			n = sendto(sock,buf,N_BUF,0,(struct sockaddr *)&from,fromlen);
			if (n  < 0) printf("sendto\n");
			usleep(1000);
		}
	}	
}
