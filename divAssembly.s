#Creator: Gabriella Quattrone
#Date: Monday July 10, 5:57 PM
#Purpose: to replicate the div.c code in assembly
.global _start
.equ wordsize, 4
.equ quotient, %eax
.equ remainder, %edx

.data
/* unsigned int dividend = *argv[1];
    unsigned int divisor = *argv[2];
    unsigned int quotient = 0;
    unsigned int remain = 0;
    unsigned int mask = 1 << 31;
*/

dividend:
	.long 0
divisor:
	.long 0
counter:
	.long 1
mask:
	.long 0b1000000000000000000000000000000

.text

_start:
	nop
/* while(((mask & divisor) == 0) && (divisor << 1) <= dividend) {
        divisor <<= 1;
        counter <<= 1;
    }
*/

first_while:
	movl mask, %ebx #ebx = mask
	andl divisor, %ebx #ebx = mask & divisor
	cmpl $0, %ebx  #(mask & divisor) == 0
	jne second_while#skip while loop
	
	movl divisor, %ebx #ebx = divisor
	shll $1, %ebx #divisor << 1
	cmpl dividend, %ebx #ebx > dividend you jump
	jg second_while#skip while loop

	shll $1, divisor #divisor << 1
	shll $1, counter #counter << 1
	jmp first_while

/*while(counter > 0){
        if(dividend >= divisor){
            dividend -= divisor;
            quotient |= counter;
        }
        counter >>= 1;
        divisor >>= 1;
    }
*/
second_while:
	cmpl $0, counter #counter <= 0
	jle end #to end
	jmp if_state

if_state:
	movl dividend, %ebx #ebx = dividend
	cmpl divisor, %ebx #dividend < divisor
	jl end_while #skip over if state

	movl divisor, %ebx #ebx = divisor
	subl %ebx, dividend #dividend = dividend - divisor

	movl counter, %ecx #ecx = counter
	orl %ecx, quotient #quotient = quo | counter
	jmp end_while

end_while:
	shrl $1, counter #counter >>= 1
	shrl $1, divisor #divisor >>= 1
	jmp second_while

end:
	movl dividend, %ecx
	movl %ecx, remainder
	jmp done

done:
 	movl %eax, %eax

