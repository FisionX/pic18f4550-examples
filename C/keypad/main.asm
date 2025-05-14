;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4550
	radix	dec
	CONFIG	XINST=OFF
	CONFIG	FOSC=HS
	CONFIG	WDT=OFF
	CONFIG	LVP=OFF
	CONFIG	MCLRE=OFF


;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global	_isr
	global	_tmr_isr
	global	_numpad_isr
	global	_number_to_7seg
	global	_display
	global	_shift_left
	global	_start_display
	global	_setup
	global	_main
	global	_sram_end
	global	_digit
	global	_dsp_en

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_SPPCFGbits
	extern	_SPPEPSbits
	extern	_SPPCONbits
	extern	_UFRMLbits
	extern	_UFRMHbits
	extern	_UIRbits
	extern	_UIEbits
	extern	_UEIRbits
	extern	_UEIEbits
	extern	_USTATbits
	extern	_UCONbits
	extern	_UADDRbits
	extern	_UCFGbits
	extern	_UEP0bits
	extern	_UEP1bits
	extern	_UEP2bits
	extern	_UEP3bits
	extern	_UEP4bits
	extern	_UEP5bits
	extern	_UEP6bits
	extern	_UEP7bits
	extern	_UEP8bits
	extern	_UEP9bits
	extern	_UEP10bits
	extern	_UEP11bits
	extern	_UEP12bits
	extern	_UEP13bits
	extern	_UEP14bits
	extern	_UEP15bits
	extern	_PORTAbits
	extern	_PORTBbits
	extern	_PORTCbits
	extern	_PORTDbits
	extern	_PORTEbits
	extern	_LATAbits
	extern	_LATBbits
	extern	_LATCbits
	extern	_LATDbits
	extern	_LATEbits
	extern	_DDRAbits
	extern	_TRISAbits
	extern	_DDRBbits
	extern	_TRISBbits
	extern	_DDRCbits
	extern	_TRISCbits
	extern	_DDRDbits
	extern	_TRISDbits
	extern	_DDREbits
	extern	_TRISEbits
	extern	_OSCTUNEbits
	extern	_PIE1bits
	extern	_PIR1bits
	extern	_IPR1bits
	extern	_PIE2bits
	extern	_PIR2bits
	extern	_IPR2bits
	extern	_EECON1bits
	extern	_RCSTAbits
	extern	_TXSTAbits
	extern	_T3CONbits
	extern	_CMCONbits
	extern	_CVRCONbits
	extern	_CCP1ASbits
	extern	_ECCP1ASbits
	extern	_CCP1DELbits
	extern	_ECCP1DELbits
	extern	_BAUDCONbits
	extern	_BAUDCTLbits
	extern	_CCP2CONbits
	extern	_CCP1CONbits
	extern	_ECCP1CONbits
	extern	_ADCON2bits
	extern	_ADCON1bits
	extern	_ADCON0bits
	extern	_SSPCON2bits
	extern	_SSPCON1bits
	extern	_SSPSTATbits
	extern	_T2CONbits
	extern	_T1CONbits
	extern	_RCONbits
	extern	_WDTCONbits
	extern	_HLVDCONbits
	extern	_LVDCONbits
	extern	_OSCCONbits
	extern	_T0CONbits
	extern	_STATUSbits
	extern	_INTCON3bits
	extern	_INTCON2bits
	extern	_INTCONbits
	extern	_STKPTRbits
	extern	_SPPDATA
	extern	_SPPCFG
	extern	_SPPEPS
	extern	_SPPCON
	extern	_UFRM
	extern	_UFRML
	extern	_UFRMH
	extern	_UIR
	extern	_UIE
	extern	_UEIR
	extern	_UEIE
	extern	_USTAT
	extern	_UCON
	extern	_UADDR
	extern	_UCFG
	extern	_UEP0
	extern	_UEP1
	extern	_UEP2
	extern	_UEP3
	extern	_UEP4
	extern	_UEP5
	extern	_UEP6
	extern	_UEP7
	extern	_UEP8
	extern	_UEP9
	extern	_UEP10
	extern	_UEP11
	extern	_UEP12
	extern	_UEP13
	extern	_UEP14
	extern	_UEP15
	extern	_PORTA
	extern	_PORTB
	extern	_PORTC
	extern	_PORTD
	extern	_PORTE
	extern	_LATA
	extern	_LATB
	extern	_LATC
	extern	_LATD
	extern	_LATE
	extern	_DDRA
	extern	_TRISA
	extern	_DDRB
	extern	_TRISB
	extern	_DDRC
	extern	_TRISC
	extern	_DDRD
	extern	_TRISD
	extern	_DDRE
	extern	_TRISE
	extern	_OSCTUNE
	extern	_PIE1
	extern	_PIR1
	extern	_IPR1
	extern	_PIE2
	extern	_PIR2
	extern	_IPR2
	extern	_EECON1
	extern	_EECON2
	extern	_EEDATA
	extern	_EEADR
	extern	_RCSTA
	extern	_TXSTA
	extern	_TXREG
	extern	_RCREG
	extern	_SPBRG
	extern	_SPBRGH
	extern	_T3CON
	extern	_TMR3
	extern	_TMR3L
	extern	_TMR3H
	extern	_CMCON
	extern	_CVRCON
	extern	_CCP1AS
	extern	_ECCP1AS
	extern	_CCP1DEL
	extern	_ECCP1DEL
	extern	_BAUDCON
	extern	_BAUDCTL
	extern	_CCP2CON
	extern	_CCPR2
	extern	_CCPR2L
	extern	_CCPR2H
	extern	_CCP1CON
	extern	_ECCP1CON
	extern	_CCPR1
	extern	_CCPR1L
	extern	_CCPR1H
	extern	_ADCON2
	extern	_ADCON1
	extern	_ADCON0
	extern	_ADRES
	extern	_ADRESL
	extern	_ADRESH
	extern	_SSPCON2
	extern	_SSPCON1
	extern	_SSPSTAT
	extern	_SSPADD
	extern	_SSPBUF
	extern	_T2CON
	extern	_PR2
	extern	_TMR2
	extern	_T1CON
	extern	_TMR1
	extern	_TMR1L
	extern	_TMR1H
	extern	_RCON
	extern	_WDTCON
	extern	_HLVDCON
	extern	_LVDCON
	extern	_OSCCON
	extern	_T0CON
	extern	_TMR0
	extern	_TMR0L
	extern	_TMR0H
	extern	_STATUS
	extern	_FSR2L
	extern	_FSR2H
	extern	_PLUSW2
	extern	_PREINC2
	extern	_POSTDEC2
	extern	_POSTINC2
	extern	_INDF2
	extern	_BSR
	extern	_FSR1L
	extern	_FSR1H
	extern	_PLUSW1
	extern	_PREINC1
	extern	_POSTDEC1
	extern	_POSTINC1
	extern	_INDF1
	extern	_WREG
	extern	_FSR0L
	extern	_FSR0H
	extern	_PLUSW0
	extern	_PREINC0
	extern	_POSTDEC0
	extern	_POSTINC0
	extern	_INDF0
	extern	_INTCON3
	extern	_INTCON2
	extern	_INTCON
	extern	_PROD
	extern	_PRODL
	extern	_PRODH
	extern	_TABLAT
	extern	_TBLPTR
	extern	_TBLPTRL
	extern	_TBLPTRH
	extern	_TBLPTRU
	extern	_PC
	extern	_PCL
	extern	_PCLATH
	extern	_PCLATU
	extern	_STKPTR
	extern	_TOS
	extern	_TOSL
	extern	_TOSH
	extern	_TOSU
	extern	_delay1ktcy
	extern	__moduint
	extern	__divuint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
BSR	equ	0xfe0
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
_digit	db	0x00, 0x00, 0x00, 0x00
_dsp_en	db	0x00


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1
r0x08	res	1


ustat_main_00	udata	0X07FF
_sram_end      	res	0

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_main_ivec_0x1_isr	code	0X000008
ivec_0x1_isr:
	GOTO	_isr

; I code from now on!
; ; Starting pCode block
S_main__main	code
_main:
;	.line	186; main.c	setup();
	CALL	_setup
;	.line	187; main.c	start_display();
	CALL	_start_display
_00393_DS_:
;	.line	189; main.c	PORTB = 0xe; 
	MOVLW	0x0e
	MOVWF	_PORTB
;	.line	190; main.c	delay1ktcy(POLLINGRATE);
	MOVLW	0x64
	CALL	_delay1ktcy
;	.line	191; main.c	PORTB = 0xD; 
	MOVLW	0x0d
	MOVWF	_PORTB
;	.line	192; main.c	delay1ktcy(POLLINGRATE);
	MOVLW	0x64
	CALL	_delay1ktcy
;	.line	193; main.c	PORTB = 0xB; 
	MOVLW	0x0b
	MOVWF	_PORTB
;	.line	194; main.c	delay1ktcy(POLLINGRATE);
	MOVLW	0x64
	CALL	_delay1ktcy
;	.line	195; main.c	PORTB = 0x7; 
	MOVLW	0x07
	MOVWF	_PORTB
;	.line	196; main.c	delay1ktcy(POLLINGRATE);
	MOVLW	0x64
	CALL	_delay1ktcy
	BRA	_00393_DS_
;	.line	199; main.c	}
	RETURN	

; ; Starting pCode block
S_main__setup	code
_setup:
;	.line	160; main.c	void setup(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	162; main.c	LATD = 0;
	CLRF	_LATD
;	.line	163; main.c	TRISD = 0;
	CLRF	_TRISD
;	.line	165; main.c	TRISB = 0xf0;
	MOVLW	0xf0
	MOVWF	_TRISB
;	.line	166; main.c	LATB = 0x00;
	CLRF	_LATB
;	.line	167; main.c	ADCON1 = 0xf;
	MOVLW	0x0f
	MOVWF	_ADCON1
;	.line	168; main.c	INTCON2bits.RBPU = 0;
	BCF	_INTCON2bits, 7
;	.line	170; main.c	TRISE = 0;
	CLRF	_TRISE
;	.line	171; main.c	LATE = 0;
	CLRF	_LATE
;	.line	173; main.c	TRISA = 0;
	CLRF	_TRISA
;	.line	174; main.c	LATA = 0;
	CLRF	_LATA
;	.line	177; main.c	INTCONbits.GIE = 1;
	BSF	_INTCONbits, 7
;	.line	178; main.c	INTCONbits.PEIE = 1;
	BSF	_INTCONbits, 6
;	.line	179; main.c	INTCONbits.RBIE = 1;
	BSF	_INTCONbits, 3
;	.line	180; main.c	INTCON2bits.RBIP = 1;
	BSF	_INTCON2bits, 0
;	.line	181; main.c	RCONbits.IPEN = 1;
	BSF	_RCONbits, 7
;	.line	183; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__start_display	code
_start_display:
;	.line	149; main.c	void start_display(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	151; main.c	INTCONbits.TMR0IE = 1;
	BSF	_INTCONbits, 5
;	.line	152; main.c	INTCON2bits.TMR0IP = 1;
	BSF	_INTCON2bits, 2
;	.line	154; main.c	T0CONbits.T08BIT = 1;
	BSF	_T0CONbits, 6
;	.line	155; main.c	T0CONbits.T0CS = 0; // Source internal oscilator
	BCF	_T0CONbits, 5
;	.line	156; main.c	T0CONbits.PSA = 0;
	BCF	_T0CONbits, 3
;	.line	157; main.c	T0CONbits.T0PS = 0x7;
	MOVF	_T0CONbits, W
	ANDLW	0xf8
	IORLW	0x07
	MOVWF	_T0CONbits
;	.line	158; main.c	T0CONbits.TMR0ON = 1;
	BSF	_T0CONbits, 7
;	.line	159; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__shift_left	code
_shift_left:
;	.line	144; main.c	void shift_left(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	145; main.c	digit[3] = digit[2];
	MOVFF	(_digit + 2), r0x00
	MOVF	r0x00, W
	BANKSEL	(_digit + 3)
	MOVWF	(_digit + 3), B
;	.line	146; main.c	digit[2] = digit[1];
	MOVFF	(_digit + 1), r0x00
	MOVF	r0x00, W
	BANKSEL	(_digit + 2)
	MOVWF	(_digit + 2), B
;	.line	147; main.c	digit[1] = digit[0];
	MOVFF	_digit, r0x00
	MOVF	r0x00, W
	BANKSEL	(_digit + 1)
	MOVWF	(_digit + 1), B
;	.line	148; main.c	}
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__display	code
_display:
;	.line	135; main.c	void display(uint16_t num){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	137; main.c	if (num > 9999) return;
	MOVF	r0x00, W
	MOVWF	r0x02
	MOVF	r0x01, W
	MOVWF	r0x03
	MOVLW	0x27
	SUBWF	r0x03, W
	BNZ	_00372_DS_
	MOVLW	0x10
	SUBWF	r0x02, W
_00372_DS_:
	BC	_00351_DS_
;	.line	138; main.c	while(num) {
	CLRF	r0x02
_00348_DS_:
	MOVF	r0x01, W
	IORWF	r0x00, W
	BZ	_00351_DS_
;	.line	139; main.c	digit[i] = num%10;
	MOVLW	LOW(_digit)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	HIGH(_digit)
	ADDWFC	r0x04, F
	MOVF	r0x00, W
	MOVWF	r0x05
	MOVF	r0x01, W
	MOVWF	r0x06
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	__moduint
	MOVWF	r0x07
	MOVFF	PRODL, r0x08
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	r0x07, INDF0
;	.line	140; main.c	num = num/10;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	__divuint
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x03, W
	MOVWF	r0x00
	MOVF	r0x04, W
	MOVWF	r0x01
;	.line	141; main.c	i++;
	INCF	r0x02, F
	BRA	_00348_DS_
_00351_DS_:
;	.line	143; main.c	}
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__number_to_7seg	code
_number_to_7seg:
;	.line	97; main.c	uint8_t number_to_7seg(uint8_t number) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	98; main.c	switch (number) {
	MOVLW	0x10
	SUBWF	r0x00, W
	BTFSC	STATUS, 0
	BRA	_00330_DS_
	CLRF	PCLATH
	CLRF	PCLATU
	RLCF	r0x00, W
	RLCF	PCLATH, F
	RLCF	WREG, W
	RLCF	PCLATH, F
	ANDLW	0xfc
	ADDLW	LOW(_00341_DS_)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_00341_DS_)
	ADDWFC	PCLATH, F
	MOVLW	UPPER(_00341_DS_)
	ADDWFC	PCLATU, F
	MOVF	PREINC1, W
	MOVWF	PCL
_00341_DS_:
	GOTO	_00314_DS_
	GOTO	_00315_DS_
	GOTO	_00316_DS_
	GOTO	_00317_DS_
	GOTO	_00318_DS_
	GOTO	_00319_DS_
	GOTO	_00320_DS_
	GOTO	_00321_DS_
	GOTO	_00322_DS_
	GOTO	_00323_DS_
	GOTO	_00324_DS_
	GOTO	_00325_DS_
	GOTO	_00326_DS_
	GOTO	_00327_DS_
	GOTO	_00328_DS_
	GOTO	_00329_DS_
_00314_DS_:
;	.line	100; main.c	return 0x3F;
	MOVLW	0x3f
	BRA	_00332_DS_
_00315_DS_:
;	.line	102; main.c	return 0x06;
	MOVLW	0x06
	BRA	_00332_DS_
_00316_DS_:
;	.line	104; main.c	return 0x5B;
	MOVLW	0x5b
	BRA	_00332_DS_
_00317_DS_:
;	.line	106; main.c	return 0x4F;
	MOVLW	0x4f
	BRA	_00332_DS_
_00318_DS_:
;	.line	108; main.c	return 0x66;
	MOVLW	0x66
	BRA	_00332_DS_
_00319_DS_:
;	.line	110; main.c	return 0x6D;
	MOVLW	0x6d
	BRA	_00332_DS_
_00320_DS_:
;	.line	112; main.c	return 0x7D;
	MOVLW	0x7d
	BRA	_00332_DS_
_00321_DS_:
;	.line	114; main.c	return 0x07;
	MOVLW	0x07
	BRA	_00332_DS_
_00322_DS_:
;	.line	116; main.c	return 0x7F;
	MOVLW	0x7f
	BRA	_00332_DS_
_00323_DS_:
;	.line	118; main.c	return 0x6F;
	MOVLW	0x6f
	BRA	_00332_DS_
_00324_DS_:
;	.line	120; main.c	return 0x77;
	MOVLW	0x77
	BRA	_00332_DS_
_00325_DS_:
;	.line	122; main.c	return 0x7c;
	MOVLW	0x7c
	BRA	_00332_DS_
_00326_DS_:
;	.line	124; main.c	return 0x39;
	MOVLW	0x39
	BRA	_00332_DS_
_00327_DS_:
;	.line	126; main.c	return 0x5e;
	MOVLW	0x5e
	BRA	_00332_DS_
_00328_DS_:
;	.line	128; main.c	return 0x79;
	MOVLW	0x79
	BRA	_00332_DS_
_00329_DS_:
;	.line	130; main.c	return 0x71;
	MOVLW	0x71
	BRA	_00332_DS_
_00330_DS_:
;	.line	132; main.c	return 0;
	CLRF	WREG
_00332_DS_:
;	.line	134; main.c	}
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__numpad_isr	code
_numpad_isr:
;	.line	65; main.c	void numpad_isr(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	67; main.c	uint8_t number = 0;
	CLRF	r0x00
;	.line	68; main.c	if ((PORTB & 0xf0) == 0xf0) return;
	MOVFF	_PORTB, r0x01
	CLRF	r0x02
	MOVLW	0xf0
	ANDWF	r0x01, F
	CLRF	r0x02
	MOVF	r0x01, W
	XORLW	0xf0
	BNZ	_00308_DS_
	MOVF	r0x02, W
	BZ	_00309_DS_
_00308_DS_:
	BRA	_00143_DS_
_00309_DS_:
	BRA	_00185_DS_
_00143_DS_:
;	.line	69; main.c	if (!PORTBbits.RB0) {
	BTFSC	_PORTBbits, 0
	BRA	_00183_DS_
;	.line	70; main.c	if (!PORTBbits.RB4) number = 1;
	BTFSC	_PORTBbits, 4
	BRA	_00145_DS_
	MOVLW	0x01
	MOVWF	r0x00
_00145_DS_:
;	.line	71; main.c	if (!PORTBbits.RB5) number = 2;
	BTFSC	_PORTBbits, 5
	BRA	_00147_DS_
	MOVLW	0x02
	MOVWF	r0x00
_00147_DS_:
;	.line	72; main.c	if (!PORTBbits.RB6) number = 3;
	BTFSC	_PORTBbits, 6
	BRA	_00149_DS_
	MOVLW	0x03
	MOVWF	r0x00
_00149_DS_:
;	.line	73; main.c	if (!PORTBbits.RB7) number = 0xA;
	BTFSC	_PORTBbits, 7
	BRA	_00184_DS_
	MOVLW	0x0a
	MOVWF	r0x00
	BRA	_00184_DS_
_00183_DS_:
;	.line	75; main.c	else if (!PORTBbits.RB1) {
	BTFSC	_PORTBbits, 1
	BRA	_00180_DS_
;	.line	76; main.c	if (!PORTBbits.RB4) number = 4;
	BTFSC	_PORTBbits, 4
	BRA	_00153_DS_
	MOVLW	0x04
	MOVWF	r0x00
_00153_DS_:
;	.line	77; main.c	if (!PORTBbits.RB5) number = 5;
	BTFSC	_PORTBbits, 5
	BRA	_00155_DS_
	MOVLW	0x05
	MOVWF	r0x00
_00155_DS_:
;	.line	78; main.c	if (!PORTBbits.RB6) number = 6;
	BTFSC	_PORTBbits, 6
	BRA	_00157_DS_
	MOVLW	0x06
	MOVWF	r0x00
_00157_DS_:
;	.line	79; main.c	if (!PORTBbits.RB7) number = 0xB;
	BTFSC	_PORTBbits, 7
	BRA	_00184_DS_
	MOVLW	0x0b
	MOVWF	r0x00
	BRA	_00184_DS_
_00180_DS_:
;	.line	81; main.c	else if (!PORTBbits.RB2) {
	BTFSC	_PORTBbits, 2
	BRA	_00177_DS_
;	.line	82; main.c	if (!PORTBbits.RB4) number = 7;
	BTFSC	_PORTBbits, 4
	BRA	_00161_DS_
	MOVLW	0x07
	MOVWF	r0x00
_00161_DS_:
;	.line	83; main.c	if (!PORTBbits.RB5) number = 8;
	BTFSC	_PORTBbits, 5
	BRA	_00163_DS_
	MOVLW	0x08
	MOVWF	r0x00
_00163_DS_:
;	.line	84; main.c	if (!PORTBbits.RB6) number = 9;
	BTFSC	_PORTBbits, 6
	BRA	_00165_DS_
	MOVLW	0x09
	MOVWF	r0x00
_00165_DS_:
;	.line	85; main.c	if (!PORTBbits.RB7) number = 0xC;
	BTFSC	_PORTBbits, 7
	BRA	_00184_DS_
	MOVLW	0x0c
	MOVWF	r0x00
	BRA	_00184_DS_
_00177_DS_:
;	.line	87; main.c	else if (!PORTBbits.RB3) {
	BTFSC	_PORTBbits, 3
	BRA	_00184_DS_
;	.line	89; main.c	if (!PORTBbits.RB5) number = 0;
	BTFSC	_PORTBbits, 5
	BRA	_00169_DS_
	CLRF	r0x00
_00169_DS_:
;	.line	90; main.c	if (!PORTBbits.RB6) number = 0xF;
	BTFSC	_PORTBbits, 6
	BRA	_00171_DS_
	MOVLW	0x0f
	MOVWF	r0x00
_00171_DS_:
;	.line	91; main.c	if (!PORTBbits.RB7) number = 0xD;
	BTFSC	_PORTBbits, 7
	BRA	_00184_DS_
	MOVLW	0x0d
	MOVWF	r0x00
_00184_DS_:
;	.line	93; main.c	shift_left();
	CALL	_shift_left
;	.line	94; main.c	digit[0] = number;
	MOVF	r0x00, W
	BANKSEL	_digit
	MOVWF	_digit, B
_00185_DS_:
;	.line	95; main.c	}
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__tmr_isr	code
_tmr_isr:
;	.line	43; main.c	void tmr_isr(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	44; main.c	LATA = LATE = 0;
	CLRF	_LATE
	CLRF	_LATA
;	.line	45; main.c	LATD = number_to_7seg(digit[dsp_en]);
	MOVLW	LOW(_digit)
	BANKSEL	_dsp_en
	ADDWF	_dsp_en, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_digit)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_number_to_7seg
	MOVWF	_LATD
	MOVF	POSTINC1, F
;	.line	46; main.c	switch (dsp_en) {
	MOVLW	0x04
	BANKSEL	_dsp_en
	SUBWF	_dsp_en, W, B
	BC	_00118_DS_
	CLRF	PCLATH
	CLRF	PCLATU
	BANKSEL	_dsp_en
	RLCF	_dsp_en, W, B
	RLCF	PCLATH, F
	RLCF	WREG, W
	RLCF	PCLATH, F
	ANDLW	0xfc
	ADDLW	LOW(_00136_DS_)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_00136_DS_)
	ADDWFC	PCLATH, F
	MOVLW	UPPER(_00136_DS_)
	ADDWFC	PCLATU, F
	MOVF	PREINC1, W
	MOVWF	PCL
_00136_DS_:
	GOTO	_00114_DS_
	GOTO	_00115_DS_
	GOTO	_00116_DS_
	GOTO	_00117_DS_
_00114_DS_:
;	.line	48; main.c	LATA = 0;
	CLRF	_LATA
;	.line	49; main.c	LATE = 0x4;
	MOVLW	0x04
	MOVWF	_LATE
;	.line	50; main.c	break;
	BRA	_00118_DS_
_00115_DS_:
;	.line	52; main.c	LATE = 0x2;
	MOVLW	0x02
	MOVWF	_LATE
;	.line	53; main.c	break;
	BRA	_00118_DS_
_00116_DS_:
;	.line	55; main.c	LATE = 0x1;
	MOVLW	0x01
	MOVWF	_LATE
;	.line	56; main.c	break;
	BRA	_00118_DS_
_00117_DS_:
;	.line	58; main.c	LATE = 0;
	CLRF	_LATE
;	.line	59; main.c	LATA = 0x10;
	MOVLW	0x10
	MOVWF	_LATA
_00118_DS_:
	BANKSEL	_dsp_en
;	.line	62; main.c	dsp_en++;
	INCF	_dsp_en, F, B
;	.line	63; main.c	if (dsp_en > 3) dsp_en = 0;
	MOVLW	0x04
	BANKSEL	_dsp_en
	SUBWF	_dsp_en, W, B
	BNC	_00121_DS_
	BANKSEL	_dsp_en
	CLRF	_dsp_en, B
_00121_DS_:
;	.line	64; main.c	}
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__isr	code
_isr:
;	.line	31; main.c	void isr(void) __interrupt (1) {
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVWF	POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	32; main.c	if (INTCONbits.TMR0IF){
	BTFSS	_INTCONbits, 2
	BRA	_00106_DS_
;	.line	33; main.c	tmr_isr();
	CALL	_tmr_isr
;	.line	34; main.c	TMR0 = RATE;
	MOVLW	0xfa
	MOVWF	_TMR0
_00106_DS_:
;	.line	36; main.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
;	.line	37; main.c	if (INTCONbits.RBIF){
	BTFSS	_INTCONbits, 0
	BRA	_00108_DS_
;	.line	38; main.c	numpad_isr();
	CALL	_numpad_isr
_00108_DS_:
;	.line	40; main.c	INTCONbits.RBIF = 0;
	BCF	_INTCONbits, 0
;	.line	41; main.c	}
	MOVFF	PREINC1, FSR2L
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	MOVF	PREINC1, W
	MOVFF	PREINC1, BSR
	MOVFF	PREINC1, STATUS
	RETFIE	



; Statistics:
; code size:	 1106 (0x0452) bytes ( 0.84%)
;           	  553 (0x0229) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    9 (0x0009) bytes


	end
