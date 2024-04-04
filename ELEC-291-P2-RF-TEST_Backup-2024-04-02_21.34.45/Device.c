#include <EFM8LB1.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define SYSCLK 72000000
#define BAUDRATE 115200L

idata char tbuff[20];
idata char rbuff[13];
idata char buff[20];

char _c51_external_startup (void)
{
	// Disable Watchdog with key sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; //First key
	WDTCN = 0xAD; //Second key
  
	VDM0CN=0x80;       // enable VDD monitor
	RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD

	#if (SYSCLK == 48000000L)	
		SFRPAGE = 0x10;
		PFE0CN  = 0x10; // SYSCLK < 50 MHz.
		SFRPAGE = 0x00;
	#elif (SYSCLK == 72000000L)
		SFRPAGE = 0x10;
		PFE0CN  = 0x20; // SYSCLK < 75 MHz.
		SFRPAGE = 0x00;
	#endif
	
	#if (SYSCLK == 12250000L)
		CLKSEL = 0x10;
		CLKSEL = 0x10;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 24500000L)
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 48000000L)	
		// Before setting clock to 48 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x07;
		CLKSEL = 0x07;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 72000000L)
		// Before setting clock to 72 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x03;
		CLKSEL = 0x03;
		while ((CLKSEL & 0x80) == 0);
	#else
		#error SYSCLK must be either 12250000L, 24500000L, 48000000L, or 72000000L
	#endif
	
	P0MDOUT |= 0x11; // Enable UART0 TX (P0.4) and UART1 TX (P0.0) as push-pull outputs
	P2MDOUT |= 0x01; // P2.0 in push-pull mode
	XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	XBR1     = 0X00;
	XBR2     = 0x41; // Enable crossbar and uart 1

	// Configure Uart 0
	#if (((SYSCLK/BAUDRATE)/(2L*12L))>0xFFL)
		#error Timer 0 reload value is incorrect because (SYSCLK/BAUDRATE)/(2L*12L) > 0xFF
	#endif
	SCON0 = 0x10;
	TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	TL1 = TH1;      // Init Timer1
	TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	TMOD |=  0x20;                       
	TR1 = 1; // START Timer1
	TI = 1;  // Indicate TX0 ready
  	
	return 0;
}

// Uses Timer3 to delay <us> micro-seconds. 
void Timer3us(unsigned char us)
{
	unsigned char i;               // usec counter
	
	// The input for Timer 3 is selected as SYSCLK by setting T3ML (bit 6) of CKCON0:
	CKCON0|=0b_0100_0000;
	
	TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	
	TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	for (i = 0; i < us; i++)       // Count <us> overflows
	{
		while (!(TMR3CN0 & 0x80));  // Wait for overflow
		TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	}
	TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
}

void waitms (unsigned int ms)
{
	unsigned int j;
	unsigned char k;
	for(j=0; j<ms; j++)
		for (k=0; k<4; k++) Timer3us(250);
}

void UART1_Init (unsigned long baudrate)
{
    SFRPAGE = 0x20;
	SMOD1 = 0x0C; // no parity, 8 data bits, 1 stop bit
	SCON1 = 0x10;
	SBCON1 =0x00;   // disable baud rate generator
	SBRL1 = 0x10000L-((SYSCLK/baudrate)/(12L*2L));
	TI1 = 1; // indicate ready for TX
	SBCON1 |= 0x40;   // enable baud rate generator
	SFRPAGE = 0x00;
}

void putchar1 (char c) 
{
    SFRPAGE = 0x20;
	while (!TI1);
	TI1=0;
	SBUF1 = c;
	SFRPAGE = 0x00;
}

void sendstr1 (char * s)
{
	while(*s)
	{
		putchar1(*s);
		s++;	
	}
}

char getchar1 (void)
{
	char c;
    SFRPAGE = 0x20;
	while (!RI1);
	RI1=0;
	// Clear Overrun and Parity error flags 
	SCON1&=0b_0011_1111;
	c = SBUF1;
	SFRPAGE = 0x00;
	return (c);
}

char getchar1_with_timeout (void)
{
	char c;
	unsigned int timeout;
    SFRPAGE = 0x20;
    timeout=0;
	while (!RI1)
	{
		SFRPAGE = 0x00;
		Timer3us(20);
		SFRPAGE = 0x20;
		timeout++;
		if(timeout==25000)
		{
			SFRPAGE = 0x00;
			return ('\n'); // Timeout after half second
		}
	}
	RI1=0;
	// Clear Overrun and Parity error flags 
	SCON1&=0b_0011_1111;
	c = SBUF1;
	SFRPAGE = 0x00;
	return (c);
}

void getstr1 (char * s)
{
	char c;
	
	while(1)
	{
		c=getchar1_with_timeout();
		if(c=='\n')
		{
			*s=0;
			return;
		}
		*s=c;
		s++;
	}
}

// RXU1 returns '1' if there is a byte available in the receive buffer of UART1
bit RXU1 (void)
{
	bit mybit;
    SFRPAGE = 0x20;
	mybit=RI1;
	SFRPAGE = 0x00;
	return mybit;
}

void waitms_or_RI1 (unsigned int ms)
{
	unsigned int j;
	unsigned char k;
	for(j=0; j<ms; j++)
	{
		for (k=0; k<4; k++)
		{
			if(RXU1()) return;
			Timer3us(250);
		}
	}
}

void SendATCommand (char * s)
{
	printf("Command: %s", s);
	P2_0=0; // 'set' pin to 0 is 'AT' mode.
	waitms(5);
	sendstr1(s);
	getstr1(buff);
	waitms(10);
	P2_0=1; // 'set' pin to 1 is normal operation mode.
	printf("Response: %s\r\n", buff);
}

void printCharAsBinary(char c) {
	int i = 0;
	char out;

    for (i = 7; i >= 0; i--) {
        out = (c >> i) & 1; // Shift right i bits, and mask all but the least significant bit
        printf("%d", out);
    }
    printf("\n"); // Move to a new line after printing the binary representation
}

int char2int(char encoded) {
    int sign = (encoded & 0x20) ? -1 : 1; // Check bit 5 for sign. Negative if set.
    int magnitude = encoded & 0x1F; // Extract the magnitude from bits 0-4.
    return sign * magnitude;
}


// int Check_Data_Integrity(char *s){
// 	// param: takes 19 long string.
// 	char c;
// 	char i = 0;
// 	while(*s!=0xAC){
// 		// check 1st byte
// 		s++;
// 		i++;
// 		if(i == 19) return -1; //not found first bit 
// 	}
// 	for(i = 0; i<3;i++) s++; 
// 	if(*s != 0xCA){
// 		// check last byte (4th byte)
// 		return -1;
// 	}
// 	for(i = 2; i>0; i--){
// 		// check if middle two bytes are 0b10xxxxxx
// 		s--;
// 		c = *s;
// 		c &= 0b1100_0000;
// 		if(c != 0b1000_0000) return -1;
// 	}
// 	return 0;
// }

// param, s: 19 long str buff, d 2 long str buff
// void Extract_RXData(char *s, char *d){
// 	char c;
// 	char i = 0;
// 	while(*s!=0xAC){
// 		// find 1st byte
// 		s++;
// 		i++;
		
// 	}
// 	s++; // move ptr to 2nd byte (left motor)
// 	*d = *s; 
// 	d++; // inc ptr for both source and dest. (right motor)
// 	s++;
// 	*d = *s;
// }


void main (void)
{
	unsigned int cnt;
	char i = 0;
	// char cmdbuff[2];
	int lmotor,rmotor, trash;
	int test = 0;
	int reject = 0;
	int offset = 0;

	
	waitms(500);
	printf("\r\nJDY-40 test\r\n");
	UART1_Init(9600);

	// To configure the device (shown here using default values).
	// For some changes to take effect, the JDY-40 needs to be power cycled.
	// Communication can only happen between devices with the
	// same RFID and DVID in the same channel.
	
	//SendATCommand("AT+BAUD4\r\n");
	//SendATCommand("AT+RFID8899\r\n");
	//SendATCommand("AT+DVID1122\r\n"); // Default device ID.
	//SendATCommand("AT+RFC001\r\n");
	//SendATCommand("AT+POWE9\r\n");
	//SendATCommand("AT+CLSSA0\r\n");
	
	// We should select an unique device ID.  The device ID can be a hex
	// number from 0x0000 to 0xFFFF.  In this case is set to 0xABBA
	// SendATCommand("AT+DVIDA0C4\r\n");  
	SendATCommand("AT+DVIDA0C4\r\n");  

	// To check configuration
	SendATCommand("AT+VER\r\n");
	SendATCommand("AT+BAUD\r\n");
	SendATCommand("AT+RFID\r\n");
	SendATCommand("AT+DVID\r\n");
	SendATCommand("AT+RFC\r\n");
	SendATCommand("AT+POWE\r\n");
	SendATCommand("AT+CLSS\r\n");
	
	printf("DEVICE SETUP COMPLETE\n\n");
	//printf("\r\Press and hold the BOOT button to transmit.\r\n");
	cnt=0;

	lmotor = 0;
	rmotor = 0;
	while(1)
	{
		// if(P3_7==0)
		// {
		// 	sprintf(buff, "JDY40 test %d\r\n", cnt++);
		// 	sendstr1(buff);
		// 	putchar('.');
		// 	waitms_or_RI1(200);
		// }
		// if(RXU1())
		// {
		// 	//printf("OK\n");
		// 	//getstr1(buff);
		// 	//printf("RX: %s\r\n", buff);
		// 	//sscanf(buff,"%d,%d", vx, vy);
		// 	//printf ("Vx=%7.5fV, Vy=%7.5fV\r\n", vx, vy);
		// 	//sscanf(buff, "%c",joystick_pos);
		// 	joystick_pos = getchar1();
		// 	printf("%c \n", joystick_pos);
		// }
		//waitms(500);
		// getstr1(buff);
		//test=getchar1();

		// if(RXU1()){
		// 	do{
		// 		putchar('U');
		// 		getstr1(buff);
		// 		putchar('B');
		// 	}while(Check_Data_Integrity(buff)!=0);
		// 	Extract_RXData(buff, cmdbuff);
		// 	putchar('A');
		// }
		// putchar('.');


		// 20 20n
		//0123456
		
		if(RXU1()){
			getstr1(rbuff);
			// if(rbuff[8]=='C' && rbuff[10]=='T'){
			// 	lmotor = atoi(&rbuff[0]);
			// 	rmotor = atoi(&rbuff[4]);
			// }
			sscanf(rbuff,"%d%d",&lmotor,&rmotor);
		 
			// lmotor = atoi(&rbuff[0]);
			// rmotor = atoi(&rbuff[4]);

			// if(strlen(rbuff)==6 || reject == 0){
			// 	lmotor = atoi(&rbuff[0]);
			// 	rmotor = atoi(&rbuff[3]);
			// }else{
			// 	reject++;
			// }

			// if(reject > 10){
			// 	reject = 0;
			// 	lmotor = atoi(&rbuff[0]);
			// 	rmotor = atoi(&rbuff[3]);
			// }
			// printf(rbuff);
			// printf("\n");
			printf("%3d,%3d\n",lmotor,rmotor);
			//strcat(rbuff,"\n");
			//printf(rbuff);
			test++;
			sprintf(tbuff,"%5d\n",test);
			sendstr1(tbuff);
		}
		

	

		//getstr2(buff);
		
		// for(i=0;i<2;i++){
		// 	if((buff[i] &= 0b11000000) != 0b10000000){
		// 		buff[i] = prev_buff[i];
		// 	}else{
		// 		prev_buff[i] = buff[i];
		// 	}
		// }
		//
		//printf("%c, %c \n", rc[0],rc[1]);
		//printf("received: %s\r\n", buff);
		// lmotor = char2int(cmdbuff[0]);
		// rmotor = char2int(cmdbuff[1]);

		// printCharAsBinary(buff[0]);
		// printCharAsBinary(buff[1]);
		// printf("l: %3d, r: %3d\n",lmotor,rmotor);
		

		// printf("\033[A");
		// printf("\033[A");
		// printf("\033[A");

		


	}
}
