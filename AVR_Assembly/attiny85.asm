; -------------------------------------------------------------------------------------------------
; REGISTERS
; -------------------------------------------------------------------------------------------------
.EQU SREG = 0x3F        ; avr status register
.EQU SREG_I = 7         ; global interrupt enable
.EQU SREG_T = 6         ; bit copy storage
.EQU SREG_H = 5         ; half carry flag
.EQU SREG_S = 4         ; sign bit
.EQU SREG_V = 3         ; twos complement overflow flag
.EQU SREG_N = 2         ; negative flag
.EQU SREG_Z = 1         ; zero flag
.EQU SREG_C = 0         ; carry flag

.EQU SPH = 0x3E         ; stack pointer high
.EQU SP9 = 1            ; bit 9
.EQU SP8 = 0            ; bit 8

.EQU SPL = 0x3D         ; stack pointer low
.EQU SP7 = 7            ; bit 7
.EQU SP6 = 6            ; bit 6
.EQU SP5 = 5            ; bit 5
.EQU SP4 = 4            ; bit 4
.EQU SP3 = 3            ; bit 3
.EQU SP2 = 2            ; bit 2
.EQU SP1 = 1            ; bit 1
.EQU SP0 = 0            ; bit 0

; reserved

.EQU GIMSK = 0x3B
.EQU INT0 = 6
.EQU PCIE = 5

.EQU GIFR = 0x3A
.EQU INTF0 = 6
.EQU PCIF = 5

.EQU TIMSK = 0x39       ; timer interrupt mask
.EQU OCIE1A = 6         ; output compare interrupt enable timer counter 1 A
.EQU OCIE1B = 5         ; output compare interrupt enable timer counter 1 B
.EQU OCIE0A = 4         ; output compare interrupt enable timer counter 0 A
.EQU OCIE0B = 3         ; output compare interrupt enable timer counter 0 B
.EQU TOIE1 = 2          ; timer counter 1 overflow interrupt enable
.EQU TOIE0 = 1          ; timer coutner 0 overflow interrupt enable

.EQU TIFR = 0x38        ; timer interrupt flag register
.EQU OCF1A = 6          ; output compare flag A timer counter 1
.EQU OCF1B = 5          ; output compare flag B timer counter 1
.EQU OCF0A = 4          ; output compare flag A timer counter 0
.EQU OCF0B = 3          ; output compare flag B timer counter 0
.EQU TOV1 = 2           ; timer counter 1 overflow flag
.EQU TOV0 = 1           ; timer counter 1 overflow flag

.EQU SPMCSR = 0x37
.EQU RSIG = 5
.EQU CTPB = 4
.EQU RFLB = 3
.EQU PGWRT = 2
.EQU PGERS = 1
.EQU SPMEN = 0

; reserved

.EQU MCUCR = 0x35
.EQU BODS = 7
.EQU PUD = 6
.EQU SE = 5
.EQU SM1 = 4
.EQU SM0 = 3
.EQU BODSE = 2
.EQU ISC01 = 1
.EQU ISC00 = 0

.EQU MCUSR = 0x34
.EQU WDRF = 3
.EQU BORF = 2
.EQU EXTRF = 1
.EQU PORF = 0

.EQU TCCR0B = 0x33      ; timer couter 0 control register B
.EQU FOC0A = 7          ; force output compare A timer counter 0
.EQU FOC0B = 6          ; force output compare B timer counter 0
.EQU WGM02 = 3          ; waveform generation mode 2 timer counter 0
.EQU CS02 = 2           ; clock source 2 timer counter 0
.EQU CS01 = 1           ; clock source 1 timer counter 0
.EQU CS00 = 0           ; clock source 0 timer counter 0

.EQU TCNT0 = 0x32       ; timer counter 0

.EQU OSCCAL = 0x31      ; oscillator calibration register

.EQU TCCR1 = 0x30       ; timer counter 1 control register
.EQU CTC1 = 7
.EQU PWM1A = 6
.EQU COM1A1 = 5         ; compare output 1 A timer counter 1 
.EQU COM1A0 = 4         ; compare output 0 A timer counter 1
.EQU CS13 = 3           ; clock source 3 timer counter 1
.EQU CS12 = 2           ; clock source 2 timer counter 1
.EQU CS11 = 1           ; clock source 1 timer counter 1
.EQU CS10 = 0           ; clock source 0 timer counter 1

.EQU TCNT1 = 0x2F       ; timer counter 1

.EQU OCR1A = 0x2E       ; timer counter 1 compare register A

.EQU OCR1C = 0x2D       ; timer counter 1 compare register C

.EQU GTCCR = 0x2C       ; general timer counter control register
.EQU TSM = 7            ; timer counter synchronisation mode
.EQU PWM1B = 6
.EQU COM1B1 = 5
.EQU COM1B0 = 4
.EQU FOC1B = 3
.EQU FOC1A = 2
.EQU PSR1 = 1           ; prescaler reset timer counter 1
.EQU PSR0 = 0           ; prescaler reset timer counter 0

.EQU OCR1B = 0x2B       ; timer counter 1 compare register B

.EQU TCCR0A = 0x2A      ; timer conter 0 control register A
.EQU COM0A1 = 7         ; compare output 1 A timer counter 0
.EQU COM0A0 = 6         ; compare output 0 A timer counter 0
.EQU COM0B1 = 5         ; compare output 1 B timer counter 0
.EQU COM0B0 = 4         ; compare output 0 B timer counter 0
.EQU WGM01 = 1          ; waveform generation mode 1 timer counter 0
.EQU WGM00 = 0          ; waveform generation mode 0 timer counter 0

.EQU OCR0A = 0x29       ; timer counter 0 compare register A

.EQU OCR0B = 0x28       ; timer counter 0 compare register B

.EQU PLLCSR = 0x27
.EQU LSM = 7
.EQU PCKE = 2
.EQU PLLE = 1
.EQU PLOCK = 0

.EQU CLKPR = 0x26
.EQU CLKPCE = 7
.EQU CLKPS3 = 3
.EQU CLKPS2 = 2
.EQU CLKPS1 = 1
.EQU CLKPS0 = 0

.EQU DT1A = 0x25
.EQU DT1AH3 = 7
.EQU DT1AH2 = 6
.EQU DT1AH1 = 5
.EQU DT1AH0 = 4
.EQU DT1AL3 = 3
.EQU DT1AL2 = 2
.EQU DT1AL1 = 1
.EQU DT1AL0 = 0

.EQU DT1B = 0x24
.EQU DT1BH3 = 7
.EQU DT1BH2 = 6
.EQU DT1BH1 = 5
.EQU DT1BH0 = 4
.EQU DT1BL3 = 3
.EQU DT1BL2 = 2
.EQU DT1BL1 = 1
.EQU DT1BL0 = 0

.EQU DTPS1 = 0x23
.EQU DTPS11 = 1
.EQU DTPS10 = 0

.EQU DWDR = 0x22

.EQU WDTCR = 0x21
.EQU WDIF = 7
.EQU WDIE = 6
.EQU WDP3 = 5
.EQU WDCE = 4
.EQU WDE = 3
.EQU WDP2 = 2
.EQU WDP1 = 1
.EQU WDP0 = 0

.EQU PRR = 0x20
.EQU PRTIM1 = 3
.EQU PRTIM0 = 2
.EQU PRUSI = 1
.EQU PRADC = 0

.EQU EEARH = 0x1F
.EQU EEAR8 = 0

.EQU EEARL = 0x1E
.EQU EEAR7 = 7
.EQU EEAR6 = 6
.EQU EEAR5 = 5
.EQU EEAR4 = 4
.EQU EEAR3 = 3
.EQU EEAR2 = 2
.EQU EEAR1 = 1
.EQU EEAR0 = 0

.EQU EEDR = 0x1D        ; eeprom data register

.EQU EECR = 0x1C
.EQU EEPM1 = 5
.EQU EEPM0 = 4
.EQU EERIE = 3
.EQU EEMPE = 2
.EQU EEPE = 1
.EQU EERE = 0

; reserved

; reserved

; reserved

.EQU PORTB = 0x18       ; data output register port B
.EQU PORTB5 = 5
.EQU PORTB4 = 4
.EQU PORTB3 = 3
.EQU PORTB2 = 2
.EQU PORTB1 = 1
.EQU PORTB0 = 0

.EQU DDRB = 0x17        ; data direction register port B
.EQU DDB5 = 5
.EQU DDB4 = 4
.EQU DDB3 = 3
.EQU DDB2 = 2
.EQU DDB1 = 1
.EQU DDB0 = 0

.EQU PINB = 0x16        ; data input register port B
.EQU PINB5 = 5
.EQU PINB4 = 4
.EQU PINB3 = 3
.EQU PINB2 = 2
.EQU PINB1 = 1
.EQU PINB0 = 0

.EQU PCMSK = 0x15       ; pin change interrupt mask
.EQU PCINT5 = 5
.EQU PCINT4 = 4
.EQU PCINT3 = 3
.EQU PCINT2 = 2
.EQU PCINT1 = 1
.EQU PCINT0 = 0

.EQU DIDR0 = 0x14
.EQU ADC0D = 5
.EQU ADC2D = 4
.EQU ADC3D = 3
.EQU ADC1D = 2
.EQU AIN1D = 1
.EQU AIN0D = 0

.EQU GPIOR2 = 0x13      ; general purpose io register 2

.EQU GPIOR1 = 0x12      ; general purpose io register 1

.EQU GPIOR0 = 0x11      ; general purpose io register 0

.EQU USIBR = 0x10       ; usi buffer register

.EQU USIDR = 0x0F       ; usi data register

.EQU USISR = 0x0E       ; usi status register
.EQU USISIF = 7
.EQU USIOIF = 6
.EQU USIPF = 5
.EQU USIDC = 4
.EQU USICNT3 = 3
.EQU USICNT2 = 2
.EQU USICNT1 = 1
.EQU USICNT0 = 0

.EQU USICR = 0x0D       ; usi counter register
.EQU USISIE = 7
.EQU USIOIE = 6
.EQU USIWM1 = 5
.EQU USIWM0 = 4
.EQU USICS1 = 3
.EQU USICS0 = 2
.EQU USICLK = 1
.EQU USITC = 0

; reserved

; reserved

; reserved

; reserved

.EQU ACSR = 0x08
.EQU ACD = 7
.EQU ACBG = 6
.EQU ACO = 5
.EQU ACI = 4
.EQU ACIE = 3
.EQU ACIS1 = 1
.EQU ACIS0 = 0

.EQU ADMUX = 0x07
.EQU REFS1 = 7
.EQU REFS0 = 6
.EQU ADLAR = 5
.EQU REFS2 = 4
.EQU MUX3 = 3
.EQU MUX2 = 2
.EQU MUX1 = 1
.EQU MUX0 = 0

.EQU ADCSRA = 0x06
.EQU ADEN = 7
.EQU ADSC = 6
.EQU ADATE = 5
.EQU ADIF = 4
.EQU ADIE = 3
.EQU ADPS2 = 2
.EQU ADPS1 = 1
.EQU ADPS0 = 0

.EQU ADCH = 0x05        ; adc data high

.EQU ADCL = 0x04        ; adc data low

.EQU ADCSRB = 0x03
.EQU BIN = 7
.EQU ACME = 6
.EQU IPR = 5
.EQU ADTS2 = 2
.EQU ADTS1 = 1
.EQU ADTS0 = 0

; reserved

; reserved

; reserved

; -------------------------------------------------------------------------------------------------
; STANDARD VALUES
; -------------------------------------------------------------------------------------------------
.EQU RAMEND = 0x025F