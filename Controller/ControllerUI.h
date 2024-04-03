#include <EFM8LB1.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
// #include <math.h>

#define SYSCLK 72000000L
#define SARCLK 18000000L
#define BAUDRATE 115200L
#define VDD 3.3035 // The measured value of VDD in volts
#define ATTENUATION 4

typedef struct{ 
    int left; 
	int right; // stores command info for left and right motor
}Motor;

/*
Maps Voltage from Joystick (float) to Joystick position values 
*/
int Voltage_to_Coordinate(float v){
	if(1.65 < v){
		return (int)((v-1.65)/(3.30-1.65)*20);
	}else if(1.65 > v){
		return (int)((1-v/1.65)*(-20));
	}else{
		return 0;
	}
}

char Check_Joystick_Button(float v){
	if(v != 0.0){
		return 0;
	}else{
		return 1;
	}
}


void Generate_Motor_Command(Motor* cmd, int x, int y){
	
	if((x==0) && (y==0)){
		cmd->left = 0;
		cmd->right = 0;
		return;
	}

	if(y >= 0){
		if(x > 0){
			if(x < y){
				cmd->left = y;
				cmd->right = y - x/2;
			}else if(x == y){
				cmd->left = y;
				cmd->right = y/2;
			}else{ //x > y
				cmd->left = x;
				cmd->right = y/2;
			}

		}else{ //x < 0
			x *= -1;
			if(x < y){
				cmd->left = y - x/2;
				cmd->right = y;
			}else if(x == y){
				cmd->left = y/2;
				cmd->right = y;
			}else{ //x > y
				cmd->left = y/2;
				cmd->right = x;
			}
		}

	}else{ //y < 0
		if((y<0) && (y>=-8)){ // check if position is in stall zone from y = [-8,0]

			if(x > 0){
				cmd->left = ((y+4)*(x))/4;
				cmd->right = 0;
			}else{//x < 0 
				cmd->left = 0;
				cmd->right = ((y+4)*(abs(x)))/4;
			}
		
		}else{ //y < -8

			if(x > 0){
				if(x < -1*y){
					cmd->left = y;
					cmd->right = y + x/2;
				}else if(x == -1*y){
					cmd->left = y;
					cmd->right = y/2;
				}else{ //x > -1*y
					cmd->left = -1*x;
					cmd->right = y/2;
				}

				// cmd->left += ATTENUATION;
				// cmd->right += ATTENUATION;

			}else{ //x < 0
				
				if(x > y){
					cmd->left = y - x/2;
					cmd->right = y;
				}else if(x == y){
					cmd->left = y/2;
					cmd->right = y;
				}else{ //x <>> y
					cmd->left = y/2;
					cmd->right = x;
				}

				// cmd->left += ATTENUATION;
				// cmd->right += ATTENUATION;
			}
		}
	}
}

void Generate_Pivot_Command(Motor* cmd, int y1, int y2){
	cmd->left = y1;
	cmd->right = y2;
}

void Weigh_Dual_Inputs(Motor* mout, Motor* m1, Motor* m2,float ratio){
	mout->left = (int)((m1->left)*(1-ratio)+(m2->left)*ratio);
	mout->right = (int)((m1->right)*(1-ratio)+(m2->right)*ratio);
}


void Wait_For_Calibration(){
	//ADC must be initialized before this function
	float b1, b2;

	while(1){
		b1 = Volts_at_Pin(QFP32_MUX_P2_6);
		b2 = Volts_at_Pin(QFP32_MUX_P2_1);
		if((b1 == 0.0) || (b2 == 0.0)){
			waitms(2000); //waits 2 seconds
		}
		if((b1 == 0.0) || (b2 == 0.0)){
			while((Volts_at_Pin(QFP32_MUX_P2_6) == 0.0)||(Volts_at_Pin(QFP32_MUX_P2_1) == 0.0));
			return;
		}
	}
}