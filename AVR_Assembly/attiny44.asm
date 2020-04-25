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

.EQU OCR0B = 0x3C

.EQU GIMSK = 0x3B
.EQU INT0 = 6
.EQU PCIE1 = 5
.EQU PCIE0 = 4

.EQU GIFR = 0x3A
.EQU INTF0 = 6
.EQU PCIF1 = 5
.EQU PCIF0 = 4

.EQU TIMSK0 = 0x39
.EQU OCIE0B = 2
.EQU OCIE0A = 1
.EQU TOIE0 = 0

.EQU TIFR0 = 0x38
.EQU OCF0B = 2
.EQU OCF0A = 1
.EQU TOV0 = 0

.EQU SPMCSR = 0x37
.EQU RSIG = 5
.EQU CTPB = 4
.EQU RFLB = 3
.EQU PGWRT = 2
.EQU PGERS = 1
.EQU SPMEN = 0

.EQU OCR0A = 0x36

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
.EQU CAL7 = 7
.EQU CAL6 = 6
.EQU CAL5 = 5
.EQU CAL4 = 4
.EQU CAL3 = 3
.EQU CAL2 = 2
.EQU CAL1 = 1
.EQU CAL0 = 0

.EQU TCCR0A = 0x30

.EQU TCCR1A = 0x2F

.EQU TCCR1B = 0x2E

.EQU TCNT1H = 0x2D

.EQU TCNT1L = 0x2C

.EQU OCR1AH = 0x2B

.EQU OCR1AL = 0x2A

.EQU OCR1BH = 0x29

.EQU OCR1BL = 0x28

.EQU DWDR = 0x27

.EQU CLKPR = 0x26
.EQU CLKPCE = 7
.EQU CLKPS3 = 3
.EQU CLKPS2 = 2
.EQU CLKPS1 = 1
.EQU CLKPS0 = 0

.EQU ICR1H = 0x25

.EQU ICR1L = 0x24

.EQU GTCCR = 0x23

.EQU TCCR1C = 0x22

.EQU WDTCSR = 0x21
.EQU WDIF = 7
.EQU WDIE = 6
.EQU WDP3 = 5
.EQU WDCE = 4
.EQU WDE = 3
.EQU WDP2 = 2
.EQU WDP1 = 1
.EQU WDP0 = 0

.EQU PCMSK1 = 0x20

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

.EQU PORTA = 0x1B

.EQU DDRA = 0x1A

.EQU PINA = 0x19

.EQU PORTB = 0x18       ; data output register port B
.EQU PORTB3 = 3
.EQU PORTB2 = 2
.EQU PORTB1 = 1
.EQU PORTB0 = 0

.EQU DDRB = 0x17        ; data direction register port B
.EQU DDB3 = 3
.EQU DDB2 = 2
.EQU DDB1 = 1
.EQU DDB0 = 0

.EQU PINB = 0x16        ; data input register port B
.EQU PINB3 = 3
.EQU PINB2 = 2
.EQU PINB1 = 1
.EQU PINB0 = 0

.EQU GPIOR2 = 0x15

.EQU GPIOR1 = 0x14

.EQU GPIOR0 = 0x13

.EQU PCMSK0 = 0x12

; reserved

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

.EQU TIMSK1 = 0x0C

.EQU TIFR1 = 0x0B

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

.EQU DIDR0 = 0x01

.EQU PRR = 0x00

; -------------------------------------------------------------------------------------------------
; STANDARD VALUES
; -------------------------------------------------------------------------------------------------
.EQU RAMEND = 0x015F