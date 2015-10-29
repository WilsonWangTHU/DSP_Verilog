#include "Talkthrough.h"

//--------------------------------------------------------------------------//
// Function:	Process_Data()												//
//																			//
// Description: This function is called from inside the SPORT0 ISR every 	//
//				time a complete audio frame has been received. The new 		//
//				input samples can be found in the variables iChannel0LeftIn,//
//				iChannel0RightIn, iChannel1LeftIn and iChannel1RightIn 		//
//				respectively. The processed	data should be stored in 		//
//				iChannel0LeftOut, iChannel0RightOut, iChannel1LeftOut,		//
//				iChannel1RightOut, iChannel2LeftOut and	iChannel2RightOut	//
//				respectively.												//
//--------------------------------------------------------------------------//
void Process_Data(void)
{
	int iM0 = iChannel0LeftIn + iChannel0RightIn;
	int iS0 = iChannel0RightIn - iChannel0LeftIn;
	iChannel0LeftOut = iM0;
	iChannel0RightOut = iS0;
	
	int iM1 = iChannel1LeftIn + iChannel1RightIn;
	int iS1 = iChannel1RightIn - iChannel1LeftIn;
	iChannel1LeftOut = iM1;
	iChannel1RightOut = iS1;
}
