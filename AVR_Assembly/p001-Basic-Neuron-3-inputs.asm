; -------------------------------------------------------------------------------------------------
; TITLE:       p001-Basic-Neuron-3-inputs 
; PROCESSOR:   Attiny85
;
; DESCRIPTION: I know this is insane, but also a great learning experience :D
;              I'm not sure yet about some points, for example:
;              - negative numbers
;              
;              I use integer math
;              This will however reduce the maximum value to 255
;              With the introduction of negative numbers I am further limited to +/- 127
;              Let's see how this goes...
;
;              For the first example, we can keep everything in registers for ultra fast access
;              Later on we have to fall back to the internal SRAM
;
; CONNECTIONS: For this example no pins have to be connected.
; -------------------------------------------------------------------------------------------------

.DEVICE attiny85                  ; device to check memory
.INCLUDE "attiny44.asm"           ; register map made by me
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

    ldi r25, 0x00 ; reset output

    mov r16, r18 ; the first input
    mov r17, r21 ; the first weight

    ; an icall is used since this is more universal
    ; a normal rcall can only reach a limited jumping distance
    ldi r30, low(Multiply) ; the low address byte of the target address
    ldi r31, high(Multiply) ; the high address byte of the target address
    icall ; call the multiplication function

    add r25, r16 ; add the result to the output
    brvs Outputoverflow ; in case of an overflow, go directly to the maximum value

    mov r16, r19 ; second input
    mov r17, r22 ; second weight
    icall ; the adddress of the multiplication is still loaded

    add r25, r16 ; add the result to the output
    brvs Outputoverflow ; in case of an overflow, go directly to the maximum value

    mov r16, r20 ; third input
    mov r17, r23 ; third weight
    icall ; multiply

    add r25, r16 ; add result to output
    brvs Outputoverflow ; in case of an overflow, go directly to the maximum value

    add r25, r24 ; add bias to the output
    brvc Nooutputoverflow ; in case of an overflow, go directly to the maximum value

    ; no underflow is handled yet
    ; also not sure about negative numbers in general

Outputoverflow:
    ldi r25, 0b01111111 ; maximum value

Nooutputoverflow:
    mov r16, r25 ; r16 is the output

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
; Registers r18 and r19 are used for the result before it is capped
; The limit for the result is +/- 127
; In the first step, the signs of both values are investigated
; This way we know, if the result has to be negative or positive
; Then the signs are cleared
; Next, a loop is executed r16 times
; For every iteration of the loop, r17 is added to the result
; If the lower result byte overflows, the upper byte is incremented
;
; I commented some lines out. Will have to check later...
Multiply:
    push r18 ; need this register for result
    push r19 ; need this register for result
    push r20 ; need this also
    push r21 ; also this

    ldi r20, 0x00 ; clear register

    ;ldi r18, 0x80 ; bitmask for the msb
    ;and r18, r16 ; if first byte is negative
    ;sbrc r18, 7 ; skip if bit is cleared (r16 is positive)
    ;ori r20, 0x01 ; set this bit if r16 is negative
    
    ;ldi r18, 0x80 ; bitmask for the msb
    ;and r18, r17 ; if the second byte is negative
    ;sbrc r18, 7 ; skip if bit is cleared (r17 is positive)
    ;com r20 ; this flips all bits in r20
    ; if the bit was set (r16 is negative) it is now reset (result is positive if both are negative)
    ; otherwise the bit is now set

    ; if r20 bit 0 is still set, the result has to be negative

    ; clear the sign of both bytes r16 and r17
    cbr r16, 0x80 ; remove sign of r16
    cbr r17, 0x80 ; remove sign of r17

    ldi r18, 0x00 ; reset register 18
    ldi r19, 0x00 ; reset register 19

Multiply_addr17:
    cpi r16, 0x00 ; compare r16 with 0
    breq Multiply_exit ; jump to end of multiply if r16 is zero
    dec r16 ; subtract one from r16
    add r18, r17 ; add r17 to the result
    brvc Multiply_nocarry ; if no overflow, skip
    inc r19 ; increment upper result byte by one

Multiply_nocarry:
    rjmp Multiply_addr17 ; next loop

Multiply_exit:
    ; the number has to be capped
    ;andi r19, 0xFF
    ;brne Multiply_numbertoobig ; if any bit in the upper byte is set, the number is too big
    ;andi r18, 0x80
    ;breq Multiply_numberisok ; if the lower bit is less then 8 bit
    
Multiply_numbertoobig:
    ;ldi r18, 0b01111111 ; the largest possible number (capped)

Multiply_numberisok:
    ; the sign has to be added again
    ;sbrc r20, 0 ; if the sign has not to be set, skip
    ;sbr r18, 7 ; set the sign if it has to be set

    mov r16, r18 ; move the result in r16

    pop r21 ; return the original value
    pop r20 ; return the original value
    pop r19 ; return the original value
    pop r18 ; return the original value
    ret ; jump back to where the function was called from