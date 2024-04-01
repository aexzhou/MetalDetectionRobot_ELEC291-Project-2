#include "../Common/Include/stm32l051xx.h"
#include <stdio.h>
#include <stdlib.h>
#include "../Common/Include/serial.h"
#include "adc.h"
#include "UART2.h"

#define F_CPU 32000000L
#define DEF_F 100000L // 10us tick
#define avg_count 50 // number of frequency values to average
#define base_freq 5550 // base hz of the metal detector
#define SYSCLK 32000000L

volatile int pwm_count = 0;
volatile unsigned char ISR_pwm1=100, ISR_pwm2=75, ISR_pwm3=50, ISR_pwm4=25;

char buffr[20]; //buffer array to store data from sent from the remote control 

void wait_1ms(void)
{
	// For SysTick info check the STM32l0xxx Cortex-M0 programming manual.
	SysTick->LOAD = (F_CPU/1000L) - 1;  // set reload register, counter rolls over from zero, hence -1
	SysTick->VAL = 0; // load the SysTick counter
	SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk; // Enable SysTick IRQ and SysTick Timer */
	while((SysTick->CTRL & BIT16)==0); // Bit 16 is the COUNTFLAG.  True when counter rolls over from zero.
	SysTick->CTRL = 0x00; // Disable Systick counter
}

void waitms(int len)
{
	while(len--) wait_1ms();
}
 	
// Interrupt service routines are the same as normal
// subroutines (or C funtions) in Cortex-M microcontrollers.
// The following should happen at a rate of 1kHz.
// The following function is associated with the TIM2 interrupt 
// via the interrupt vector table defined in startup.c
void TIM2_Handler(void) 
{
	TIM2->SR &= ~BIT0; // clear update interrupt flag
	pwm_count++;
	if(pwm_count>100) pwm_count=0;

	if(ISR_pwm1>pwm_count)
	{
		GPIOA->ODR |= BIT0; // PA0=1, pin 6
	}
	else
	{
		GPIOA->ODR &= ~(BIT0); // PA0=0, pin 6
	}
	
	if(ISR_pwm2>pwm_count)
	{
		GPIOA->ODR |= BIT1; // PA1=1, pin 7
	}
	else
	{
		GPIOA->ODR &= ~(BIT1); // PA1=0, pin 7
	}
	
	if(ISR_pwm3>pwm_count)
	{
		GPIOA->ODR |= BIT2; // PA3=1, pin 8
	}
	else
	{
		GPIOA->ODR &= ~(BIT2); // PA3=0, pin 8
	}
	
	if(ISR_pwm4>pwm_count)
	{
		GPIOA->ODR |= BIT3; // PA4=1, pin 9
	}
	else
	{
		GPIOA->ODR &= ~(BIT3); // PA4=0, pin 9
	}  
}

// LQFP32 pinout
//                 ----------
//           VDD -|1       32|- VSS
//          PC14 -|2       31|- BOOT0
//          PC15 -|3       30|- PB7 (OUT 5)
//          NRST -|4       29|- PB6 (OUT 4)
//          VDDA -|5       28|- PB5 (OUT 3)
//    (pwm1) PA0 -|6       27|- PB4 (OUT 2)
//    (pwm2) PA1 -|7       26|- PB3 (OUT 1)
//    (pwm3) PA2 -|8       25|- PA15
//    (pwm4) PA3 -|9       24|- PA14 (push button)
//           PA4 -|10      23|- PA13
//           PA5 -|11      22|- PA12 
//           PA6 -|12      21|- PA11 
//           PA7 -|13      20|- PA10 (Reserved for RXD)
// (ADC_IN8) PB0 -|14      19|- PA9  (Reserved for TXD)
// (ADC_IN9) PB1 -|15      18|- PA8  (Measure the period at this pin)
//           VSS -|16      17|- VDD
//                 ----------

void Hardware_Init(void)
{
	RCC->IOPENR  |= (BIT1|BIT0);         // peripheral clock enable for ports A and B

	// Configure the pin used for analog input: PB0 and PB1 (pins 14 and 15)
	// GPIOB->MODER |= (BIT0|BIT1);  // Select analog mode for PB0 (pin 14 of LQFP32 package)
	// GPIOB->MODER |= (BIT2|BIT3);  // Select analog mode for PB1 (pin 15 of LQFP32 package)

	GPIOA->MODER = (GPIOA->MODER & ~(BIT1)) | BIT0; // Make pin PA0 output (page 200 of RM0451, two bits used to configure: bit0=1, bit1=0)
	GPIOA->MODER = (GPIOA->MODER & ~(BIT3)) | BIT2;
	GPIOA->MODER = (GPIOA->MODER & ~(BIT5)) | BIT4;
	GPIOA->MODER = (GPIOA->MODER & ~(BIT7)) | BIT6;

	initADC();
	
	// Configure the pin used to measure period
	GPIOA->MODER &= ~(BIT16 | BIT17); // Make pin PA8 input
	// Activate pull up for pin PA8:
	GPIOA->PUPDR |= BIT16; 
	GPIOA->PUPDR &= ~(BIT17);
	
	// Configure the pin connected to the pushbutton as input
	GPIOA->MODER &= ~(BIT28 | BIT29); // Make pin PA14 input
	// Activate pull up for pin PA8:
	GPIOA->PUPDR |= BIT28; 
	GPIOA->PUPDR &= ~(BIT29);
	
	// Configure some pins as outputs:
	// Make pins PB3 to PB7 outputs (page 200 of RM0451, two bits used to configure: bit0=1, bit1=0)
    GPIOB->MODER = (GPIOB->MODER & ~(BIT6|BIT7)) | BIT6;    // PB3
	GPIOB->OTYPER &= ~BIT3; // Push-pull
    GPIOB->MODER = (GPIOB->MODER & ~(BIT8|BIT9)) | BIT8;    // PB4
	GPIOB->OTYPER &= ~BIT4; // Push-pull
    GPIOB->MODER = (GPIOB->MODER & ~(BIT10|BIT11)) | BIT10; // PB5
	GPIOB->OTYPER &= ~BIT5; // Push-pull
    GPIOB->MODER = (GPIOB->MODER & ~(BIT12|BIT13)) | BIT12; // PB6
	GPIOB->OTYPER &= ~BIT6; // Push-pull
    GPIOB->MODER = (GPIOB->MODER & ~(BIT14|BIT15)) | BIT14;  // PB7
	GPIOB->OTYPER &= ~BIT7; // Push-pull
	
	// Set up servo PWM output pins
    // GPIOA->MODER = (GPIOA->MODER & ~(BIT22|BIT23)) | BIT22; // Make pin PA11 output (page 200 of RM0451, two bits used to configure: bit0=1, bit1=0)
	// GPIOA->OTYPER &= ~BIT11; // Push-pull
    // GPIOA->MODER = (GPIOA->MODER & ~(BIT24|BIT25)) | BIT24; // Make pin PA12 output (page 200 of RM0451, two bits used to configure: bit0=1, bit1=0)
	// GPIOA->OTYPER &= ~BIT12; // Push-pull

	// Set up timer
	RCC->APB1ENR |= BIT0;  // turn on clock for timer2 (UM: page 177)
	TIM2->ARR = F_CPU/DEF_F-1;
	NVIC->ISER[0] |= BIT15; // enable timer 2 interrupts in the NVIC
	TIM2->CR1 |= BIT4;      // Downcounting    
	TIM2->CR1 |= BIT7;      // ARPE enable    
	TIM2->DIER |= BIT0;     // enable update event (reload event) interrupt 
	TIM2->CR1 |= BIT0;      // enable counting   

	// // Set up Timer 3
	// RCC->APB1ENR1 |= BIT1;  // Turn on clock for Timer 3 (Timer 3 is on APB1ENR1, not APB1ENR)
	// TIM3->ARR = F_CPU / DEF_F - 1;
	// NVIC->ISER[0] |= BIT29; // Enable Timer 3 interrupts in the NVIC (TIM3 is on TIM3_IRQn, which corresponds to interrupt 29)
	// TIM3->CR1 |= BIT4;      // Downcounting    
	// TIM3->CR1 |= BIT7;      // ARPE enable    
	// TIM3->DIER |= BIT0;     // Enable update event (reload event) interrupt 
	// TIM3->CR1 |= BIT0;      // Enable counting  

	// JDY initializations
	GPIOA->OSPEEDR=0xffffffff; // All pins of port A configured for very high speed! Page 201 of RM0451

	RCC->IOPENR |= BIT0; // peripheral clock enable for port A

    GPIOA->MODER = (GPIOA->MODER & ~(BIT27|BIT26)) | BIT26; // Make pin PA13 output (page 200 of RM0451, two bits used to configure: bit0=1, bit1=0))
	GPIOA->ODR |= BIT13; // 'set' pin to 1 is normal operation mode.

	GPIOA->MODER &= ~(BIT22 | BIT23); // Make pin PA11 input
	// Activate pull up for pin PA11:
	GPIOA->PUPDR |= BIT22; 
	GPIOA->PUPDR &= ~(BIT23);
	
	__enable_irq();
}

void SendATCommand (char * s)
{
	char buff[40];
	printf("Command: %s", s);
	GPIOA->ODR &= ~(BIT13); // 'set' pin to 0 is 'AT' mode.
	waitms(10);
	eputs2(s);
	egets2(buff, sizeof(buff)-1);
	GPIOA->ODR |= BIT13; // 'set' pin to 1 is normal operation mode.
	waitms(10);
	
	printf("Response: %s", buff);
}

// A define to easily read PA8 (PA8 must be configured as input first)
#define PA8 (GPIOA->IDR & BIT8)

long int GetPeriod (int n)
{
	int i;
	unsigned int saved_TCNT1a, saved_TCNT1b;
	
	SysTick->LOAD = 0xffffff;  // 24-bit counter set to check for signal present
	SysTick->VAL = 0xffffff; // load the SysTick counter
	SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk; // Enable SysTick IRQ and SysTick Timer */
	while (PA8!=0) // Wait for square wave to be 0
	{
		if(SysTick->CTRL & BIT16) return 0;
	}
	SysTick->CTRL = 0x00; // Disable Systick counter

	SysTick->LOAD = 0xffffff;  // 24-bit counter set to check for signal present
	SysTick->VAL = 0xffffff; // load the SysTick counter
	SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk; // Enable SysTick IRQ and SysTick Timer */
	while (PA8==0) // Wait for square wave to be 1
	{
		if(SysTick->CTRL & BIT16) return 0;
	}
	SysTick->CTRL = 0x00; // Disable Systick counter
	
	SysTick->LOAD = 0xffffff;  // 24-bit counter reset
	SysTick->VAL = 0xffffff; // load the SysTick counter to initial value
	SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk; // Enable SysTick IRQ and SysTick Timer */
	for(i=0; i<n; i++) // Measure the time of 'n' periods
	{
		while (PA8!=0) // Wait for square wave to be 0
		{
			if(SysTick->CTRL & BIT16) return 0;
		}
		while (PA8==0) // Wait for square wave to be 1
		{
			if(SysTick->CTRL & BIT16) return 0;
		}
	}
	SysTick->CTRL = 0x00; // Disable Systick counter

	return 0xffffff-SysTick->VAL;
}

void PrintNumber(long int val, int Base, int digits)
{ 
	char HexDigit[]="0123456789ABCDEF";
	int j;
	#define NBITS 32
	char buff[NBITS+1];
	buff[NBITS]=0;

	j=NBITS-1;
	while ( (val>0) | (digits>0) )
	{
		buff[j--]=HexDigit[val%Base];
		val/=Base;
		if(digits!=0) digits--;
	}
	eputs(&buff[j+1]);
}

// Some 'defines' to turn pins on/off easily (pins must be configured as outputs)
#define PB3_0 (GPIOB->ODR &= ~BIT3)
#define PB3_1 (GPIOB->ODR |=  BIT3)
#define PB4_0 (GPIOB->ODR &= ~BIT4)
#define PB4_1 (GPIOB->ODR |=  BIT4)
#define PB5_0 (GPIOB->ODR &= ~BIT5)
#define PB5_1 (GPIOB->ODR |=  BIT5)
#define PB6_0 (GPIOB->ODR &= ~BIT6)
#define PB6_1 (GPIOB->ODR |=  BIT6)
#define PB7_0 (GPIOB->ODR &= ~BIT7)
#define PB7_1 (GPIOB->ODR |=  BIT7)

// A define to easily read PA14 (PA14 must be configured as input first)
#define PA14 (GPIOA->IDR & BIT14)


// MOVEMENT COMMANDS
// pwm_1, pwm_2 for left
// pwm_3, pwm_4 for right

/* input is two 1 byte controls, one for each motor
 [	7		6		5		4		3		2		1		0		] 
---/RESERVED/--- fwd/bwd   -----------------MAGNITUDE----------------
				   0/1						  0->20
*/

// decoder, takes 1 byte input 
void r_cont_decode(int n){
	if (n > 0){
		// move forward command
		ISR_pwm1 = 0;
		ISR_pwm2 = (float)n * 4.75;
	} else {
		// move backwards
		ISR_pwm1 = (float)n * 4.75;
		ISR_pwm2 = 0;
	}
}

// decoder, takes 1 byte input 
void l_cont_decode(int n){
	if (n > 0){
		// move forward command
		ISR_pwm3 = 0;
		ISR_pwm4 = n * 5;
	} else {
		// move backwards
		ISR_pwm3 = n * 5;
		ISR_pwm4 = 0;
	}
}

void printCharAsBinary(char c) {
	int i = 0;
	char out;

    for (i = 7; i >= 0; i--) {
        out = (c >> i) & 1; // Shift right i bits, and mask all but the least significant bit
        PrintNumber(out, 10, 1);
    }
    //eputs("\r\n"); // Move to a new line after printing the binary representation
}

int char2int(char encoded) {
    int sign = (encoded & 0x20) ? -1 : 1; // Check bit 5 for sign. Negative if set.
    int magnitude = encoded & 0x1F; // Extract the magnitude from bits 0-4.
    return sign * magnitude;
}

// Function to calculate the rolling average of past 100 values
float rolling_average(float new_value, float *buffer, int *index, int size) {
    static float sum = 0;

    // Subtract the oldest value from the sum
    sum -= buffer[*index];
    // Add the new value to the sum
    sum += new_value;
    // Store the new value in the buffer
    buffer[*index] = new_value;
    // Increment index (with wraparound)
    *index = (*index + 1) % size;

    // Return the rolling average
    return sum / size;
}

int main(void)
{
    int j, v;
	long int count;
	unsigned char LED_toggle=0; // Used to test the outputs
	float T, f, f_avg, f_new;
	int f_counter;
	int freq_index = 0;
	float freq_buffer[avg_count] = {0};
	int lmotor = 0;
	int rmotor = 0;
	int r_prev = 0;
	int l_prev = 0;

	Hardware_Init();
	initUART2(9600);
	waitms(500);

	//Set-up of unique device ID
	SendATCommand("AT+DVID1359\r\n");  

	// To check configuration
	SendATCommand("AT+VER\r\n");
	SendATCommand("AT+BAUD\r\n");
	SendATCommand("AT+RFID\r\n");
	SendATCommand("AT+DVID\r\n");
	SendATCommand("AT+RFC\r\n");
	SendATCommand("AT+POWE\r\n");
	SendATCommand("AT+CLSS\r\n");
	
	
	waitms(500); // Give putty a chance to start before we send characters with printf()
	eputs("\x1b[2J\x1b[1;1H"); // Clear screen using ANSI escape sequence.
	eputs("\r\nSTM32L051 multi I/O example.\r\n");
	eputs("Measures the voltage from ADC channels 8 and 9 (pins 14 and 15 of LQFP32 package)\r\n");
	eputs("Measures period on PA8 (pin 18 of LQFP32 package)\r\n");
	eputs("Toggles PB3, PB4, PB5, PB6, PB7 (pins 26, 27, 28, 29, 30 of LQFP32 package)\r\n");
	eputs("Generates servo PWMs on PA0, PA1, PA2, PA3 (pins 6, 7, 8, 9 of LQFP32 package)\r\n");
	eputs("Reads the push-button on pin PA14 (pin 24 of LQFP32 package)\r\n\r\n");

    LED_toggle=0;
	PB3_0;
	PB4_0;
	PB5_0;
	PB6_0;
	PB7_0;
					
	while (1)
	{
		if(ReceivedBytes2()>0) //something has arrived
		{
			egets2(buffr, sizeof(buffr)-1);

			lmotor = char2int(buffr[0]);
			rmotor = char2int(buffr[1]);

			/*
			egets2(buffr, sizeof(buffr)-1);
			printCharAsBinary(buffr[0]);
			printCharAsBinary(buffr[1]);

			lmotor = char2int(buffr[0]);
			rmotor = char2int(buffr[1]);
			eputs("\r\n		l: ");
			PrintNumber(lmotor, 10, 2);
			eputs("		r: ");
			PrintNumber(rmotor, 10, 2);
			eputs("\r\n");
			*/
		}


/*	
		j=readADC(ADC_CHSELR_CHSEL8);
		v=(j*33000)/0xfff;
		eputs("ADC[8]=0x");
		PrintNumber(j, 16, 4);
		eputs(", ");
		PrintNumber(v/10000, 10, 1);
		eputc('.');
		PrintNumber(v%10000, 10, 4);
		eputs("V ");;

		j=readADC(ADC_CHSELR_CHSEL9);
		v=(j*33000)/0xfff;
		eputs("ADC[9]=0x");
		PrintNumber(j, 16, 4);
		eputs(", ");
		PrintNumber(v/10000, 10, 1);
		eputc('.');
		PrintNumber(v%10000, 10, 4);
		eputs("V ");
		
		eputs("PA14=");
		if(PA14)
		{
			eputs("1 ");
		}
		else
		{
			eputs("0 ");
		}
*/
		// Not very good for high frequencies because of all the interrupts in the background
		// but decent for low frequencies around 10kHz.
		count=GetPeriod(60);
		if(count>0)
		{
			f=(F_CPU*60)/count;
			// eputs("f=");
			// PrintNumber(f, 10, 7);
			// eputs("Hz, count=");
			// PrintNumber(count, 10, 6);
			// eputs("          \r\n\r\n");
		}
		else
		{
			eputs("NO SIGNAL                     \r");
		}

		// Now turn on one of outputs per cycle to check
		switch (LED_toggle++)
		{
			case 0:
				PB3_1;
				break;
			case 1:
				PB4_1;
				break;
			case 2:
				PB5_1;
				break;
			case 3:
				PB6_1;
				break;
			case 4:
				PB7_1;
				break;
			default:
			    LED_toggle=0;
				PB3_0;
				PB4_0;
				PB5_0;
				PB6_0;
				PB7_0;
				break;
		}
		
		// TAKE AVERAGE OF FREQUENCY
		// f_avg = rolling_average(f, freq_buffer, &freq_index, avg_count);
		
		// eputs("\r\n		f count = ");
		// PrintNumber(freq_index, 10, 5);
		// eputs("\r\n		f avg = ");
		// PrintNumber(f_avg, 10, 7);
		// eputs("\r\n");

		// // check for changes in frequency (note frequency only goes up with metal detection)
		// if (f_avg > base_freq+10){
		// 	eputs("Metal Detected\r\n");
		// }

		if ((r_prev != rmotor) && (rmotor == 10)){
			rmotor = 0;
		}

		if ((l_prev != lmotor) && (lmotor == 10)){
			lmotor = 0;
		}

		l_cont_decode(rmotor);
		r_cont_decode(lmotor);

		r_prev = rmotor;
		l_prev = lmotor;

		//waitms(25);	
	}
}
