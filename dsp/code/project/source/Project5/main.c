//--------------------------------------------------------------------------//
//																			//
//	 Name: 	Talkthrough with FIR for the ADSP-BF561 EZ-KIT Lite						//
//																			//
//--------------------------------------------------------------------------//
//																			//
//	(C) Copyright 2003 - Analog Devices, Inc.  All rights reserved.			//
//																			//
//	Project Name:	BF561 C Talkthrough TDM									//
//																			//
//	Date Modified:	16/10/03		HD		Rev 0.2							//
//																			//
//	Software:		VisualDSP++3.5											//
//																			//
//	Hardware:		ADSP-BF561 EZ-KIT Board									//
//																			//
//	Connections:	Dipswitch SW4 : set #6 to "on"							//
//					Dipswitch SW4 : set #5 to "off"							//
//					Connect an input source (such as a radio) to the Audio	//
//					input jack and an output source (such as headphones) to //
//					the Audio output jack									//
//																			//
//	Purpose:		This program sets up the SPI port on the ADSP-BF561 to  //
//					configure the AD1836 codec.  The SPI port is disabled 	//
//					after initialization.  The data to/from the codec are 	//
//					transfered over SPORT0 in TDM mode						//
//																			//
//--------------------------------------------------------------------------//

#include "Talkthrough.h"

// FIR stuffs 
#include "mds_def.h"
#include "filter.h"
#include "fir_coeff.h"

// AD1836 Control Register Values
volatile short sCodec1836TxRegs[CODEC_1836_REGS_LENGTH] =
{									
					DAC_CONTROL_1	| 0x010,
					DAC_CONTROL_2	| 0x000,
					DAC_VOLUME_0	| 0x3ff,
					DAC_VOLUME_1	| 0x3ff,
					DAC_VOLUME_2	| 0x3ff,
					DAC_VOLUME_3	| 0x3ff,
					DAC_VOLUME_4	| 0x3ff,
					DAC_VOLUME_5	| 0x3ff,
					ADC_CONTROL_1	| 0x000,
					ADC_CONTROL_2	| 0x020,
					ADC_CONTROL_3	| 0x000	
};


/**************************************************
    DMA RX and TX Ping-Pong Buffer Definitions  
***************************************************/
// SPORT0 DMA Receive Double Buffer, ping + pong
short RxBuffer[2*FRAMESIZE + 2*FRAMESIZE];

// SPORT0 DMA Transmit Double Buffer, ping + pong
short TxBuffer[2*FRAMESIZE + 2*FRAMESIZE];


short RxBUF[80*FRAMESIZE];
short TxBUF[80*FRAMESIZE];

// Ping Pong Buffer Pointers
short* RxPing = RxBuffer;
short* RxPong = RxBuffer + 2*FRAMESIZE;

short* TxPing = TxBuffer;
short* TxPong = TxBuffer + 2*FRAMESIZE;

/*************************************************
    FIR  Definitions
**************************************************/
#define DELAY_SIZE       BASE_TAPLENGTH

// delay buffers for left and right channels
fract16 delay_left[DELAY_SIZE];
fract16 delay_right[DELAY_SIZE];

// two instansces for left and right channel FIRs
fir_state_fr16 s_left;
fir_state_fr16 s_right;

//--------------------------------------------------------------------------//
// Function:	main														//
//																			//
// Description:	After calling a few initalization routines, main() just 	//
//				waits in a loop forever.  The code to process the incoming  //
//				data can be placed in the function Process_Data() in the 	//
//				file "Process_Data.c".										//
//--------------------------------------------------------------------------//
void main(void)
{

	// unblock Core B if dual core operation is desired	
#ifndef RUN_ON_SINGLE_CORE	// see talkthrough.h
	*pSICA_SYSCR &= 0xFFDF; // clear bit 5 to unlock  
#endif

	Init1836();
	Init_Sport0();
	Init_DMA();
	Init_Sport_Interrupts();
	Enable_DMA_Sport0();
     
    // FIR initializations
    fir_init(s_left, h, delay_left, BASE_TAPLENGTH);	
    fir_init(s_right, h, delay_right, BASE_TAPLENGTH);	

    	
	while(1);
}
