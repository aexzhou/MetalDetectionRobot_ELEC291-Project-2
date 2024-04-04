#include "ControllerCore.h"
#include "ControllerUI.h"
#include "ControllerLCD.h"

#define BASE_FREQ 5583
#define SYSCLK 72000000L

int t = 0; //global variable, used to reduce the speed for timer4 isr
idata char tbuff[20];
idata char rbuff[20];
idata Motor mcmd1;
idata Motor mcmd2;
idata Motor mcmd;

void printCharAsBinary(char c) {
	int i = 0;
	char out;

    for (i = 7; i >= 0; i--) {
        out = (c >> i) & 1; // Shift right i bits, and mask all but the least significant bit
        printf("%d", out);
    }
    printf("\n"); // Move to a new line after printing the binary representation
}

void Timer2_ISR (void) interrupt INTERRUPT_TIMER2
{
	TF2H = 0; // Clear Timer2 interrupt flag
	OUT0=!OUT0;
	OUT1=!OUT0;
}


void main (void)
{	
	unsigned int cnt;
	float vx_right, vy_right, sw_right;
	float vx_left, vy_left, sw_left;
	int vx1,vy1,vx2,vy2;
	int timeout;
	int freq;
	char sw1,sw2;
	char position = 0;

	unsigned long int x;
	unsigned long int f = 1000;
	
	waitms(500);
	UART1_Init(9600);
	
	//ADC initialization
	InitPinADC(2, 1); // Configure P2.1 as analog input
	InitPinADC(2, 2); // Configure P2.2 as analog input
	InitPinADC(2, 3); // Configure P2.3 as analog input
	InitPinADC(2, 4); // Configure P2.4 as analog input
	InitPinADC(2, 5); // Configure P2.5 as analog input
	InitPinADC(2, 6); // Configure P2.6 as analog input
    InitADC();
	
	LCD_4BIT();

	printf("\n\n---- Press and Hold both Joysticks to Calibrate ----\n");
	Wait_For_Calibration();
	waitms(200);
	//JDY-40 Set-up
	SendATCommand("AT+BAUD\r\n");
	SendATCommand("AT+BAUD\r\n");
	SendATCommand("AT+RFID\r\n");
	SendATCommand("AT+DVIDA0C4\r\n");
	// SendATCommand("AT+DVID7777\r\n");
	SendATCommand("AT+RFC\r\n");  
	SendATCommand("AT+POWE\r\n");
	SendATCommand("AT+CLSS\r\n");
	SendATCommand("AT+VER\r\n");

	
	printf("\n\n---- CONTROLLER SETUP COMPLETE ----\n");


	cnt=0;
	while(1)
	{
		//Left Joystick
		sw_left = Volts_at_Pin(QFP32_MUX_P2_6);
		vx_left = Volts_at_Pin(QFP32_MUX_P2_5);
		vy_left = Volts_at_Pin(QFP32_MUX_P2_4);
		//Right Joystick
		sw_right = Volts_at_Pin(QFP32_MUX_P2_1);
		vx_right = Volts_at_Pin(QFP32_MUX_P2_2);
		vy_right = Volts_at_Pin(QFP32_MUX_P2_3);

		vx1 = Voltage_to_Coordinate(vx_left);
		vy1 = Voltage_to_Coordinate(vy_left);
		vx2 = Voltage_to_Coordinate(vx_right);
		vy2 = Voltage_to_Coordinate(vy_right);
		sw1 = Check_Joystick_Button(sw_left); //Returns 1 if pressed, 0 otherwise
		sw2 = Check_Joystick_Button(sw_right);

		//convert joystick input combo to motor [-20,20] for two motors
		//coarse and fine ctrl can use same function but just scaled diff
		//to combine coarse and fine just add both outputs but just weighed

		//store motor outputs in struct since function needs to output both
		//left and right motor outputs.

		//conversion to left and right motor commands
		Generate_Motor_Command(&mcmd1,vx1,vy1);
		Generate_Motor_Command(&mcmd2,vx2,vy2);
		Weigh_Dual_Inputs(&mcmd,&mcmd1,&mcmd2,0.2);

		// 20 20n
		//0123456
		// sprintf(tbuff,"%4d%3d\n",mcmd.left,mcmd.right);
		sprintf(tbuff,"%4d %3d\n",mcmd.left,mcmd.right);

		
		
		sendstr1(tbuff);
		printf(tbuff);
		//waitms_or_RI1(100);
		timeout = 0;
		while(1){ // check if there's data to recieve 
			if(RXU1()) break;
			Timer3us(100);
			timeout++;
			if(timeout>1000) break;
		}
		if(RXU1()){
			getstr1(rbuff);

		}
		sscanf(rbuff,"%d",&freq);
		printf("%d\n",freq);
		
		// printf("\033[A");
		// printf("\033[A");

		//0-1 rm 00 01 10 11
		//2 1-back 0-fwd
		//3-5 lm 00 01 10 11
		//5 1-back 0-fwd
		//6-7: 01

		//sprintf(buff, "%d,%d", xcmd,ycmd);
		//sendstr2(buff);
		// putchar1(left);
		// putchar1(right);
		// putchar1("\n");
		//sprintf(buff, "JDY40 test %d\r\n", cnt++);
		
		// putchar('.');
		//sendstr1(tbuff);
		//putchar1(position);
		//putchar1(tdata.lmotor);
		// waitms_or_RI1(200);
		
		// printf("vx1 pos: %3d, vy1 pos: %3d sw1: %d| vx2 pos: %3d, vy2 pos: %3d sw2: %d \n", vx1,vy1,sw1,vx2,vy2,sw2);
		// printf("motor L: %3d, motor R: %3d\n", mcmd.left, mcmd.right);
		// // printCharAsBinary(tdata.lmotor);
		// // printCharAsBinary(tdata.rmotor);
		// printf("RX: %s",rbuff);
		// printf("\033[A");
		// printf("\033[A");
		// printf("\033[A");

		x=(SYSCLK/(2L*f));
		TR2=0; // Stop timer 2
		TMR2RL=0x10000L-x; // Change reload value for new frequency
		TR2=1; // Start timer 2
		
		//waitms(200);
	}
}
