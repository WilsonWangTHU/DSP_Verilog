#include "Talkthrough.h"
#include "filter.h"
#include <string.h>


extern fir_state_fr16 s_left;
extern fir_state_fr16 s_right;

//--------------------------------------------------------------------------//
// Function:	Process_Data()												//
//																			//
// Description: This function is called for each DMA RX Complete Interrupt, //
//				or 2*FRAMESIZE samples for a stereo signal. Then left and   //
//				right channels are separately filtered ping-pong mode.	    //
//--------------------------------------------------------------------------//
void Process_Data(void)
{
	   
	// Ping-Pong Flag	
    static int ping = 0;

    /* core processing in ping-pong mode */
    if(0 == ping) {
        
        
        // left and right channels filtering, ping slot
        _myfir_Dmac_asm(RxPing+0, TxPing+0, FRAMESIZE, &s_left, 2);
        _myfir_Dmac_asm(RxPing+1, TxPing+1, FRAMESIZE, &s_right, 2);

//        memcpy(TxPing, RxPing, 2*FRAMESIZE*sizeof(RxPing[0]));
        
    } else {

        
        // left and right channels filtering, pong slot        
        _myfir_Dmac_asm(RxPong+0, TxPong+0, FRAMESIZE, &s_left, 2);
        _myfir_Dmac_asm(RxPong+1, TxPong+1, FRAMESIZE, &s_right, 2);

//        memcpy(TxPong, RxPong, 2*FRAMESIZE*sizeof(RxPong[0]));

    }    	    
    

    
    static int cnt = 0;
    cnt = cnt + 1;
    
    if((cnt>=100) && (cnt<140)) 
    {
        if (0==ping)
        {
     		memcpy((void *)(RxBUF+2*FRAMESIZE*(cnt-100)),RxPing,2*FRAMESIZE*sizeof(RxPing[0]));
     		memcpy((void *)(TxBUF+2*FRAMESIZE*(cnt-100)),TxPing,2*FRAMESIZE*sizeof(TxPing[0]));
        }
     	else
     	{
     		memcpy((void *)(RxBUF+2*FRAMESIZE*(cnt-100)),RxPong,2*FRAMESIZE*sizeof(RxPong[0]));
     		memcpy((void *)(TxBUF+2*FRAMESIZE*(cnt-100)),TxPong,2*FRAMESIZE*sizeof(TxPong[0]));
     	}
    }
    
    ping ^= 0x1;
       
}
