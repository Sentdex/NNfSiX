; -------------------------------------------------------------------------------------------------
; TITLE:       Template for Attiny85 assembler code
; PROCESSOR:   Attiny85
;
; DESCRIPTION: This template can be reused when writing programms for the specified processor.
;              It includes all important features like interrupt vector table and initialization of
;              the stack pointer etc. Combined with the include file "attiny85.asm" this builds a
;              complete set for programming the Attiny. Example tasks for compiling can be taken
;              from the .vscode folder.
;
; CONNECTIONS: For this example no pins have to be connected.
; -------------------------------------------------------------------------------------------------

.DEVICE attiny85                  ; device to check memory
.INCLUDE "attiny85.asm"           ; register map made by me

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

Init:
    ldi r16, high(RAMEND) ; load high part of adress
    out SPH, r16 ; set stack pointer to top of RAM
    ldi r16, low(RAMEND) ; load low part of adress
    out SPL, r16 ; set stack pointer to top of RAM
    ;sei ; enable interrupts

Main:
    ;wdr ; watchdog reset
    rjmp Main