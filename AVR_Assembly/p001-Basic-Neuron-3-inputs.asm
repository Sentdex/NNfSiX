; -------------------------------------------------------------------------------------------------
; TITLE:       p001-Basic-Neuron-3-inputs 
; PROCESSOR:   Attiny85
;
; DESCRIPTION: I know this is insane, but also a great learning experience :D
;              
;              I use integer math
;              This will however reduce the maximum value to 255
;              With the introduction of negative numbers I am further limited to +/- 127
;              Let's see how this goes...
;
;              Negative numbers are handled as twos complement (standard for most binay systems)
;
;              For the first example, we can keep everything in registers for ultra fast access
;              Later on we have to fall back to the internal SRAM
;
; CONNECTIONS: For this example no pins have to be connected.
; -------------------------------------------------------------------------------------------------

.DEVICE attiny44                     ; device to check memory
.INCLUDE "AVR_Assembly/attiny44.asm" ; register map made by me
; warning: the register map is not finished yet!

; Interrupt vector routines | Nr | Source     | Description
Begin:
    rjmp Init               ;  1 | RESET      | Pin, Power on, Reset, Brown-out, Watchdog Reset
    reti                    ;  2 | INT0       | External Interrupt Request 0
    reti                    ;  3 | PCINT0     | Pin Change Interrupt Request 0
    reti                    ;  4 | TIM1_COMPA | Timer Counter 1 Compare Match A
    reti                    ;  5 | TIM1_OVF   | Timer Counter 1 Overflow
    reti                    ;  6 | TIM0_OVF   | Timer Counter 0 Overflow
    reti                    ;  7 | EE_RDY     | EEPROM Ready
    reti                    ;  8 | ANA_COMP   | Analog Comparator
    reti                    ;  9 | ADC        | ADC Conversion Complete
    reti                    ; 10 | TIM1_COMPB | Timer Counter 1 Compare Match B
    reti                    ; 11 | TIM0_COMPA | Timer Counter 0 Compare Match A
    reti                    ; 12 | TIM0_COMPB | Timer Counter 0 Compare Match B
    reti                    ; 13 | WDT        | Watchdog Time-out
    reti                    ; 14 | USI_START  | USI Start
    reti                    ; 15 | USI_OVF    | USI Overflow

;;
; @brief Initialization, runs once
;
; This function runs once at the start of the program
Init:
    ldi r16, high(RAMEND) ; load high part of adress
    out SPH, r16 ; set stack pointer to top of RAM
    ldi r16, low(RAMEND) ; load low part of adress
    out SPL, r16 ; set stack pointer to top of RAM
    ;sei ; enable interrupts

    ; im just gonna put stuff here since it has to run only once at the moment
    
    ; i had to change the inputs because it would overflow otherwise
    ; inputs
    ldi r18, 1 ;2
    ldi r19, 5 ;1
    ldi r20, 2 ;1

    ; weights
    ldi r21, 3 ;1
    ldi r22, 2 ;1
    ldi r23, 8 ;7

    ; bias
    ldi r24, 3 ;0

    ldi r25, 0x00 ; reset sum



    ; first input
    mov r16, r18 ; the first input
    mov r17, r21 ; the first weight

    ; an icall is used since this is more universal
    ; a normal rcall can only reach a limited jumping distance
    ldi r30, low(Multiply) ; the low address byte of the target address
    ldi r31, high(Multiply) ; the high address byte of the target address
    icall ; call the multiplication function

    mov r17, r25 ; the sum is the second number for the addition

    ldi r30, low(AddAndCap) ; the low address byte of the target address
    ldi r31, high(AddAndCap) ; the high address byte of the target address
    icall ; call the addition function

    mov r25, r16 ; store the result in the sum


    ; second input
    mov r16, r19 ; the first input
    mov r17, r22 ; the first weight

    ldi r30, low(Multiply) ; the low address byte of the target address
    ldi r31, high(Multiply) ; the high address byte of the target address
    icall ; call the multiplication function

    mov r17, r25 ; the sum is the second number for the addition

    ldi r30, low(AddAndCap) ; the low address byte of the target address
    ldi r31, high(AddAndCap) ; the high address byte of the target address
    icall ; call the addition function

    mov r25, r16 ; store the result in the sum


    ; third input
    mov r16, r20 ; the first input
    mov r17, r23 ; the first weight

    ldi r30, low(Multiply) ; the low address byte of the target address
    ldi r31, high(Multiply) ; the high address byte of the target address
    icall ; call the multiplication function

    mov r17, r25 ; the sum is the second number for the addition

    ldi r30, low(AddAndCap) ; the low address byte of the target address
    ldi r31, high(AddAndCap) ; the high address byte of the target address
    icall ; call the addition function


    ; bias
    mov r17, r24 ; the bias is the second number for the addition

    ldi r30, low(AddAndCap) ; the low address byte of the target address
    ldi r31, high(AddAndCap) ; the high address byte of the target address
    icall ; call the addition function

    ; the result is in r16 since thats the way the addition returns its result

;;
; @brief Main loop function
;
; This function loops (wow)
Main:
    ;wdr ; watchdog reset
    ldi r17, 0xFF ; bitmask for all pins in the register
    out DDRA, r17 ; define port as output

    out PORTA, r16 ; put the result on the pins
    ; now, using a logic analyser, I can probe the result
    rjmp Main

;;
; @brief Multiplis two values
;
; @param r16 - first input
; @param r17 - second input
; 
; @return r16 - the result of the multiplication
; 
; Multiplies the values from registers r16 and r17
; The limit for the result is +/- 127
; In the first step, the signs of both values are investigated
; This way we know, if the result has to be negative or positive
; Then it's basically the same as multiplication by hand
; The first number is shifted and added for every bit set in the other number
; At the end the sign is put back if necessary
Multiply:
    push r18 ; adder holder lower byte
    push r19 ; adder holder upper byte
    push r20 ; product holder lower byte
    push r21 ; product holder upper byte
    push r22 ; bitmask
    push r23 ; used to keep a copy of the second value
    push r24 ; stores sign during multiplication

    mov r24, r16 ; copy first number into r24
    eor r24, r17 ; if either is negative, the sign bit will be set. if none or both are, its cleared (- * - = +)

    sbrc r16, 7 ; if the first number is negative
    neg r16 ; make it positive

    sbrc r17, 7 ; if the second number is negative
    neg r17 ; make it positive

    mov r18, r16 ; copy first number into r18
    clr r19 ; clear r19
    clr r20 ; clear r20
    clr r21 ; clear r21
    ldi r22, 0x01 ; set bitmask to the first bit

Multiply_Outerloop:
    cpi r22, 0x80 ; when the bitmask reached the sign bit
    breq Multiply_LoopExit ; multiplication is done

    mov r23, r17 ; copy second number into r23
    and r23, r22 ; compare second number with bitmask
    breq Multiply_BitNotSet ; when the bit is not set, dont add anything

    add r20, r18 ; add the lower byte without carry
    adc r21, r19 ; add the upper byte and the carry from the lower byte

Multiply_BitNotSet:
    lsl r18 ; shift r18 left, lowest bit is 0, highest bit goes to carry
    rol r19 ; rotate r19 left, lowest bit is carry from r18
    lsl r22 ; shift bitmask left

    rjmp Multiply_Outerloop

Multiply_LoopExit:
    andi r21, 0xFF ; any bit in the upper byte is too much
    brne Multiply_SomeUpperBits
    mov r23, r20
    andi r23, 0x80 ; highest bit in lower byte is sign bit, it cannot be set
    breq Multiply_NoUpperBits

Multiply_SomeUpperBits:
    ldi r20, 0x7F ; highest possible number

Multiply_NoUpperBits:
    mov r16, r20

    sbrc r24, 7 ; if the sign bit is set
    neg r16 ; make the result negative

    pop r24
    pop r23
    pop r22
    pop r21
    pop r20
    pop r19
    pop r18
    ret

;;
; @brief Adds two values
;
; @param r16 - first input
; @param r17 - second input
; 
; @return r16 - the result of the multiplication
; 
; Adds the values in r16 and r17
; If the result would overflow 7 bits it is capped
; If the result would underflow (7 bits with sign set) it is capped negative
; This is overcomplicated but saver than making assumptions about the math unit
;
; the maximum output of an addition in binary is one bit more
; since the inputs HAVE to be 7 bits (if they are 8 bit it's your fault and treated as negative)
; we are allowed to add them
; now if it would overflow (it's converted to positive, no underflow possible)
; we can catch that by looking at most significant bit
AddAndCap:
    add r16, r17 ; add the numbers

    brvc AddAndCap_NoOverflow

    brpl AddAndCap_NegativeOverflow

    ; positive overflow
    ldi r16, 0x7F ; cap positive
    rjmp AddAndCap_NoOverflow

AddAndCap_NegativeOverflow:
    ldi r16, 0x80 ; cap negative

AddAndCap_NoOverflow:
    ret