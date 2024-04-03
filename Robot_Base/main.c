#include "../Common/Include/stm32l051xx.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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
volatile int lmotor = 0;
volatile int rmotor = 0;
char rbuff[20];
char tbuff[20];

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
	GPIOB->MODER |= (BIT0|BIT1);  // Select analog mode for PB0 (pin 14 of LQFP32 package)
	GPIOB->MODER |= (BIT2|BIT3);  // Select analog mode for PB1 (pin 15 of LQFP32 package)

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

	// Set up timer
	RCC->APB1ENR |= BIT0;  // turn on clock for timer2 (UM: page 177)
	TIM2->ARR = F_CPU/DEF_F-1;
	NVIC->ISER[0] |= BIT15; // enable timer 2 interrupts in the NVIC
	TIM2->CR1 |= BIT4;      // Downcounting    
	TIM2->CR1 |= BIT7;      // ARPE enable    
	TIM2->DIER |= BIT0;     // enable update event (reload event) interrupt 
	TIM2->CR1 |= BIT0;      // enable counting   

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

// decoder, takes 1 byte input 
void r_cont_decode(int n){
	if (n > 0){
		// move forward command
		ISR_pwm1 = 0;
		ISR_pwm2 = n * 5;
	} else {
		// move backwards
		ISR_pwm1 = n * 5;
		ISR_pwm2 = 0;
	}
}

// decoder, takes 1 byte input 
void l_cont_decode(int n){
	if (n > 0){
		// move forward command
		ISR_pwm3 = 0;
		ISR_pwm4 = (float)n * 4.75;
	} else {
		// move backwards
		ISR_pwm3 = (float)n * 4.75;
		ISR_pwm4 = 0;
	}
}

int main(void)
{
    int j, vl, vr;
	long int count;
	float T, f;
	int light_check = 1;

	Hardware_Init();
	initUART2(9600);
	waitms(500);

	//Set-up of unique device ID
	SendATCommand("AT+DVIDA0C4\r\n");  

	// To check configuration
	SendATCommand("AT+VER\r\n");
	SendATCommand("AT+BAUD\r\n");
	SendATCommand("AT+RFID\r\n");
	SendATCommand("AT+DVID\r\n");
	SendATCommand("AT+RFC\r\n");
	SendATCommand("AT+POWE\r\n");
	SendATCommand("AT+CLSS\r\n");
	
	waitms(500); // Give putty a chance to start before we send characters with printf()
			
	while (1)
	{	
		if(ReceivedBytes2()>0){
            egets2(rbuff, sizeof(rbuff)-1);
			sscanf(rbuff,"%d%d%d",&lmotor,&rmotor,&light_check);
//			eputs("\r\n");
//			PrintNumber((long int)f, 10, 6);
//			eputs("\r\n");
//			PrintNumber(lmotor, 10, 2);
//			eputs("\r\n");
//			PrintNumber(rmotor, 10, 2);
			count=GetPeriod(60);
			__enable_irq();
			if(count>0){
			// send frequency to controller
				f=(F_CPU*60)/count;
			sprintf(rbuff, "     %d", (int)f);
			eputs2(rbuff);				
			}
		}

		if (light_check == 1){
			// read from ADC at pin 14 (PB0) - left
			j=readADC(ADC_CHSELR_CHSEL8);
			vl=(j*33000)/0xfff;
			eputs("ADC[8]=0x");
			PrintNumber(j, 16, 4);
			eputs(", ");
			PrintNumber(vl/10000, 10, 1);
			eputc('.');
			PrintNumber(vl%10000, 10, 4);
			eputs("V ");

			// read from ADC at pin 15 (PB1) - right
			j=readADC(ADC_CHSELR_CHSEL9);
			vr=(j*33000)/0xfff;
			eputs("ADC[9]=0x");
			PrintNumber(j, 16, 4);
			eputs(", ");
			PrintNumber(vr/10000, 10, 1);
			eputc('.');
			PrintNumber(vr%10000, 10, 4);
			eputs("V ");
			eputs("\r\n");

			// v stores voltage * 10000
			if ((vl > 15000) && (vr > 15000)){
				// range of +- 0.1v
				if (vl > vr+1000){
					// turn left to equalize light
					l_cont_decode(10);
					r_cont_decode(0);
				} else if (vl < vr-1000){
					// turn right to equalize light
					l_cont_decode(0);
					r_cont_decode(10);
				} else {
					// robot should be facing towards light
					l_cont_decode(10);
					r_cont_decode(10);
				}
			} else {
				l_cont_decode(0);
				r_cont_decode(0);
			}

		} else {
			l_cont_decode(lmotor);
			r_cont_decode(rmotor);	
		}

		//waitms(25);	
	}
}
