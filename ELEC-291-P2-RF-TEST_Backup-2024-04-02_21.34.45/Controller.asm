;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1170 (Feb 16 2022) (MSVC)
; This file was generated Wed Apr 03 18:41:35 2024
;--------------------------------------------------------
$name Controller
$optc51 --model-small
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _Generate_Pivot_Command_PARM_3
	public _Generate_Pivot_Command_PARM_2
	public _main
	public _printCharAsBinary
	public _getsn
	public _LCDprint
	public _LCD_4BIT
	public _WriteCommand
	public _WriteData
	public _LCD_byte
	public _LCD_pulse
	public _Wait_For_Calibration
	public _Weigh_Dual_Inputs
	public _Generate_Pivot_Command
	public _Generate_Motor_Command
	public _Check_Joystick_Button
	public _Voltage_to_Coordinate
	public _Package_Signed_int
	public _SendATCommand
	public _waitms_or_RI1
	public _RXU1
	public _getstr1
	public _getchar1_with_timeout
	public _getchar1
	public _sendstr2
	public _sendstr1
	public _putchar1
	public _UART1_Init
	public _waitms
	public _Timer3us
	public _Volts_at_Pin
	public _ADC_at_Pin
	public _InitPinADC
	public _InitADC
	public __c51_external_startup
	public _buff
	public _LCDprint_PARM_3
	public _mcmd
	public _mcmd2
	public _mcmd1
	public _rbuff
	public _tbuff
	public _t
	public _getsn_PARM_2
	public _LCDprint_PARM_2
	public _Weigh_Dual_Inputs_PARM_4
	public _Weigh_Dual_Inputs_PARM_3
	public _Weigh_Dual_Inputs_PARM_2
	public _Generate_Motor_Command_PARM_3
	public _Generate_Motor_Command_PARM_2
	public _InitPinADC_PARM_2
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_ADC0ASAH       DATA 0xb6
_ADC0ASAL       DATA 0xb5
_ADC0ASCF       DATA 0xa1
_ADC0ASCT       DATA 0xc7
_ADC0CF0        DATA 0xbc
_ADC0CF1        DATA 0xb9
_ADC0CF2        DATA 0xdf
_ADC0CN0        DATA 0xe8
_ADC0CN1        DATA 0xb2
_ADC0CN2        DATA 0xb3
_ADC0GTH        DATA 0xc4
_ADC0GTL        DATA 0xc3
_ADC0H          DATA 0xbe
_ADC0L          DATA 0xbd
_ADC0LTH        DATA 0xc6
_ADC0LTL        DATA 0xc5
_ADC0MX         DATA 0xbb
_B              DATA 0xf0
_CKCON0         DATA 0x8e
_CKCON1         DATA 0xa6
_CLEN0          DATA 0xc6
_CLIE0          DATA 0xc7
_CLIF0          DATA 0xe8
_CLKSEL         DATA 0xa9
_CLOUT0         DATA 0xd1
_CLU0CF         DATA 0xb1
_CLU0FN         DATA 0xaf
_CLU0MX         DATA 0x84
_CLU1CF         DATA 0xb3
_CLU1FN         DATA 0xb2
_CLU1MX         DATA 0x85
_CLU2CF         DATA 0xb6
_CLU2FN         DATA 0xb5
_CLU2MX         DATA 0x91
_CLU3CF         DATA 0xbf
_CLU3FN         DATA 0xbe
_CLU3MX         DATA 0xae
_CMP0CN0        DATA 0x9b
_CMP0CN1        DATA 0x99
_CMP0MD         DATA 0x9d
_CMP0MX         DATA 0x9f
_CMP1CN0        DATA 0xbf
_CMP1CN1        DATA 0xac
_CMP1MD         DATA 0xab
_CMP1MX         DATA 0xaa
_CRC0CN0        DATA 0xce
_CRC0CN1        DATA 0x86
_CRC0CNT        DATA 0xd3
_CRC0DAT        DATA 0xcb
_CRC0FLIP       DATA 0xcf
_CRC0IN         DATA 0xca
_CRC0ST         DATA 0xd2
_DAC0CF0        DATA 0x91
_DAC0CF1        DATA 0x92
_DAC0H          DATA 0x85
_DAC0L          DATA 0x84
_DAC1CF0        DATA 0x93
_DAC1CF1        DATA 0x94
_DAC1H          DATA 0x8a
_DAC1L          DATA 0x89
_DAC2CF0        DATA 0x95
_DAC2CF1        DATA 0x96
_DAC2H          DATA 0x8c
_DAC2L          DATA 0x8b
_DAC3CF0        DATA 0x9a
_DAC3CF1        DATA 0x9c
_DAC3H          DATA 0x8e
_DAC3L          DATA 0x8d
_DACGCF0        DATA 0x88
_DACGCF1        DATA 0x98
_DACGCF2        DATA 0xa2
_DERIVID        DATA 0xad
_DEVICEID       DATA 0xb5
_DPH            DATA 0x83
_DPL            DATA 0x82
_EIE1           DATA 0xe6
_EIE2           DATA 0xf3
_EIP1           DATA 0xbb
_EIP1H          DATA 0xee
_EIP2           DATA 0xed
_EIP2H          DATA 0xf6
_EMI0CN         DATA 0xe7
_FLKEY          DATA 0xb7
_HFO0CAL        DATA 0xc7
_HFO1CAL        DATA 0xd6
_HFOCN          DATA 0xef
_I2C0ADM        DATA 0xff
_I2C0CN0        DATA 0xba
_I2C0DIN        DATA 0xbc
_I2C0DOUT       DATA 0xbb
_I2C0FCN0       DATA 0xad
_I2C0FCN1       DATA 0xab
_I2C0FCT        DATA 0xf5
_I2C0SLAD       DATA 0xbd
_I2C0STAT       DATA 0xb9
_IE             DATA 0xa8
_IP             DATA 0xb8
_IPH            DATA 0xf2
_IT01CF         DATA 0xe4
_LFO0CN         DATA 0xb1
_P0             DATA 0x80
_P0MASK         DATA 0xfe
_P0MAT          DATA 0xfd
_P0MDIN         DATA 0xf1
_P0MDOUT        DATA 0xa4
_P0SKIP         DATA 0xd4
_P1             DATA 0x90
_P1MASK         DATA 0xee
_P1MAT          DATA 0xed
_P1MDIN         DATA 0xf2
_P1MDOUT        DATA 0xa5
_P1SKIP         DATA 0xd5
_P2             DATA 0xa0
_P2MASK         DATA 0xfc
_P2MAT          DATA 0xfb
_P2MDIN         DATA 0xf3
_P2MDOUT        DATA 0xa6
_P2SKIP         DATA 0xcc
_P3             DATA 0xb0
_P3MDIN         DATA 0xf4
_P3MDOUT        DATA 0x9c
_PCA0CENT       DATA 0x9e
_PCA0CLR        DATA 0x9c
_PCA0CN0        DATA 0xd8
_PCA0CPH0       DATA 0xfc
_PCA0CPH1       DATA 0xea
_PCA0CPH2       DATA 0xec
_PCA0CPH3       DATA 0xf5
_PCA0CPH4       DATA 0x85
_PCA0CPH5       DATA 0xde
_PCA0CPL0       DATA 0xfb
_PCA0CPL1       DATA 0xe9
_PCA0CPL2       DATA 0xeb
_PCA0CPL3       DATA 0xf4
_PCA0CPL4       DATA 0x84
_PCA0CPL5       DATA 0xdd
_PCA0CPM0       DATA 0xda
_PCA0CPM1       DATA 0xdb
_PCA0CPM2       DATA 0xdc
_PCA0CPM3       DATA 0xae
_PCA0CPM4       DATA 0xaf
_PCA0CPM5       DATA 0xcc
_PCA0H          DATA 0xfa
_PCA0L          DATA 0xf9
_PCA0MD         DATA 0xd9
_PCA0POL        DATA 0x96
_PCA0PWM        DATA 0xf7
_PCON0          DATA 0x87
_PCON1          DATA 0xcd
_PFE0CN         DATA 0xc1
_PRTDRV         DATA 0xf6
_PSCTL          DATA 0x8f
_PSTAT0         DATA 0xaa
_PSW            DATA 0xd0
_REF0CN         DATA 0xd1
_REG0CN         DATA 0xc9
_REVID          DATA 0xb6
_RSTSRC         DATA 0xef
_SBCON1         DATA 0x94
_SBRLH1         DATA 0x96
_SBRLL1         DATA 0x95
_SBUF           DATA 0x99
_SBUF0          DATA 0x99
_SBUF1          DATA 0x92
_SCON           DATA 0x98
_SCON0          DATA 0x98
_SCON1          DATA 0xc8
_SFRPAGE        DATA 0xa7
_SFRPGCN        DATA 0xbc
_SFRSTACK       DATA 0xd7
_SMB0ADM        DATA 0xd6
_SMB0ADR        DATA 0xd7
_SMB0CF         DATA 0xc1
_SMB0CN0        DATA 0xc0
_SMB0DAT        DATA 0xc2
_SMB0FCN0       DATA 0xc3
_SMB0FCN1       DATA 0xc4
_SMB0FCT        DATA 0xef
_SMB0RXLN       DATA 0xc5
_SMB0TC         DATA 0xac
_SMOD1          DATA 0x93
_SP             DATA 0x81
_SPI0CFG        DATA 0xa1
_SPI0CKR        DATA 0xa2
_SPI0CN0        DATA 0xf8
_SPI0DAT        DATA 0xa3
_SPI0FCN0       DATA 0x9a
_SPI0FCN1       DATA 0x9b
_SPI0FCT        DATA 0xf7
_SPI0PCF        DATA 0xdf
_TCON           DATA 0x88
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TMOD           DATA 0x89
_TMR2CN0        DATA 0xc8
_TMR2CN1        DATA 0xfd
_TMR2H          DATA 0xcf
_TMR2L          DATA 0xce
_TMR2RLH        DATA 0xcb
_TMR2RLL        DATA 0xca
_TMR3CN0        DATA 0x91
_TMR3CN1        DATA 0xfe
_TMR3H          DATA 0x95
_TMR3L          DATA 0x94
_TMR3RLH        DATA 0x93
_TMR3RLL        DATA 0x92
_TMR4CN0        DATA 0x98
_TMR4CN1        DATA 0xff
_TMR4H          DATA 0xa5
_TMR4L          DATA 0xa4
_TMR4RLH        DATA 0xa3
_TMR4RLL        DATA 0xa2
_TMR5CN0        DATA 0xc0
_TMR5CN1        DATA 0xf1
_TMR5H          DATA 0xd5
_TMR5L          DATA 0xd4
_TMR5RLH        DATA 0xd3
_TMR5RLL        DATA 0xd2
_UART0PCF       DATA 0xd9
_UART1FCN0      DATA 0x9d
_UART1FCN1      DATA 0xd8
_UART1FCT       DATA 0xfa
_UART1LIN       DATA 0x9e
_UART1PCF       DATA 0xda
_VDM0CN         DATA 0xff
_WDTCN          DATA 0x97
_XBR0           DATA 0xe1
_XBR1           DATA 0xe2
_XBR2           DATA 0xe3
_XOSC0CN        DATA 0x86
_DPTR           DATA 0x8382
_TMR2RL         DATA 0xcbca
_TMR3RL         DATA 0x9392
_TMR4RL         DATA 0xa3a2
_TMR5RL         DATA 0xd3d2
_TMR0           DATA 0x8c8a
_TMR1           DATA 0x8d8b
_TMR2           DATA 0xcfce
_TMR3           DATA 0x9594
_TMR4           DATA 0xa5a4
_TMR5           DATA 0xd5d4
_SBRL1          DATA 0x9695
_PCA0           DATA 0xfaf9
_PCA0CP0        DATA 0xfcfb
_PCA0CP1        DATA 0xeae9
_PCA0CP2        DATA 0xeceb
_PCA0CP3        DATA 0xf5f4
_PCA0CP4        DATA 0x8584
_PCA0CP5        DATA 0xdedd
_ADC0ASA        DATA 0xb6b5
_ADC0GT         DATA 0xc4c3
_ADC0           DATA 0xbebd
_ADC0LT         DATA 0xc6c5
_DAC0           DATA 0x8584
_DAC1           DATA 0x8a89
_DAC2           DATA 0x8c8b
_DAC3           DATA 0x8e8d
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_TEMPE          BIT 0xe8
_ADGN0          BIT 0xe9
_ADGN1          BIT 0xea
_ADWINT         BIT 0xeb
_ADBUSY         BIT 0xec
_ADINT          BIT 0xed
_IPOEN          BIT 0xee
_ADEN           BIT 0xef
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_C0FIF          BIT 0xe8
_C0RIF          BIT 0xe9
_C1FIF          BIT 0xea
_C1RIF          BIT 0xeb
_C2FIF          BIT 0xec
_C2RIF          BIT 0xed
_C3FIF          BIT 0xee
_C3RIF          BIT 0xef
_D1SRC0         BIT 0x88
_D1SRC1         BIT 0x89
_D1AMEN         BIT 0x8a
_D01REFSL       BIT 0x8b
_D3SRC0         BIT 0x8c
_D3SRC1         BIT 0x8d
_D3AMEN         BIT 0x8e
_D23REFSL       BIT 0x8f
_D0UDIS         BIT 0x98
_D1UDIS         BIT 0x99
_D2UDIS         BIT 0x9a
_D3UDIS         BIT 0x9b
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES0            BIT 0xac
_ET2            BIT 0xad
_ESPI0          BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS0            BIT 0xbc
_PT2            BIT 0xbd
_PSPI0          BIT 0xbe
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_7           BIT 0xb7
_CCF0           BIT 0xd8
_CCF1           BIT 0xd9
_CCF2           BIT 0xda
_CCF3           BIT 0xdb
_CCF4           BIT 0xdc
_CCF5           BIT 0xdd
_CR             BIT 0xde
_CF             BIT 0xdf
_PARITY         BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_CE             BIT 0x9d
_SMODE          BIT 0x9e
_RI1            BIT 0xc8
_TI1            BIT 0xc9
_RBX1           BIT 0xca
_TBX1           BIT 0xcb
_REN1           BIT 0xcc
_PERR1          BIT 0xcd
_OVR1           BIT 0xce
_SI             BIT 0xc0
_ACK            BIT 0xc1
_ARBLOST        BIT 0xc2
_ACKRQ          BIT 0xc3
_STO            BIT 0xc4
_STA            BIT 0xc5
_TXMODE         BIT 0xc6
_MASTER         BIT 0xc7
_SPIEN          BIT 0xf8
_TXNF           BIT 0xf9
_NSSMD0         BIT 0xfa
_NSSMD1         BIT 0xfb
_RXOVRN         BIT 0xfc
_MODF           BIT 0xfd
_WCOL           BIT 0xfe
_SPIF           BIT 0xff
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_T2XCLK0        BIT 0xc8
_T2XCLK1        BIT 0xc9
_TR2            BIT 0xca
_T2SPLIT        BIT 0xcb
_TF2CEN         BIT 0xcc
_TF2LEN         BIT 0xcd
_TF2L           BIT 0xce
_TF2H           BIT 0xcf
_T4XCLK0        BIT 0x98
_T4XCLK1        BIT 0x99
_TR4            BIT 0x9a
_T4SPLIT        BIT 0x9b
_TF4CEN         BIT 0x9c
_TF4LEN         BIT 0x9d
_TF4L           BIT 0x9e
_TF4H           BIT 0x9f
_T5XCLK0        BIT 0xc0
_T5XCLK1        BIT 0xc1
_TR5            BIT 0xc2
_T5SPLIT        BIT 0xc3
_TF5CEN         BIT 0xc4
_TF5LEN         BIT 0xc5
_TF5L           BIT 0xc6
_TF5H           BIT 0xc7
_RIE            BIT 0xd8
_RXTO0          BIT 0xd9
_RXTO1          BIT 0xda
_RFRQ           BIT 0xdb
_TIE            BIT 0xdc
_TXHOLD         BIT 0xdd
_TXNF1          BIT 0xde
_TFRQ           BIT 0xdf
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_InitPinADC_PARM_2:
	ds 1
_Generate_Motor_Command_PARM_2:
	ds 2
_Generate_Motor_Command_PARM_3:
	ds 2
_Generate_Motor_Command_sloc0_1_0:
	ds 3
_Weigh_Dual_Inputs_PARM_2:
	ds 3
_Weigh_Dual_Inputs_PARM_3:
	ds 3
_Weigh_Dual_Inputs_PARM_4:
	ds 4
_Weigh_Dual_Inputs_mout_1_144:
	ds 3
_Weigh_Dual_Inputs_sloc0_1_0:
	ds 2
_Weigh_Dual_Inputs_sloc1_1_0:
	ds 3
_Weigh_Dual_Inputs_sloc2_1_0:
	ds 4
_Weigh_Dual_Inputs_sloc3_1_0:
	ds 3
_LCDprint_PARM_2:
	ds 1
_getsn_PARM_2:
	ds 2
_getsn_buff_1_162:
	ds 3
_getsn_sloc0_1_0:
	ds 2
_t:
	ds 2
_main_vx_right_1_171:
	ds 4
_main_sw_right_1_171:
	ds 4
_main_vx_left_1_171:
	ds 4
_main_vy_left_1_171:
	ds 4
_main_sw_left_1_171:
	ds 4
_main_vx1_1_171:
	ds 2
_main_vy1_1_171:
	ds 2
_main_freq_1_171:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_Generate_Pivot_Command_PARM_2:
	ds 2
_Generate_Pivot_Command_PARM_3:
	ds 2
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
_tbuff:
	ds 20
_rbuff:
	ds 20
_mcmd1:
	ds 4
_mcmd2:
	ds 4
_mcmd:
	ds 4
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_LCDprint_PARM_3:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
_buff:
	ds 20
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
;	Controller.c:7: int t = 0; //global variable, used to reduce the speed for timer4 isr
	clr	a
	mov	_t,a
	mov	(_t + 1),a
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	ControllerCore.h:31: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	ControllerCore.h:34: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	ControllerCore.h:35: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	ControllerCore.h:36: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	ControllerCore.h:38: VDM0CN=0x80;       // enable VDD monitor
	mov	_VDM0CN,#0x80
;	ControllerCore.h:39: RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD
	mov	_RSTSRC,#0x06
;	ControllerCore.h:46: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	ControllerCore.h:47: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	ControllerCore.h:48: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	ControllerCore.h:69: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	ControllerCore.h:70: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	ControllerCore.h:71: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	ControllerCore.h:72: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	ControllerCore.h:73: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	ControllerCore.h:74: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	ControllerCore.h:79: P0MDOUT |= 0x11; // Enable UART0 TX (P0.4) and UART1 TX (P0.0) as push-pull outputs
	orl	_P0MDOUT,#0x11
;	ControllerCore.h:80: P3MDOUT |= 0x08; // P2.1 in push-pull mode
	orl	_P3MDOUT,#0x08
;	ControllerCore.h:81: XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	mov	_XBR0,#0x01
;	ControllerCore.h:82: XBR1     = 0X00;
	mov	_XBR1,#0x00
;	ControllerCore.h:83: XBR2     = 0x41; // Enable crossbar and uart 1
	mov	_XBR2,#0x41
;	ControllerCore.h:89: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	ControllerCore.h:90: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	ControllerCore.h:91: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	ControllerCore.h:92: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	ControllerCore.h:93: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	ControllerCore.h:94: TR1 = 1; // START Timer1
	setb	_TR1
;	ControllerCore.h:95: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	ControllerCore.h:98: SFRPAGE=0x10;
	mov	_SFRPAGE,#0x10
;	ControllerCore.h:99: TMR4CN0=0x00;   // Stop Timer4; Clear TF4; WARNING: lives in SFR page 0x10
	mov	_TMR4CN0,#0x00
;	ControllerCore.h:100: CKCON1|=0b_0000_0001; // Timer 4 uses the system clock
	orl	_CKCON1,#0x01
;	ControllerCore.h:101: TMR4RL=(0x10000L-(SYSCLK/(2*TIMER_4_FREQ))); // Initialize reload value
	mov	_TMR4RL,#0x60
	mov	(_TMR4RL >> 8),#0x73
;	ControllerCore.h:102: TMR4=0xffff;   // Set to reload immediately
	mov	_TMR4,#0xFF
	mov	(_TMR4 >> 8),#0xFF
;	ControllerCore.h:103: EIE2|=0b_0000_0100;     // Enable Timer4 interrupts
	orl	_EIE2,#0x04
;	ControllerCore.h:104: TR4=1;
	setb	_TR4
;	ControllerCore.h:106: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	ControllerCore.h:108: EA=1; // Enable interrupts
	setb	_EA
;	ControllerCore.h:109: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	ControllerCore.h:112: void InitADC (void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	ControllerCore.h:114: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	ControllerCore.h:115: ADEN=0; // Disable ADC
	clr	_ADEN
;	ControllerCore.h:120: (0x0 << 0) ; // Accumulate n conversions: 0x0: 1, 0x1:4, 0x2:8, 0x3:16, 0x4:32
	mov	_ADC0CN1,#0x80
;	ControllerCore.h:124: (0x0 << 2); // 0:SYSCLK ADCCLK = SYSCLK. 1:HFOSC0 ADCCLK = HFOSC0.
	mov	_ADC0CF0,#0x20
;	ControllerCore.h:128: (0x1E << 0); // Conversion Tracking Time. Tadtk = ADTK / (Fsarclk)
	mov	_ADC0CF1,#0x1E
;	ControllerCore.h:137: (0x0 << 0) ; // TEMPE. 0: Disable the Temperature Sensor. 1: Enable the Temperature Sensor.
	mov	_ADC0CN0,#0x00
;	ControllerCore.h:142: (0x1F << 0); // ADPWR. Power Up Delay Time. Tpwrtime = ((4 * (ADPWR + 1)) + 2) / (Fadcclk)
	mov	_ADC0CF2,#0x3F
;	ControllerCore.h:146: (0x0 << 0) ; // ADCM. 0x0: ADBUSY, 0x1: TIMER0, 0x2: TIMER2, 0x3: TIMER3, 0x4: CNVSTR, 0x5: CEX5, 0x6: TIMER4, 0x7: TIMER5, 0x8: CLU0, 0x9: CLU1, 0xA: CLU2, 0xB: CLU3
	mov	_ADC0CN2,#0x00
;	ControllerCore.h:148: ADEN=1; // Enable ADC
	setb	_ADEN
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitPinADC'
;------------------------------------------------------------
;pin_num                   Allocated with name '_InitPinADC_PARM_2'
;portno                    Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	ControllerCore.h:151: void InitPinADC (unsigned char portno, unsigned char pin_num)
;	-----------------------------------------
;	 function InitPinADC
;	-----------------------------------------
_InitPinADC:
	mov	r2,dpl
;	ControllerCore.h:155: mask=1<<pin_num;
	mov	b,_InitPinADC_PARM_2
	inc	b
	mov	a,#0x01
	sjmp	L004013?
L004011?:
	add	a,acc
L004013?:
	djnz	b,L004011?
	mov	r3,a
;	ControllerCore.h:157: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	ControllerCore.h:158: switch (portno)
	cjne	r2,#0x00,L004014?
	sjmp	L004001?
L004014?:
	cjne	r2,#0x01,L004015?
	sjmp	L004002?
L004015?:
;	ControllerCore.h:160: case 0:
	cjne	r2,#0x02,L004005?
	sjmp	L004003?
L004001?:
;	ControllerCore.h:161: P0MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r4,a
	anl	_P0MDIN,a
;	ControllerCore.h:162: P0SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P0SKIP,a
;	ControllerCore.h:163: break;
;	ControllerCore.h:164: case 1:
	sjmp	L004005?
L004002?:
;	ControllerCore.h:165: P1MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r4,a
	anl	_P1MDIN,a
;	ControllerCore.h:166: P1SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P1SKIP,a
;	ControllerCore.h:167: break;
;	ControllerCore.h:168: case 2:
	sjmp	L004005?
L004003?:
;	ControllerCore.h:169: P2MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r4,a
	anl	_P2MDIN,a
;	ControllerCore.h:170: P2SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P2SKIP,a
;	ControllerCore.h:174: }
L004005?:
;	ControllerCore.h:175: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	ControllerCore.h:176: printf("Initialized ADC at Pin %d_%d\n",portno,pin_num);
	mov	r3,_InitPinADC_PARM_2
	mov	r4,#0x00
	mov	r5,#0x00
	push	ar3
	push	ar4
	push	ar2
	push	ar5
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf9
	mov	sp,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	ControllerCore.h:179: unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_ADC0MX,dpl
;	ControllerCore.h:182: ADINT = 0;
	clr	_ADINT
;	ControllerCore.h:183: ADBUSY = 1;     // Convert voltage at the pin
	setb	_ADBUSY
;	ControllerCore.h:184: while (!ADINT); // Wait for conversion to complete
L005001?:
	jnb	_ADINT,L005001?
;	ControllerCore.h:185: return (ADC0);
	mov	dpl,_ADC0
	mov	dph,(_ADC0 >> 8)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Volts_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	ControllerCore.h:188: float Volts_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function Volts_at_Pin
;	-----------------------------------------
_Volts_at_Pin:
;	ControllerCore.h:190: return ((ADC_at_Pin(pin)*VDD)/16383.0);
	lcall	_ADC_at_Pin
	lcall	___uint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x6C8B
	mov	b,#0x53
	mov	a,#0x40
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0xFC
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x46
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	ControllerCore.h:194: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	ControllerCore.h:199: CKCON0|=0b_0100_0000;
	orl	_CKCON0,#0x40
;	ControllerCore.h:201: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	ControllerCore.h:202: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	ControllerCore.h:204: TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	ControllerCore.h:205: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L007004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L007007?
;	ControllerCore.h:207: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L007001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L007001?
;	ControllerCore.h:208: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	ControllerCore.h:205: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L007004?
L007007?:
;	ControllerCore.h:210: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r4 r5 
;k                         Allocated to registers r6 
;------------------------------------------------------------
;	ControllerCore.h:213: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	ControllerCore.h:217: for(j=0; j<ms; j++)
	mov	r4,#0x00
	mov	r5,#0x00
L008005?:
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	subb	a,r3
	jnc	L008009?
;	ControllerCore.h:218: for (k=0; k<4; k++) Timer3us(250);
	mov	r6,#0x00
L008001?:
	cjne	r6,#0x04,L008018?
L008018?:
	jnc	L008007?
	mov	dpl,#0xFA
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_Timer3us
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r6
	sjmp	L008001?
L008007?:
;	ControllerCore.h:217: for(j=0; j<ms; j++)
	inc	r4
	cjne	r4,#0x00,L008005?
	inc	r5
	sjmp	L008005?
L008009?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'UART1_Init'
;------------------------------------------------------------
;baudrate                  Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	ControllerCore.h:221: void UART1_Init (unsigned long baudrate)
;	-----------------------------------------
;	 function UART1_Init
;	-----------------------------------------
_UART1_Init:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	ControllerCore.h:223: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	ControllerCore.h:224: SMOD1 = 0x0C; // no parity, 8 data bits, 1 stop bit
	mov	_SMOD1,#0x0C
;	ControllerCore.h:225: SCON1 = 0x10;
	mov	_SCON1,#0x10
;	ControllerCore.h:226: SBCON1 =0x00;   // disable baud rate generator
	mov	_SBCON1,#0x00
;	ControllerCore.h:227: SBRL1 = 0x10000L-((SYSCLK/baudrate)/(12L*2L));
	mov	__divulong_PARM_2,r2
	mov	(__divulong_PARM_2 + 1),r3
	mov	(__divulong_PARM_2 + 2),r4
	mov	(__divulong_PARM_2 + 3),r5
	mov	dptr,#0xA200
	mov	b,#0x4A
	mov	a,#0x04
	lcall	__divulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	__divulong_PARM_2,#0x18
	clr	a
	mov	(__divulong_PARM_2 + 1),a
	mov	(__divulong_PARM_2 + 2),a
	mov	(__divulong_PARM_2 + 3),a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__divulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	clr	a
	clr	c
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
	mov	a,#0x01
	subb	a,r4
	clr	a
	subb	a,r5
	mov	_SBRL1,r2
	mov	(_SBRL1 >> 8),r3
;	ControllerCore.h:228: TI1 = 1; // indicate ready for TX
	setb	_TI1
;	ControllerCore.h:229: SBCON1 |= 0x40;   // enable baud rate generator
	orl	_SBCON1,#0x40
;	ControllerCore.h:230: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'putchar1'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	ControllerCore.h:233: void putchar1 (char c) 
;	-----------------------------------------
;	 function putchar1
;	-----------------------------------------
_putchar1:
	mov	r2,dpl
;	ControllerCore.h:235: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	ControllerCore.h:236: while (!TI1);
L010001?:
;	ControllerCore.h:237: TI1=0;
	jbc	_TI1,L010008?
	sjmp	L010001?
L010008?:
;	ControllerCore.h:238: SBUF1 = c;
	mov	_SBUF1,r2
;	ControllerCore.h:239: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'sendstr1'
;------------------------------------------------------------
;s                         Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	ControllerCore.h:242: void sendstr1 (char * s)
;	-----------------------------------------
;	 function sendstr1
;	-----------------------------------------
_sendstr1:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	ControllerCore.h:244: while(*s)
L011001?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	jz	L011004?
;	ControllerCore.h:246: putchar1(*s);
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_putchar1
	pop	ar4
	pop	ar3
	pop	ar2
;	ControllerCore.h:247: s++;	
	inc	r2
	cjne	r2,#0x00,L011001?
	inc	r3
	sjmp	L011001?
L011004?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'sendstr2'
;------------------------------------------------------------
;s                         Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	ControllerCore.h:251: void sendstr2 (char * s)
;	-----------------------------------------
;	 function sendstr2
;	-----------------------------------------
_sendstr2:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	ControllerCore.h:253: while(*s && (*s != 0x0A))
L012002?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	jz	L012005?
	cjne	r5,#0x0A,L012012?
	ret
L012012?:
;	ControllerCore.h:255: putchar1(*s);
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_putchar1
	pop	ar4
	pop	ar3
	pop	ar2
;	ControllerCore.h:256: s++;	
	inc	r2
	cjne	r2,#0x00,L012002?
	inc	r3
	sjmp	L012002?
L012005?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getchar1'
;------------------------------------------------------------
;c                         Allocated to registers 
;------------------------------------------------------------
;	ControllerCore.h:260: char getchar1 (void)
;	-----------------------------------------
;	 function getchar1
;	-----------------------------------------
_getchar1:
;	ControllerCore.h:263: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	ControllerCore.h:264: while (!RI1);
L013001?:
;	ControllerCore.h:265: RI1=0;
	jbc	_RI1,L013008?
	sjmp	L013001?
L013008?:
;	ControllerCore.h:267: SCON1&=0b_0011_1111;
	anl	_SCON1,#0x3F
;	ControllerCore.h:268: c = SBUF1;
	mov	dpl,_SBUF1
;	ControllerCore.h:269: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	ControllerCore.h:270: return (c);
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getchar1_with_timeout'
;------------------------------------------------------------
;c                         Allocated to registers 
;timeout                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	ControllerCore.h:273: char getchar1_with_timeout (void)
;	-----------------------------------------
;	 function getchar1_with_timeout
;	-----------------------------------------
_getchar1_with_timeout:
;	ControllerCore.h:277: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	ControllerCore.h:279: while (!RI1)
	mov	r2,#0x00
	mov	r3,#0x00
L014003?:
	jb	_RI1,L014005?
;	ControllerCore.h:281: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	ControllerCore.h:282: Timer3us(20);
	mov	dpl,#0x14
	push	ar2
	push	ar3
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	ControllerCore.h:283: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	ControllerCore.h:284: timeout++;
	inc	r2
	cjne	r2,#0x00,L014012?
	inc	r3
L014012?:
;	ControllerCore.h:285: if(timeout==25000)
	cjne	r2,#0xA8,L014003?
	cjne	r3,#0x61,L014003?
;	ControllerCore.h:287: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	ControllerCore.h:288: return ('\n'); // Timeout after half second
	mov	dpl,#0x0A
	ret
L014005?:
;	ControllerCore.h:291: RI1=0;
	clr	_RI1
;	ControllerCore.h:293: SCON1&=0b_0011_1111;
	anl	_SCON1,#0x3F
;	ControllerCore.h:294: c = SBUF1;
	mov	dpl,_SBUF1
;	ControllerCore.h:295: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	ControllerCore.h:296: return (c);
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getstr1'
;------------------------------------------------------------
;s                         Allocated to registers r2 r3 r4 
;c                         Allocated to registers r5 
;------------------------------------------------------------
;	ControllerCore.h:299: void getstr1 (char * s)
;	-----------------------------------------
;	 function getstr1
;	-----------------------------------------
_getstr1:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	ControllerCore.h:303: while(1)
L015004?:
;	ControllerCore.h:305: c=getchar1_with_timeout();
	push	ar2
	push	ar3
	push	ar4
	lcall	_getchar1_with_timeout
	mov	r5,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;	ControllerCore.h:306: if(c=='\n')
	cjne	r5,#0x0A,L015002?
;	ControllerCore.h:308: *s=0;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	clr	a
;	ControllerCore.h:309: return;
	ljmp	__gptrput
L015002?:
;	ControllerCore.h:311: *s=c;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__gptrput
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
;	ControllerCore.h:312: s++;
	sjmp	L015004?
;------------------------------------------------------------
;Allocation info for local variables in function 'RXU1'
;------------------------------------------------------------
;------------------------------------------------------------
;	ControllerCore.h:317: bit RXU1 (void)
;	-----------------------------------------
;	 function RXU1
;	-----------------------------------------
_RXU1:
;	ControllerCore.h:320: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	ControllerCore.h:321: mybit=RI1;
	mov	c,_RI1
;	ControllerCore.h:322: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	ControllerCore.h:323: return mybit;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms_or_RI1'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r4 r5 
;k                         Allocated to registers r6 
;------------------------------------------------------------
;	ControllerCore.h:326: void waitms_or_RI1 (unsigned int ms)
;	-----------------------------------------
;	 function waitms_or_RI1
;	-----------------------------------------
_waitms_or_RI1:
	mov	r2,dpl
	mov	r3,dph
;	ControllerCore.h:330: for(j=0; j<ms; j++)
	mov	r4,#0x00
	mov	r5,#0x00
L017007?:
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	subb	a,r3
	jnc	L017011?
;	ControllerCore.h:332: for (k=0; k<4; k++)
	mov	r6,#0x00
L017003?:
	cjne	r6,#0x04,L017019?
L017019?:
	jnc	L017009?
;	ControllerCore.h:334: if(RXU1()) return;
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_RXU1
	clr	a
	rlc	a
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jz	L017002?
	ret
L017002?:
;	ControllerCore.h:335: Timer3us(250);
	mov	dpl,#0xFA
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_Timer3us
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	ControllerCore.h:332: for (k=0; k<4; k++)
	inc	r6
	sjmp	L017003?
L017009?:
;	ControllerCore.h:330: for(j=0; j<ms; j++)
	inc	r4
	cjne	r4,#0x00,L017007?
	inc	r5
	sjmp	L017007?
L017011?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'SendATCommand'
;------------------------------------------------------------
;s                         Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	ControllerCore.h:340: void SendATCommand (char * s)
;	-----------------------------------------
;	 function SendATCommand
;	-----------------------------------------
_SendATCommand:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	ControllerCore.h:342: printf("Command: %s", s);
	push	ar2
	push	ar3
	push	ar4
	push	ar2
	push	ar3
	push	ar4
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
;	ControllerCore.h:343: P3_3=0; // 'set' pin to 0 is 'AT' mode.
	clr	_P3_3
;	ControllerCore.h:344: waitms(5);
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar4
	pop	ar3
	pop	ar2
;	ControllerCore.h:345: sendstr1(s);
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_sendstr1
;	ControllerCore.h:346: getstr1(buff);
	mov	dptr,#_buff
	mov	b,#0x00
	lcall	_getstr1
;	ControllerCore.h:347: waitms(10);
	mov	dptr,#0x000A
	lcall	_waitms
;	ControllerCore.h:348: P3_3=1; // 'set' pin to 1 is normal operation mode.
	setb	_P3_3
;	ControllerCore.h:349: printf("Response: %s\r\n", buff);
	mov	a,#_buff
	push	acc
	mov	a,#(_buff >> 8)
	push	acc
	clr	a
	push	acc
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Package_Signed_int'
;------------------------------------------------------------
;in                        Allocated to registers r2 r3 
;out                       Allocated to registers r4 
;------------------------------------------------------------
;	ControllerCore.h:352: char Package_Signed_int(int in){
;	-----------------------------------------
;	 function Package_Signed_int
;	-----------------------------------------
_Package_Signed_int:
	mov	r2,dpl
	mov	r3,dph
;	ControllerCore.h:353: char out = 0x80; //set bit 7, 6 = 0b10 to indicate motor cmd
	mov	r4,#0x80
;	ControllerCore.h:355: if(in<0){
	mov	a,r3
	jnb	acc.7,L019002?
;	ControllerCore.h:356: out |= 0x20; //set bit 5 to 1 if negative
	mov	r4,#0xA0
L019002?:
;	ControllerCore.h:358: out |= abs(in) & 0x1F; //preserve only bits 0-4
	mov	dpl,r2
	mov	dph,r3
	push	ar4
	lcall	_abs
	mov	a,dpl
	mov	b,dph
	pop	ar4
	anl	a,#0x1F
	mov	r2,a
	mov	r3,#0x00
	mov	a,r4
	mov	r5,a
	rlc	a
	subb	a,acc
	mov	r6,a
	mov	a,r5
	orl	ar2,a
	mov	a,r6
	orl	ar3,a
	mov	ar4,r2
;	ControllerCore.h:359: return out;
	mov	dpl,r4
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Voltage_to_Coordinate'
;------------------------------------------------------------
;v                         Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	ControllerUI.h:21: int Voltage_to_Coordinate(float v){
;	-----------------------------------------
;	 function Voltage_to_Coordinate
;	-----------------------------------------
_Voltage_to_Coordinate:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	ControllerUI.h:22: if(1.65 < v){
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x3333
	mov	b,#0xD3
	mov	a,#0x3F
	lcall	___fslt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jz	L020005?
;	ControllerUI.h:23: return (int)((v-1.65)/(3.30-1.65)*20);
	mov	a,#0x33
	push	acc
	push	acc
	mov	a,#0xD3
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fssub
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x33
	push	acc
	push	acc
	mov	a,#0xD3
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dptr,#0x0000
	mov	b,#0xA0
	mov	a,#0x41
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	ljmp	___fs2sint
L020005?:
;	ControllerUI.h:24: }else if(1.65 > v){
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x3333
	mov	b,#0xD3
	mov	a,#0x3F
	lcall	___fsgt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jz	L020002?
;	ControllerUI.h:25: return (int)((1-v/1.65)*(-20));
	mov	a,#0x33
	push	acc
	push	acc
	mov	a,#0xD3
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x3F
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x0000
	mov	b,#0xA0
	mov	a,#0xC1
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
;	ControllerUI.h:27: return 0;
	ljmp	___fs2sint
L020002?:
	mov	dptr,#0x0000
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Check_Joystick_Button'
;------------------------------------------------------------
;v                         Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	ControllerUI.h:31: char Check_Joystick_Button(float v){
;	-----------------------------------------
;	 function Check_Joystick_Button
;	-----------------------------------------
_Check_Joystick_Button:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	ControllerUI.h:32: if(v != 0.0){
	mov	a,r2
	orl	a,r3
	orl	a,r4
	mov	b,r5
	clr	b.7 ; Clear the sign bit
	orl	a,b
	jz	L021002?
;	ControllerUI.h:33: return 0;
	mov	dpl,#0x00
;	ControllerUI.h:35: return 1;
	ret
L021002?:
	mov	dpl,#0x01
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Generate_Motor_Command'
;------------------------------------------------------------
;x                         Allocated with name '_Generate_Motor_Command_PARM_2'
;y                         Allocated with name '_Generate_Motor_Command_PARM_3'
;cmd                       Allocated to registers r2 r3 r4 
;sloc0                     Allocated with name '_Generate_Motor_Command_sloc0_1_0'
;------------------------------------------------------------
;	ControllerUI.h:40: void Generate_Motor_Command(Motor* cmd, int x, int y){
;	-----------------------------------------
;	 function Generate_Motor_Command
;	-----------------------------------------
_Generate_Motor_Command:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	ControllerUI.h:42: if((x==0) && (y==0)){
	mov	a,_Generate_Motor_Command_PARM_2
	orl	a,(_Generate_Motor_Command_PARM_2 + 1)
	jnz	L022002?
	mov	a,_Generate_Motor_Command_PARM_3
	orl	a,(_Generate_Motor_Command_PARM_3 + 1)
	jnz	L022002?
;	ControllerUI.h:43: cmd->left = 0;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
;	ControllerUI.h:44: cmd->right = 0;
	mov	a,#0x02
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
;	ControllerUI.h:45: return;
	ljmp	__gptrput
L022002?:
;	ControllerUI.h:48: if(y >= 0){
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	rlc	a
	clr	a
	rlc	a
	mov	r5,a
	jz	L022064?
	ljmp	L022042?
L022064?:
;	ControllerUI.h:49: if(x > 0){
	clr	c
	clr	a
	subb	a,_Generate_Motor_Command_PARM_2
	clr	a
	xrl	a,#0x80
	mov	b,(_Generate_Motor_Command_PARM_2 + 1)
	xrl	b,#0x80
	subb	a,b
	jc	L022065?
	ljmp	L022017?
L022065?:
;	ControllerUI.h:50: if(x < y){
	clr	c
	mov	a,_Generate_Motor_Command_PARM_2
	subb	a,_Generate_Motor_Command_PARM_3
	mov	a,(_Generate_Motor_Command_PARM_2 + 1)
	xrl	a,#0x80
	mov	b,(_Generate_Motor_Command_PARM_3 + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L022008?
;	ControllerUI.h:51: cmd->left = y;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,_Generate_Motor_Command_PARM_3
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	lcall	__gptrput
;	ControllerUI.h:52: cmd->right = y - x/2;
	mov	a,#0x02
	add	a,r2
	mov	_Generate_Motor_Command_sloc0_1_0,a
	clr	a
	addc	a,r3
	mov	(_Generate_Motor_Command_sloc0_1_0 + 1),a
	mov	(_Generate_Motor_Command_sloc0_1_0 + 2),r4
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_2
	mov	dph,(_Generate_Motor_Command_PARM_2 + 1)
	lcall	__divsint
	mov	r1,dpl
	mov	r6,dph
	mov	a,_Generate_Motor_Command_PARM_3
	clr	c
	subb	a,r1
	mov	r1,a
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	subb	a,r6
	mov	r6,a
	mov	dpl,_Generate_Motor_Command_sloc0_1_0
	mov	dph,(_Generate_Motor_Command_sloc0_1_0 + 1)
	mov	b,(_Generate_Motor_Command_sloc0_1_0 + 2)
	mov	a,r1
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	ljmp	__gptrput
L022008?:
;	ControllerUI.h:53: }else if(x == y){
	mov	a,_Generate_Motor_Command_PARM_3
	cjne	a,_Generate_Motor_Command_PARM_2,L022005?
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	cjne	a,(_Generate_Motor_Command_PARM_2 + 1),L022005?
;	ControllerUI.h:54: cmd->left = y;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,_Generate_Motor_Command_PARM_3
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	lcall	__gptrput
;	ControllerUI.h:55: cmd->right = y/2;
	mov	a,#0x02
	add	a,r2
	mov	_Generate_Motor_Command_sloc0_1_0,a
	clr	a
	addc	a,r3
	mov	(_Generate_Motor_Command_sloc0_1_0 + 1),a
	mov	(_Generate_Motor_Command_sloc0_1_0 + 2),r4
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_3
	mov	dph,(_Generate_Motor_Command_PARM_3 + 1)
	lcall	__divsint
	mov	r1,dpl
	mov	r6,dph
	mov	dpl,_Generate_Motor_Command_sloc0_1_0
	mov	dph,(_Generate_Motor_Command_sloc0_1_0 + 1)
	mov	b,(_Generate_Motor_Command_sloc0_1_0 + 2)
	mov	a,r1
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	ljmp	__gptrput
L022005?:
;	ControllerUI.h:57: cmd->left = x;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,_Generate_Motor_Command_PARM_2
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Motor_Command_PARM_2 + 1)
	lcall	__gptrput
;	ControllerUI.h:58: cmd->right = y/2;
	mov	a,#0x02
	add	a,r2
	mov	_Generate_Motor_Command_sloc0_1_0,a
	clr	a
	addc	a,r3
	mov	(_Generate_Motor_Command_sloc0_1_0 + 1),a
	mov	(_Generate_Motor_Command_sloc0_1_0 + 2),r4
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_3
	mov	dph,(_Generate_Motor_Command_PARM_3 + 1)
	lcall	__divsint
	mov	r1,dpl
	mov	r6,dph
	mov	dpl,_Generate_Motor_Command_sloc0_1_0
	mov	dph,(_Generate_Motor_Command_sloc0_1_0 + 1)
	mov	b,(_Generate_Motor_Command_sloc0_1_0 + 2)
	mov	a,r1
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	ljmp	__gptrput
L022017?:
;	ControllerUI.h:62: x *= -1;
	clr	c
	clr	a
	subb	a,_Generate_Motor_Command_PARM_2
	mov	_Generate_Motor_Command_PARM_2,a
	clr	a
	subb	a,(_Generate_Motor_Command_PARM_2 + 1)
	mov	(_Generate_Motor_Command_PARM_2 + 1),a
;	ControllerUI.h:63: if(x < y){
	clr	c
	mov	a,_Generate_Motor_Command_PARM_2
	subb	a,_Generate_Motor_Command_PARM_3
	mov	a,(_Generate_Motor_Command_PARM_2 + 1)
	xrl	a,#0x80
	mov	b,(_Generate_Motor_Command_PARM_3 + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L022014?
;	ControllerUI.h:64: cmd->left = y - x/2;
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_2
	mov	dph,(_Generate_Motor_Command_PARM_2 + 1)
	push	ar2
	push	ar3
	push	ar4
	lcall	__divsint
	mov	r6,dpl
	mov	r7,dph
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,_Generate_Motor_Command_PARM_3
	clr	c
	subb	a,r6
	mov	r6,a
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	subb	a,r7
	mov	r7,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r6
	lcall	__gptrput
	inc	dptr
	mov	a,r7
	lcall	__gptrput
;	ControllerUI.h:65: cmd->right = y;
	mov	a,#0x02
	add	a,r2
	mov	r6,a
	clr	a
	addc	a,r3
	mov	r7,a
	mov	ar0,r4
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,_Generate_Motor_Command_PARM_3
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	ljmp	__gptrput
L022014?:
;	ControllerUI.h:66: }else if(x == y){
	mov	a,_Generate_Motor_Command_PARM_3
	cjne	a,_Generate_Motor_Command_PARM_2,L022011?
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	cjne	a,(_Generate_Motor_Command_PARM_2 + 1),L022011?
;	ControllerUI.h:67: cmd->left = y/2;
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_3
	mov	dph,(_Generate_Motor_Command_PARM_3 + 1)
	push	ar2
	push	ar3
	push	ar4
	lcall	__divsint
	mov	r6,dpl
	mov	r7,dph
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r6
	lcall	__gptrput
	inc	dptr
	mov	a,r7
	lcall	__gptrput
;	ControllerUI.h:68: cmd->right = y;
	mov	a,#0x02
	add	a,r2
	mov	r6,a
	clr	a
	addc	a,r3
	mov	r7,a
	mov	ar0,r4
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,_Generate_Motor_Command_PARM_3
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	ljmp	__gptrput
L022011?:
;	ControllerUI.h:70: cmd->left = y/2;
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_3
	mov	dph,(_Generate_Motor_Command_PARM_3 + 1)
	push	ar2
	push	ar3
	push	ar4
	lcall	__divsint
	mov	r6,dpl
	mov	r7,dph
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r6
	lcall	__gptrput
	inc	dptr
	mov	a,r7
	lcall	__gptrput
;	ControllerUI.h:71: cmd->right = x;
	mov	a,#0x02
	add	a,r2
	mov	r6,a
	clr	a
	addc	a,r3
	mov	r7,a
	mov	ar0,r4
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,_Generate_Motor_Command_PARM_2
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Motor_Command_PARM_2 + 1)
	ljmp	__gptrput
L022042?:
;	ControllerUI.h:76: if((y<0) && (y>=-8)){ // check if position is in stall zone from y = [-8,0]
	mov	a,r5
	jnz	L022072?
	ljmp	L022038?
L022072?:
	clr	c
	mov	a,_Generate_Motor_Command_PARM_3
	subb	a,#0xF8
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	xrl	a,#0x80
	subb	a,#0x7f
	jnc	L022073?
	ljmp	L022038?
L022073?:
;	ControllerUI.h:78: if(x > 0){
	clr	c
	clr	a
	subb	a,_Generate_Motor_Command_PARM_2
	clr	a
	xrl	a,#0x80
	mov	b,(_Generate_Motor_Command_PARM_2 + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L022020?
;	ControllerUI.h:79: cmd->left = ((y+4)*(x))/4;
	mov	dpl,_Generate_Motor_Command_PARM_3
	mov	dph,(_Generate_Motor_Command_PARM_3 + 1)
	inc	dptr
	inc	dptr
	inc	dptr
	inc	dptr
	mov	__mulint_PARM_2,_Generate_Motor_Command_PARM_2
	mov	(__mulint_PARM_2 + 1),(_Generate_Motor_Command_PARM_2 + 1)
	push	ar2
	push	ar3
	push	ar4
	lcall	__mulint
	mov	r5,dpl
	mov	r6,dph
	mov	__divsint_PARM_2,#0x04
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,r5
	mov	dph,r6
	lcall	__divsint
	mov	r5,dpl
	mov	r6,dph
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	lcall	__gptrput
;	ControllerUI.h:80: cmd->right = 0;
	mov	a,#0x02
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	ljmp	__gptrput
L022020?:
;	ControllerUI.h:82: cmd->left = 0;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
;	ControllerUI.h:83: cmd->right = ((y+4)*(abs(x)))/4;
	mov	a,#0x02
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	a,#0x04
	add	a,_Generate_Motor_Command_PARM_3
	mov	r0,a
	clr	a
	addc	a,(_Generate_Motor_Command_PARM_3 + 1)
	mov	r1,a
	mov	dpl,_Generate_Motor_Command_PARM_2
	mov	dph,(_Generate_Motor_Command_PARM_2 + 1)
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	lcall	_abs
	mov	__mulint_PARM_2,dpl
	mov	(__mulint_PARM_2 + 1),dph
	pop	ar1
	pop	ar0
	mov	dpl,r0
	mov	dph,r1
	lcall	__mulint
	mov	r0,dpl
	mov	r1,dph
	mov	__divsint_PARM_2,#0x04
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,r0
	mov	dph,r1
	lcall	__divsint
	mov	r0,dpl
	mov	r1,dph
	pop	ar7
	pop	ar6
	pop	ar5
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r0
	lcall	__gptrput
	inc	dptr
	mov	a,r1
	ljmp	__gptrput
L022038?:
;	ControllerUI.h:88: if(x > 0){
	clr	c
	clr	a
	subb	a,_Generate_Motor_Command_PARM_2
	clr	a
	xrl	a,#0x80
	mov	b,(_Generate_Motor_Command_PARM_2 + 1)
	xrl	b,#0x80
	subb	a,b
	jc	L022075?
	ljmp	L022035?
L022075?:
;	ControllerUI.h:89: if(x < -1*y){
	clr	c
	clr	a
	subb	a,_Generate_Motor_Command_PARM_3
	mov	r5,a
	clr	a
	subb	a,(_Generate_Motor_Command_PARM_3 + 1)
	mov	r6,a
	clr	c
	mov	a,_Generate_Motor_Command_PARM_2
	subb	a,r5
	mov	a,(_Generate_Motor_Command_PARM_2 + 1)
	xrl	a,#0x80
	mov	b,r6
	xrl	b,#0x80
	subb	a,b
	jnc	L022026?
;	ControllerUI.h:90: cmd->left = y;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,_Generate_Motor_Command_PARM_3
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	lcall	__gptrput
;	ControllerUI.h:91: cmd->right = y + x/2;
	mov	a,#0x02
	add	a,r2
	mov	_Generate_Motor_Command_sloc0_1_0,a
	clr	a
	addc	a,r3
	mov	(_Generate_Motor_Command_sloc0_1_0 + 1),a
	mov	(_Generate_Motor_Command_sloc0_1_0 + 2),r4
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_2
	mov	dph,(_Generate_Motor_Command_PARM_2 + 1)
	lcall	__divsint
	mov	r7,dpl
	mov	r0,dph
	mov	a,r7
	add	a,_Generate_Motor_Command_PARM_3
	mov	r7,a
	mov	a,r0
	addc	a,(_Generate_Motor_Command_PARM_3 + 1)
	mov	r0,a
	mov	dpl,_Generate_Motor_Command_sloc0_1_0
	mov	dph,(_Generate_Motor_Command_sloc0_1_0 + 1)
	mov	b,(_Generate_Motor_Command_sloc0_1_0 + 2)
	mov	a,r7
	lcall	__gptrput
	inc	dptr
	mov	a,r0
	ljmp	__gptrput
L022026?:
;	ControllerUI.h:92: }else if(x == -1*y){
	mov	a,r5
	cjne	a,_Generate_Motor_Command_PARM_2,L022023?
	mov	a,r6
	cjne	a,(_Generate_Motor_Command_PARM_2 + 1),L022023?
;	ControllerUI.h:93: cmd->left = y;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,_Generate_Motor_Command_PARM_3
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	lcall	__gptrput
;	ControllerUI.h:94: cmd->right = y/2;
	mov	a,#0x02
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_3
	mov	dph,(_Generate_Motor_Command_PARM_3 + 1)
	push	ar5
	push	ar6
	push	ar7
	lcall	__divsint
	mov	r0,dpl
	mov	r1,dph
	pop	ar7
	pop	ar6
	pop	ar5
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r0
	lcall	__gptrput
	inc	dptr
	mov	a,r1
	ljmp	__gptrput
L022023?:
;	ControllerUI.h:96: cmd->left = -1*x;
	clr	c
	clr	a
	subb	a,_Generate_Motor_Command_PARM_2
	mov	r5,a
	clr	a
	subb	a,(_Generate_Motor_Command_PARM_2 + 1)
	mov	r6,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	lcall	__gptrput
;	ControllerUI.h:97: cmd->right = y/2;
	mov	a,#0x02
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_3
	mov	dph,(_Generate_Motor_Command_PARM_3 + 1)
	push	ar5
	push	ar6
	push	ar7
	lcall	__divsint
	mov	r0,dpl
	mov	r1,dph
	pop	ar7
	pop	ar6
	pop	ar5
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r0
	lcall	__gptrput
	inc	dptr
	mov	a,r1
	ljmp	__gptrput
L022035?:
;	ControllerUI.h:105: if(x > y){
	clr	c
	mov	a,_Generate_Motor_Command_PARM_3
	subb	a,_Generate_Motor_Command_PARM_2
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	xrl	a,#0x80
	mov	b,(_Generate_Motor_Command_PARM_2 + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L022032?
;	ControllerUI.h:106: cmd->left = y - x/2;
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_2
	mov	dph,(_Generate_Motor_Command_PARM_2 + 1)
	push	ar2
	push	ar3
	push	ar4
	lcall	__divsint
	mov	r5,dpl
	mov	r6,dph
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,_Generate_Motor_Command_PARM_3
	clr	c
	subb	a,r5
	mov	r5,a
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	subb	a,r6
	mov	r6,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	lcall	__gptrput
;	ControllerUI.h:107: cmd->right = y;
	mov	a,#0x02
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,_Generate_Motor_Command_PARM_3
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	ljmp	__gptrput
L022032?:
;	ControllerUI.h:108: }else if(x == y){
	mov	a,_Generate_Motor_Command_PARM_3
	cjne	a,_Generate_Motor_Command_PARM_2,L022029?
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	cjne	a,(_Generate_Motor_Command_PARM_2 + 1),L022029?
;	ControllerUI.h:109: cmd->left = y/2;
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_3
	mov	dph,(_Generate_Motor_Command_PARM_3 + 1)
	push	ar2
	push	ar3
	push	ar4
	lcall	__divsint
	mov	r5,dpl
	mov	r6,dph
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	lcall	__gptrput
;	ControllerUI.h:110: cmd->right = y;
	mov	a,#0x02
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,_Generate_Motor_Command_PARM_3
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Motor_Command_PARM_3 + 1)
	ljmp	__gptrput
L022029?:
;	ControllerUI.h:112: cmd->left = y/2;
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	mov	dpl,_Generate_Motor_Command_PARM_3
	mov	dph,(_Generate_Motor_Command_PARM_3 + 1)
	push	ar2
	push	ar3
	push	ar4
	lcall	__divsint
	mov	r5,dpl
	mov	r6,dph
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	lcall	__gptrput
;	ControllerUI.h:113: cmd->right = x;
	mov	a,#0x02
	add	a,r2
	mov	r2,a
	clr	a
	addc	a,r3
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,_Generate_Motor_Command_PARM_2
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Motor_Command_PARM_2 + 1)
	ljmp	__gptrput
;------------------------------------------------------------
;Allocation info for local variables in function 'Generate_Pivot_Command'
;------------------------------------------------------------
;y1                        Allocated with name '_Generate_Pivot_Command_PARM_2'
;y2                        Allocated with name '_Generate_Pivot_Command_PARM_3'
;cmd                       Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	ControllerUI.h:123: void Generate_Pivot_Command(Motor* cmd, int y1, int y2){
;	-----------------------------------------
;	 function Generate_Pivot_Command
;	-----------------------------------------
_Generate_Pivot_Command:
;	ControllerUI.h:124: cmd->left = y1;
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	a,_Generate_Pivot_Command_PARM_2
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Pivot_Command_PARM_2 + 1)
	lcall	__gptrput
;	ControllerUI.h:125: cmd->right = y2;
	mov	a,#0x02
	add	a,r2
	mov	r2,a
	clr	a
	addc	a,r3
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,_Generate_Pivot_Command_PARM_3
	lcall	__gptrput
	inc	dptr
	mov	a,(_Generate_Pivot_Command_PARM_3 + 1)
	ljmp	__gptrput
;------------------------------------------------------------
;Allocation info for local variables in function 'Weigh_Dual_Inputs'
;------------------------------------------------------------
;m1                        Allocated with name '_Weigh_Dual_Inputs_PARM_2'
;m2                        Allocated with name '_Weigh_Dual_Inputs_PARM_3'
;ratio                     Allocated with name '_Weigh_Dual_Inputs_PARM_4'
;mout                      Allocated with name '_Weigh_Dual_Inputs_mout_1_144'
;sloc0                     Allocated with name '_Weigh_Dual_Inputs_sloc0_1_0'
;sloc1                     Allocated with name '_Weigh_Dual_Inputs_sloc1_1_0'
;sloc2                     Allocated with name '_Weigh_Dual_Inputs_sloc2_1_0'
;sloc3                     Allocated with name '_Weigh_Dual_Inputs_sloc3_1_0'
;------------------------------------------------------------
;	ControllerUI.h:128: void Weigh_Dual_Inputs(Motor* mout, Motor* m1, Motor* m2,float ratio){
;	-----------------------------------------
;	 function Weigh_Dual_Inputs
;	-----------------------------------------
_Weigh_Dual_Inputs:
	mov	_Weigh_Dual_Inputs_mout_1_144,dpl
	mov	(_Weigh_Dual_Inputs_mout_1_144 + 1),dph
	mov	(_Weigh_Dual_Inputs_mout_1_144 + 2),b
;	ControllerUI.h:129: mout->left = (int)((m1->left)*(1-ratio)+(m2->left)*ratio);
	mov	_Weigh_Dual_Inputs_sloc1_1_0,_Weigh_Dual_Inputs_PARM_2
	mov	(_Weigh_Dual_Inputs_sloc1_1_0 + 1),(_Weigh_Dual_Inputs_PARM_2 + 1)
	mov	(_Weigh_Dual_Inputs_sloc1_1_0 + 2),(_Weigh_Dual_Inputs_PARM_2 + 2)
	mov	dpl,_Weigh_Dual_Inputs_sloc1_1_0
	mov	dph,(_Weigh_Dual_Inputs_sloc1_1_0 + 1)
	mov	b,(_Weigh_Dual_Inputs_sloc1_1_0 + 2)
	lcall	__gptrget
	mov	_Weigh_Dual_Inputs_sloc0_1_0,a
	inc	dptr
	lcall	__gptrget
	mov	(_Weigh_Dual_Inputs_sloc0_1_0 + 1),a
	push	_Weigh_Dual_Inputs_PARM_4
	push	(_Weigh_Dual_Inputs_PARM_4 + 1)
	push	(_Weigh_Dual_Inputs_PARM_4 + 2)
	push	(_Weigh_Dual_Inputs_PARM_4 + 3)
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x3F
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r0,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_Weigh_Dual_Inputs_sloc0_1_0
	mov	dph,(_Weigh_Dual_Inputs_sloc0_1_0 + 1)
	push	ar2
	push	ar3
	push	ar4
	push	ar0
	lcall	___sint2fs
	mov	r1,dpl
	mov	r5,dph
	mov	r6,b
	mov	r7,a
	pop	ar0
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar2
	push	ar3
	push	ar4
	push	ar0
	push	ar2
	push	ar3
	push	ar4
	push	ar0
	mov	dpl,r1
	mov	dph,r5
	mov	b,r6
	mov	a,r7
	lcall	___fsmul
	mov	_Weigh_Dual_Inputs_sloc2_1_0,dpl
	mov	(_Weigh_Dual_Inputs_sloc2_1_0 + 1),dph
	mov	(_Weigh_Dual_Inputs_sloc2_1_0 + 2),b
	mov	(_Weigh_Dual_Inputs_sloc2_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	_Weigh_Dual_Inputs_sloc3_1_0,_Weigh_Dual_Inputs_PARM_3
	mov	(_Weigh_Dual_Inputs_sloc3_1_0 + 1),(_Weigh_Dual_Inputs_PARM_3 + 1)
	mov	(_Weigh_Dual_Inputs_sloc3_1_0 + 2),(_Weigh_Dual_Inputs_PARM_3 + 2)
	mov	dpl,_Weigh_Dual_Inputs_sloc3_1_0
	mov	dph,(_Weigh_Dual_Inputs_sloc3_1_0 + 1)
	mov	b,(_Weigh_Dual_Inputs_sloc3_1_0 + 2)
	lcall	__gptrget
	mov	r1,a
	inc	dptr
	lcall	__gptrget
	mov	r5,a
	mov	dpl,r1
	mov	dph,r5
	lcall	___sint2fs
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	mov	r1,a
	push	_Weigh_Dual_Inputs_PARM_4
	push	(_Weigh_Dual_Inputs_PARM_4 + 1)
	push	(_Weigh_Dual_Inputs_PARM_4 + 2)
	push	(_Weigh_Dual_Inputs_PARM_4 + 3)
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r1
	lcall	___fsmul
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar5
	push	ar6
	push	ar7
	push	ar1
	mov	dpl,_Weigh_Dual_Inputs_sloc2_1_0
	mov	dph,(_Weigh_Dual_Inputs_sloc2_1_0 + 1)
	mov	b,(_Weigh_Dual_Inputs_sloc2_1_0 + 2)
	mov	a,(_Weigh_Dual_Inputs_sloc2_1_0 + 3)
	lcall	___fsadd
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r1
	lcall	___fs2sint
	mov	r5,dpl
	mov	r6,dph
	mov	dpl,_Weigh_Dual_Inputs_mout_1_144
	mov	dph,(_Weigh_Dual_Inputs_mout_1_144 + 1)
	mov	b,(_Weigh_Dual_Inputs_mout_1_144 + 2)
	mov	a,r5
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	lcall	__gptrput
;	ControllerUI.h:130: mout->right = (int)((m1->right)*(1-ratio)+(m2->right)*ratio);
	mov	a,#0x02
	add	a,_Weigh_Dual_Inputs_mout_1_144
	mov	_Weigh_Dual_Inputs_sloc2_1_0,a
	clr	a
	addc	a,(_Weigh_Dual_Inputs_mout_1_144 + 1)
	mov	(_Weigh_Dual_Inputs_sloc2_1_0 + 1),a
	mov	(_Weigh_Dual_Inputs_sloc2_1_0 + 2),(_Weigh_Dual_Inputs_mout_1_144 + 2)
	mov	a,#0x02
	add	a,_Weigh_Dual_Inputs_sloc1_1_0
	mov	r1,a
	clr	a
	addc	a,(_Weigh_Dual_Inputs_sloc1_1_0 + 1)
	mov	r5,a
	mov	r6,(_Weigh_Dual_Inputs_sloc1_1_0 + 2)
	mov	dpl,r1
	mov	dph,r5
	mov	b,r6
	lcall	__gptrget
	mov	r1,a
	inc	dptr
	lcall	__gptrget
	mov	r5,a
	mov	dpl,r1
	mov	dph,r5
	lcall	___sint2fs
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x02
	add	a,_Weigh_Dual_Inputs_sloc3_1_0
	mov	r6,a
	clr	a
	addc	a,(_Weigh_Dual_Inputs_sloc3_1_0 + 1)
	mov	r7,a
	mov	r0,(_Weigh_Dual_Inputs_sloc3_1_0 + 2)
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	lcall	__gptrget
	mov	r6,a
	inc	dptr
	lcall	__gptrget
	mov	r7,a
	mov	dpl,r6
	mov	dph,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	___sint2fs
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	push	_Weigh_Dual_Inputs_PARM_4
	push	(_Weigh_Dual_Inputs_PARM_4 + 1)
	push	(_Weigh_Dual_Inputs_PARM_4 + 2)
	push	(_Weigh_Dual_Inputs_PARM_4 + 3)
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fs2sint
	mov	r2,dpl
	mov	r3,dph
	mov	dpl,_Weigh_Dual_Inputs_sloc2_1_0
	mov	dph,(_Weigh_Dual_Inputs_sloc2_1_0 + 1)
	mov	b,(_Weigh_Dual_Inputs_sloc2_1_0 + 2)
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	mov	a,r3
	ljmp	__gptrput
;------------------------------------------------------------
;Allocation info for local variables in function 'Wait_For_Calibration'
;------------------------------------------------------------
;b1                        Allocated to registers r2 r3 r4 r5 
;b2                        Allocated to registers r6 r7 r0 r1 
;------------------------------------------------------------
;	ControllerUI.h:134: void Wait_For_Calibration(){
;	-----------------------------------------
;	 function Wait_For_Calibration
;	-----------------------------------------
_Wait_For_Calibration:
;	ControllerUI.h:138: while(1){
L025012?:
;	ControllerUI.h:139: b1 = Volts_at_Pin(QFP32_MUX_P2_6);
	mov	dpl,#0x13
	lcall	_Volts_at_Pin
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	ControllerUI.h:140: b2 = Volts_at_Pin(QFP32_MUX_P2_1);
	mov	dpl,#0x0E
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_Volts_at_Pin
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	ControllerUI.h:141: if((b1 == 0.0) || (b2 == 0.0)){
	mov	a,r2
	orl	a,r3
	orl	a,r4
	mov	b,r5
	clr	b.7 ; Clear the sign bit
	orl	a,b
	jz	L025001?
	mov	a,r6
	orl	a,r7
	orl	a,r0
	mov	b,r1
	clr	b.7 ; Clear the sign bit
	orl	a,b
	jnz	L025002?
L025001?:
;	ControllerUI.h:142: waitms(2000); //waits 2 seconds
	mov	dptr,#0x07D0
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	lcall	_waitms
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
L025002?:
;	ControllerUI.h:144: if((b1 == 0.0) || (b2 == 0.0)){
	mov	a,r2
	orl	a,r3
	orl	a,r4
	mov	b,r5
	clr	b.7 ; Clear the sign bit
	orl	a,b
	jz	L025005?
	mov	a,r6
	orl	a,r7
	orl	a,r0
	mov	b,r1
	clr	b.7 ; Clear the sign bit
	orl	a,b
	jz	L025025?
	ljmp	L025012?
L025025?:
;	ControllerUI.h:145: while((Volts_at_Pin(QFP32_MUX_P2_6) == 0.0)||(Volts_at_Pin(QFP32_MUX_P2_1) == 0.0));
L025005?:
	mov	dpl,#0x13
	lcall	_Volts_at_Pin
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,r2
	orl	a,r3
	orl	a,r4
	mov	b,r5
	clr	b.7 ; Clear the sign bit
	orl	a,b
	jz	L025005?
	mov	dpl,#0x0E
	lcall	_Volts_at_Pin
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,r2
	orl	a,r3
	orl	a,r4
	mov	b,r5
	clr	b.7 ; Clear the sign bit
	orl	a,b
	jz	L025005?
;	ControllerUI.h:146: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_pulse'
;------------------------------------------------------------
;------------------------------------------------------------
;	ControllerLCD.h:13: void LCD_pulse (void)
;	-----------------------------------------
;	 function LCD_pulse
;	-----------------------------------------
_LCD_pulse:
;	ControllerLCD.h:15: LCD_E=1;
	setb	_P2_0
;	ControllerLCD.h:16: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
;	ControllerLCD.h:17: LCD_E=0;
	clr	_P2_0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_byte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	ControllerLCD.h:20: void LCD_byte (unsigned char x)
;	-----------------------------------------
;	 function LCD_byte
;	-----------------------------------------
_LCD_byte:
	mov	r2,dpl
;	ControllerLCD.h:23: ACC=x; //Send high nible
	mov	_ACC,r2
;	ControllerLCD.h:24: LCD_D7=ACC_7;
	mov	c,_ACC_7
	mov	_P1_0,c
;	ControllerLCD.h:25: LCD_D6=ACC_6;
	mov	c,_ACC_6
	mov	_P1_1,c
;	ControllerLCD.h:26: LCD_D5=ACC_5;
	mov	c,_ACC_5
	mov	_P1_2,c
;	ControllerLCD.h:27: LCD_D4=ACC_4;
	mov	c,_ACC_4
	mov	_P1_3,c
;	ControllerLCD.h:28: LCD_pulse();
	push	ar2
	lcall	_LCD_pulse
;	ControllerLCD.h:29: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
	pop	ar2
;	ControllerLCD.h:30: ACC=x; //Send low nible
	mov	_ACC,r2
;	ControllerLCD.h:31: LCD_D7=ACC_3;
	mov	c,_ACC_3
	mov	_P1_0,c
;	ControllerLCD.h:32: LCD_D6=ACC_2;
	mov	c,_ACC_2
	mov	_P1_1,c
;	ControllerLCD.h:33: LCD_D5=ACC_1;
	mov	c,_ACC_1
	mov	_P1_2,c
;	ControllerLCD.h:34: LCD_D4=ACC_0;
	mov	c,_ACC_0
	mov	_P1_3,c
;	ControllerLCD.h:35: LCD_pulse();
	ljmp	_LCD_pulse
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteData'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	ControllerLCD.h:38: void WriteData (unsigned char x)
;	-----------------------------------------
;	 function WriteData
;	-----------------------------------------
_WriteData:
	mov	r2,dpl
;	ControllerLCD.h:40: LCD_RS=1;
	setb	_P1_7
;	ControllerLCD.h:41: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	ControllerLCD.h:42: waitms(2);
	mov	dptr,#0x0002
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteCommand'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	ControllerLCD.h:45: void WriteCommand (unsigned char x)
;	-----------------------------------------
;	 function WriteCommand
;	-----------------------------------------
_WriteCommand:
	mov	r2,dpl
;	ControllerLCD.h:47: LCD_RS=0;
	clr	_P1_7
;	ControllerLCD.h:48: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	ControllerLCD.h:49: waitms(5);
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_4BIT'
;------------------------------------------------------------
;------------------------------------------------------------
;	ControllerLCD.h:52: void LCD_4BIT (void)
;	-----------------------------------------
;	 function LCD_4BIT
;	-----------------------------------------
_LCD_4BIT:
;	ControllerLCD.h:54: LCD_E=0; // Resting state of LCD's enable is zero
	clr	_P2_0
;	ControllerLCD.h:56: waitms(20);
	mov	dptr,#0x0014
	lcall	_waitms
;	ControllerLCD.h:58: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	ControllerLCD.h:59: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	ControllerLCD.h:60: WriteCommand(0x32); // Change to 4-bit mode
	mov	dpl,#0x32
	lcall	_WriteCommand
;	ControllerLCD.h:63: WriteCommand(0x28);
	mov	dpl,#0x28
	lcall	_WriteCommand
;	ControllerLCD.h:64: WriteCommand(0x0c);
	mov	dpl,#0x0C
	lcall	_WriteCommand
;	ControllerLCD.h:65: WriteCommand(0x01); // Clear screen command (takes some time)
	mov	dpl,#0x01
	lcall	_WriteCommand
;	ControllerLCD.h:66: waitms(20); // Wait for clear screen command to finsih.
	mov	dptr,#0x0014
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCDprint'
;------------------------------------------------------------
;line                      Allocated with name '_LCDprint_PARM_2'
;string                    Allocated to registers r2 r3 r4 
;j                         Allocated to registers r5 r6 
;------------------------------------------------------------
;	ControllerLCD.h:69: void LCDprint(char * string, unsigned char line, bit clear)
;	-----------------------------------------
;	 function LCDprint
;	-----------------------------------------
_LCDprint:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	ControllerLCD.h:73: WriteCommand(line==2?0xc0:0x80);
	mov	a,#0x02
	cjne	a,_LCDprint_PARM_2,L031013?
	mov	r5,#0xC0
	sjmp	L031014?
L031013?:
	mov	r5,#0x80
L031014?:
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_WriteCommand
;	ControllerLCD.h:74: waitms(5);
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar4
	pop	ar3
	pop	ar2
;	ControllerLCD.h:75: for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	mov	r5,#0x00
	mov	r6,#0x00
L031003?:
	mov	a,r5
	add	a,r2
	mov	r7,a
	mov	a,r6
	addc	a,r3
	mov	r0,a
	mov	ar1,r4
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
	jz	L031006?
	mov	dpl,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_WriteData
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r5
	cjne	r5,#0x00,L031003?
	inc	r6
	sjmp	L031003?
L031006?:
;	ControllerLCD.h:76: if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
	jnb	_LCDprint_PARM_3,L031011?
	mov	ar2,r5
	mov	ar3,r6
L031007?:
	clr	c
	mov	a,r2
	subb	a,#0x10
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L031011?
	mov	dpl,#0x20
	push	ar2
	push	ar3
	lcall	_WriteData
	pop	ar3
	pop	ar2
	inc	r2
	cjne	r2,#0x00,L031007?
	inc	r3
	sjmp	L031007?
L031011?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getsn'
;------------------------------------------------------------
;len                       Allocated with name '_getsn_PARM_2'
;buff                      Allocated with name '_getsn_buff_1_162'
;j                         Allocated with name '_getsn_sloc0_1_0'
;c                         Allocated to registers r3 
;sloc0                     Allocated with name '_getsn_sloc0_1_0'
;------------------------------------------------------------
;	ControllerLCD.h:79: int getsn (char * buff, int len)
;	-----------------------------------------
;	 function getsn
;	-----------------------------------------
_getsn:
	mov	_getsn_buff_1_162,dpl
	mov	(_getsn_buff_1_162 + 1),dph
	mov	(_getsn_buff_1_162 + 2),b
;	ControllerLCD.h:84: for(j=0; j<(len-1); j++)
	clr	a
	mov	_getsn_sloc0_1_0,a
	mov	(_getsn_sloc0_1_0 + 1),a
	mov	a,_getsn_PARM_2
	add	a,#0xff
	mov	r7,a
	mov	a,(_getsn_PARM_2 + 1)
	addc	a,#0xff
	mov	r0,a
	mov	r1,#0x00
	mov	r2,#0x00
L032005?:
	clr	c
	mov	a,r1
	subb	a,r7
	mov	a,r2
	xrl	a,#0x80
	mov	b,r0
	xrl	b,#0x80
	subb	a,b
	jnc	L032008?
;	ControllerLCD.h:86: c=getchar();
	push	ar2
	push	ar7
	push	ar0
	push	ar1
	lcall	_getchar
	mov	r3,dpl
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar2
;	ControllerLCD.h:87: if ( (c=='\n') || (c=='\r') )
	cjne	r3,#0x0A,L032015?
	sjmp	L032001?
L032015?:
	cjne	r3,#0x0D,L032002?
L032001?:
;	ControllerLCD.h:89: buff[j]=0;
	mov	a,_getsn_sloc0_1_0
	add	a,_getsn_buff_1_162
	mov	r4,a
	mov	a,(_getsn_sloc0_1_0 + 1)
	addc	a,(_getsn_buff_1_162 + 1)
	mov	r5,a
	mov	r6,(_getsn_buff_1_162 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	clr	a
	lcall	__gptrput
;	ControllerLCD.h:90: return j;
	mov	dpl,_getsn_sloc0_1_0
	mov	dph,(_getsn_sloc0_1_0 + 1)
	ret
L032002?:
;	ControllerLCD.h:94: buff[j]=c;
	mov	a,r1
	add	a,_getsn_buff_1_162
	mov	r4,a
	mov	a,r2
	addc	a,(_getsn_buff_1_162 + 1)
	mov	r5,a
	mov	r6,(_getsn_buff_1_162 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r3
	lcall	__gptrput
;	ControllerLCD.h:84: for(j=0; j<(len-1); j++)
	inc	r1
	cjne	r1,#0x00,L032018?
	inc	r2
L032018?:
	mov	_getsn_sloc0_1_0,r1
	mov	(_getsn_sloc0_1_0 + 1),r2
	sjmp	L032005?
L032008?:
;	ControllerLCD.h:97: buff[j]=0;
	mov	a,_getsn_sloc0_1_0
	add	a,_getsn_buff_1_162
	mov	r2,a
	mov	a,(_getsn_sloc0_1_0 + 1)
	addc	a,(_getsn_buff_1_162 + 1)
	mov	r3,a
	mov	r4,(_getsn_buff_1_162 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	clr	a
	lcall	__gptrput
;	ControllerLCD.h:98: return len;
	mov	dpl,_getsn_PARM_2
	mov	dph,(_getsn_PARM_2 + 1)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'printCharAsBinary'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;i                         Allocated to registers r3 r4 
;out                       Allocated to registers r5 
;------------------------------------------------------------
;	Controller.c:14: void printCharAsBinary(char c) {
;	-----------------------------------------
;	 function printCharAsBinary
;	-----------------------------------------
_printCharAsBinary:
	mov	r2,dpl
;	Controller.c:18: for (i = 7; i >= 0; i--) {
	mov	r3,#0x07
	mov	r4,#0x00
L033001?:
	mov	a,r4
	jb	acc.7,L033004?
;	Controller.c:19: out = (c >> i) & 1; // Shift right i bits, and mask all but the least significant bit
	mov	b,r3
	inc	b
	mov	a,r2
	rlc	a
	mov	ov,c
	mov	a,r2
	sjmp	L033012?
L033011?:
	mov	c,ov
	rrc	a
L033012?:
	djnz	b,L033011?
	anl	a,#0x01
;	Controller.c:20: printf("%d", out);
	mov	r5,a
	rlc	a
	subb	a,acc
	mov	r6,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xfb
	mov	sp,a
	pop	ar4
	pop	ar3
	pop	ar2
;	Controller.c:18: for (i = 7; i >= 0; i--) {
	dec	r3
	cjne	r3,#0xff,L033013?
	dec	r4
L033013?:
	sjmp	L033001?
L033004?:
;	Controller.c:22: printf("\n"); // Move to a new line after printing the binary representation
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;cnt                       Allocated to registers 
;vx_right                  Allocated with name '_main_vx_right_1_171'
;vy_right                  Allocated to registers r6 r7 r2 r3 
;sw_right                  Allocated with name '_main_sw_right_1_171'
;vx_left                   Allocated with name '_main_vx_left_1_171'
;vy_left                   Allocated with name '_main_vy_left_1_171'
;sw_left                   Allocated with name '_main_sw_left_1_171'
;vx1                       Allocated with name '_main_vx1_1_171'
;vy1                       Allocated with name '_main_vy1_1_171'
;vx2                       Allocated to registers r4 r5 
;vy2                       Allocated to registers r2 r3 
;timeout                   Allocated to registers r2 r3 
;freq                      Allocated with name '_main_freq_1_171'
;sw1                       Allocated to registers 
;sw2                       Allocated to registers 
;position                  Allocated to registers 
;------------------------------------------------------------
;	Controller.c:25: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	Controller.c:36: waitms(500);
	mov	dptr,#0x01F4
	lcall	_waitms
;	Controller.c:37: UART1_Init(9600);
	mov	dptr,#0x2580
	clr	a
	mov	b,a
	lcall	_UART1_Init
;	Controller.c:40: InitPinADC(2, 1); // Configure P2.1 as analog input
	mov	_InitPinADC_PARM_2,#0x01
	mov	dpl,#0x02
	lcall	_InitPinADC
;	Controller.c:41: InitPinADC(2, 2); // Configure P2.2 as analog input
	mov	_InitPinADC_PARM_2,#0x02
	mov	dpl,#0x02
	lcall	_InitPinADC
;	Controller.c:42: InitPinADC(2, 3); // Configure P2.3 as analog input
	mov	_InitPinADC_PARM_2,#0x03
	mov	dpl,#0x02
	lcall	_InitPinADC
;	Controller.c:43: InitPinADC(2, 4); // Configure P2.4 as analog input
	mov	_InitPinADC_PARM_2,#0x04
	mov	dpl,#0x02
	lcall	_InitPinADC
;	Controller.c:44: InitPinADC(2, 5); // Configure P2.5 as analog input
	mov	_InitPinADC_PARM_2,#0x05
	mov	dpl,#0x02
	lcall	_InitPinADC
;	Controller.c:45: InitPinADC(2, 6); // Configure P2.6 as analog input
	mov	_InitPinADC_PARM_2,#0x06
	mov	dpl,#0x02
	lcall	_InitPinADC
;	Controller.c:46: InitADC();
	lcall	_InitADC
;	Controller.c:48: LCD_4BIT();
	lcall	_LCD_4BIT
;	Controller.c:50: printf("\n\n---- Press and Hold both Joysticks to Calibrate ----\n");
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	Controller.c:51: Wait_For_Calibration();
	lcall	_Wait_For_Calibration
;	Controller.c:52: waitms(200);
	mov	dptr,#0x00C8
	lcall	_waitms
;	Controller.c:54: SendATCommand("AT+BAUD\r\n");
	mov	dptr,#__str_6
	mov	b,#0x80
	lcall	_SendATCommand
;	Controller.c:55: SendATCommand("AT+BAUD\r\n");
	mov	dptr,#__str_6
	mov	b,#0x80
	lcall	_SendATCommand
;	Controller.c:56: SendATCommand("AT+RFID\r\n");
	mov	dptr,#__str_7
	mov	b,#0x80
	lcall	_SendATCommand
;	Controller.c:57: SendATCommand("AT+DVIDA0C4\r\n");
	mov	dptr,#__str_8
	mov	b,#0x80
	lcall	_SendATCommand
;	Controller.c:59: SendATCommand("AT+RFC\r\n");  
	mov	dptr,#__str_9
	mov	b,#0x80
	lcall	_SendATCommand
;	Controller.c:60: SendATCommand("AT+POWE\r\n");
	mov	dptr,#__str_10
	mov	b,#0x80
	lcall	_SendATCommand
;	Controller.c:61: SendATCommand("AT+CLSS\r\n");
	mov	dptr,#__str_11
	mov	b,#0x80
	lcall	_SendATCommand
;	Controller.c:62: SendATCommand("AT+VER\r\n");
	mov	dptr,#__str_12
	mov	b,#0x80
	lcall	_SendATCommand
;	Controller.c:65: printf("\n\n---- CONTROLLER SETUP COMPLETE ----\n");
	mov	a,#__str_13
	push	acc
	mov	a,#(__str_13 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	Controller.c:69: while(1)
L034011?:
;	Controller.c:72: sw_left = Volts_at_Pin(QFP32_MUX_P2_6);
	mov	dpl,#0x13
	lcall	_Volts_at_Pin
	mov	_main_sw_left_1_171,dpl
	mov	(_main_sw_left_1_171 + 1),dph
	mov	(_main_sw_left_1_171 + 2),b
	mov	(_main_sw_left_1_171 + 3),a
;	Controller.c:73: vx_left = Volts_at_Pin(QFP32_MUX_P2_5);
	mov	dpl,#0x12
	lcall	_Volts_at_Pin
	mov	_main_vx_left_1_171,dpl
	mov	(_main_vx_left_1_171 + 1),dph
	mov	(_main_vx_left_1_171 + 2),b
	mov	(_main_vx_left_1_171 + 3),a
;	Controller.c:74: vy_left = Volts_at_Pin(QFP32_MUX_P2_4);
	mov	dpl,#0x11
	lcall	_Volts_at_Pin
	mov	_main_vy_left_1_171,dpl
	mov	(_main_vy_left_1_171 + 1),dph
	mov	(_main_vy_left_1_171 + 2),b
	mov	(_main_vy_left_1_171 + 3),a
;	Controller.c:76: sw_right = Volts_at_Pin(QFP32_MUX_P2_1);
	mov	dpl,#0x0E
	lcall	_Volts_at_Pin
	mov	_main_sw_right_1_171,dpl
	mov	(_main_sw_right_1_171 + 1),dph
	mov	(_main_sw_right_1_171 + 2),b
	mov	(_main_sw_right_1_171 + 3),a
;	Controller.c:77: vx_right = Volts_at_Pin(QFP32_MUX_P2_2);
	mov	dpl,#0x0F
	lcall	_Volts_at_Pin
	mov	_main_vx_right_1_171,dpl
	mov	(_main_vx_right_1_171 + 1),dph
	mov	(_main_vx_right_1_171 + 2),b
	mov	(_main_vx_right_1_171 + 3),a
;	Controller.c:78: vy_right = Volts_at_Pin(QFP32_MUX_P2_3);
	mov	dpl,#0x10
	lcall	_Volts_at_Pin
	mov	r6,dpl
	mov	r7,dph
	mov	r2,b
	mov	r3,a
;	Controller.c:80: vx1 = Voltage_to_Coordinate(vx_left);
	mov	dpl,_main_vx_left_1_171
	mov	dph,(_main_vx_left_1_171 + 1)
	mov	b,(_main_vx_left_1_171 + 2)
	mov	a,(_main_vx_left_1_171 + 3)
	push	ar2
	push	ar3
	push	ar6
	push	ar7
	lcall	_Voltage_to_Coordinate
	mov	_main_vx1_1_171,dpl
	mov	(_main_vx1_1_171 + 1),dph
;	Controller.c:81: vy1 = Voltage_to_Coordinate(vy_left);
	mov	dpl,_main_vy_left_1_171
	mov	dph,(_main_vy_left_1_171 + 1)
	mov	b,(_main_vy_left_1_171 + 2)
	mov	a,(_main_vy_left_1_171 + 3)
	lcall	_Voltage_to_Coordinate
	mov	_main_vy1_1_171,dpl
	mov	(_main_vy1_1_171 + 1),dph
;	Controller.c:82: vx2 = Voltage_to_Coordinate(vx_right);
	mov	dpl,_main_vx_right_1_171
	mov	dph,(_main_vx_right_1_171 + 1)
	mov	b,(_main_vx_right_1_171 + 2)
	mov	a,(_main_vx_right_1_171 + 3)
	lcall	_Voltage_to_Coordinate
	mov	r4,dpl
	mov	r5,dph
	pop	ar7
	pop	ar6
	pop	ar3
	pop	ar2
;	Controller.c:83: vy2 = Voltage_to_Coordinate(vy_right);
	mov	dpl,r6
	mov	dph,r7
	mov	b,r2
	mov	a,r3
	push	ar4
	push	ar5
	lcall	_Voltage_to_Coordinate
	mov	r2,dpl
	mov	r3,dph
	pop	ar5
	pop	ar4
;	Controller.c:84: sw1 = Check_Joystick_Button(sw_left); //Returns 1 if pressed, 0 otherwise
	mov	dpl,_main_sw_left_1_171
	mov	dph,(_main_sw_left_1_171 + 1)
	mov	b,(_main_sw_left_1_171 + 2)
	mov	a,(_main_sw_left_1_171 + 3)
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_Check_Joystick_Button
;	Controller.c:85: sw2 = Check_Joystick_Button(sw_right);
	mov	dpl,_main_sw_right_1_171
	mov	dph,(_main_sw_right_1_171 + 1)
	mov	b,(_main_sw_right_1_171 + 2)
	mov	a,(_main_sw_right_1_171 + 3)
	lcall	_Check_Joystick_Button
;	Controller.c:95: Generate_Motor_Command(&mcmd1,vx1,vy1);
	mov	_Generate_Motor_Command_PARM_2,_main_vx1_1_171
	mov	(_Generate_Motor_Command_PARM_2 + 1),(_main_vx1_1_171 + 1)
	mov	_Generate_Motor_Command_PARM_3,_main_vy1_1_171
	mov	(_Generate_Motor_Command_PARM_3 + 1),(_main_vy1_1_171 + 1)
	mov	dptr,#_mcmd1
	mov	b,#0x40
	lcall	_Generate_Motor_Command
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	Controller.c:96: Generate_Motor_Command(&mcmd2,vx2,vy2);
	mov	_Generate_Motor_Command_PARM_2,r4
	mov	(_Generate_Motor_Command_PARM_2 + 1),r5
	mov	_Generate_Motor_Command_PARM_3,r2
	mov	(_Generate_Motor_Command_PARM_3 + 1),r3
	mov	dptr,#_mcmd2
	mov	b,#0x40
	lcall	_Generate_Motor_Command
;	Controller.c:97: Weigh_Dual_Inputs(&mcmd,&mcmd1,&mcmd2,0.2);
	mov	_Weigh_Dual_Inputs_PARM_2,#_mcmd1
	mov	(_Weigh_Dual_Inputs_PARM_2 + 1),#0x00
	mov	(_Weigh_Dual_Inputs_PARM_2 + 2),#0x40
	mov	_Weigh_Dual_Inputs_PARM_3,#_mcmd2
	mov	(_Weigh_Dual_Inputs_PARM_3 + 1),#0x00
	mov	(_Weigh_Dual_Inputs_PARM_3 + 2),#0x40
	mov	_Weigh_Dual_Inputs_PARM_4,#0xCD
	mov	(_Weigh_Dual_Inputs_PARM_4 + 1),#0xCC
	mov	(_Weigh_Dual_Inputs_PARM_4 + 2),#0x4C
	mov	(_Weigh_Dual_Inputs_PARM_4 + 3),#0x3E
	mov	dptr,#_mcmd
	mov	b,#0x40
	lcall	_Weigh_Dual_Inputs
;	Controller.c:102: sprintf(tbuff,"%4d %3d\n",mcmd.left,mcmd.right);
	mov	r0,#(_mcmd + 0x0002)
	mov	ar2,@r0
	inc	r0
	mov	ar3,@r0
	mov	r0,#_mcmd
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#__str_14
	push	acc
	mov	a,#(__str_14 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_tbuff
	push	acc
	mov	a,#(_tbuff >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
;	Controller.c:106: sendstr1(tbuff);
	mov	dptr,#_tbuff
	mov	b,#0x40
	lcall	_sendstr1
;	Controller.c:107: printf(tbuff);
	mov	a,#_tbuff
	push	acc
	mov	a,#(_tbuff >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	Controller.c:110: while(1){ // check if there's data to recieve 
	mov	r2,#0x00
	mov	r3,#0x00
L034006?:
;	Controller.c:111: if(RXU1()) break;
	push	ar2
	push	ar3
	lcall	_RXU1
	pop	ar3
	pop	ar2
	jc	L034007?
;	Controller.c:112: Timer3us(100);
	mov	dpl,#0x64
	push	ar2
	push	ar3
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	Controller.c:113: timeout++;
	inc	r2
	cjne	r2,#0x00,L034021?
	inc	r3
L034021?:
;	Controller.c:114: if(timeout>1000) break;
	clr	c
	mov	a,#0xE8
	subb	a,r2
	mov	a,#(0x03 ^ 0x80)
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	jnc	L034006?
L034007?:
;	Controller.c:116: if(RXU1()){
	lcall	_RXU1
	jnc	L034009?
;	Controller.c:117: getstr1(rbuff);
	mov	dptr,#_rbuff
	mov	b,#0x40
	lcall	_getstr1
L034009?:
;	Controller.c:120: sscanf(rbuff,"%d",&freq);
	mov	a,#_main_freq_1_171
	push	acc
	mov	a,#(_main_freq_1_171 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_rbuff
	push	acc
	mov	a,#(_rbuff >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sscanf
	mov	a,sp
	add	a,#0xf7
	mov	sp,a
;	Controller.c:121: printf("%d\n",freq);
	push	_main_freq_1_171
	push	(_main_freq_1_171 + 1)
	mov	a,#__str_15
	push	acc
	mov	a,#(__str_15 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xfb
	mov	sp,a
	ljmp	L034011?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 'Initialized ADC at Pin %d_%d'
	db 0x0A
	db 0x00
__str_1:
	db 'Command: %s'
	db 0x00
__str_2:
	db 'Response: %s'
	db 0x0D
	db 0x0A
	db 0x00
__str_3:
	db '%d'
	db 0x00
__str_4:
	db 0x0A
	db 0x00
__str_5:
	db 0x0A
	db 0x0A
	db '---- Press and Hold both Joysticks to Calibrate ----'
	db 0x0A
	db 0x00
__str_6:
	db 'AT+BAUD'
	db 0x0D
	db 0x0A
	db 0x00
__str_7:
	db 'AT+RFID'
	db 0x0D
	db 0x0A
	db 0x00
__str_8:
	db 'AT+DVIDA0C4'
	db 0x0D
	db 0x0A
	db 0x00
__str_9:
	db 'AT+RFC'
	db 0x0D
	db 0x0A
	db 0x00
__str_10:
	db 'AT+POWE'
	db 0x0D
	db 0x0A
	db 0x00
__str_11:
	db 'AT+CLSS'
	db 0x0D
	db 0x0A
	db 0x00
__str_12:
	db 'AT+VER'
	db 0x0D
	db 0x0A
	db 0x00
__str_13:
	db 0x0A
	db 0x0A
	db '---- CONTROLLER SETUP COMPLETE ----'
	db 0x0A
	db 0x00
__str_14:
	db '%4d %3d'
	db 0x0A
	db 0x00
__str_15:
	db '%d'
	db 0x0A
	db 0x00

	CSEG

end
