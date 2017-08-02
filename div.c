//Creator: Gabriella Quattrone
//Date: Thursday July 6, 3:17 PM 
//Purpose: To implement division on two unsigned integers WITHOUT using division
#include <stdio.h>

int main(int argc, char* argv[])
{
    unsigned int dividend = *argv[1];
    unsigned int divisor = *argv[2];
    unsigned int quotient = 0;
    unsigned int counter = 1; //00000001
    unsigned int mask = 1 << 31; //we need to be able to check all 32 bits
    
    sscanf(argv[1], "%u", &dividend);
    sscanf(argv[2], "%u", &divisor);
    
    //copies made since the original values will change throughout the program
    unsigned int copyDiv = divisor; 
    unsigned int copyDend = dividend;
    
    while(((divisor & mask) == 0) && ((divisor << 1) <= dividend)){ 
    //the mask's very last bit is 1, so as long as the divisor's last bit != 1, && we want to check that the bit-shifted divisor <= dividend, then this part will run 
        divisor <<= 1; 
        counter <<= 1; //then counter, from 00001, is 00010
    }
    
    while(counter != 0){ 
        if(dividend >= divisor){ 
            dividend -= divisor;  //Example: 10/5  
            quotient |= counter; //00000 OR 00010 = 00010 = 2, correct for 10/5 
        }
        counter >>= 1; 
        divisor >>= 1; 
    }
    
    int rem = dividend;
   
    printf("%u / %u = %u R %u\n", copyDend, copyDiv, quotient, rem);
    return 0;   
}
