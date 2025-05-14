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
	global	_number_to_7seg
	global	_display
	global	_count1k
	global	_count1kbak
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
	extern	_delay100ktcy
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
;	.line	160; main.c	setup();
	CALL	_setup
_00242_DS_:
;	.line	162; main.c	count1kbak();
	CALL	_count1kbak
	BRA	_00242_DS_
;	.line	165; main.c	}
	RETURN	

; ; Starting pCode block
S_main__setup	code
_setup:
;	.line	121; main.c	void setup(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	123; main.c	LATD = 0;
	CLRF	_LATD
;	.line	124; main.c	TRISD = 0;
	CLRF	_TRISD
;	.line	126; main.c	TRISB = 0xff;
	MOVLW	0xff
	MOVWF	_TRISB
;	.line	127; main.c	LATB = 0x00;
	CLRF	_LATB
;	.line	128; main.c	ADCON1 = 0xf;
	MOVLW	0x0f
	MOVWF	_ADCON1
;	.line	130; main.c	TRISE = 0;
	CLRF	_TRISE
;	.line	131; main.c	LATE = 0;
	CLRF	_LATE
;	.line	133; main.c	TRISA = 0;
	CLRF	_TRISA
;	.line	134; main.c	LATA = 0;
	CLRF	_LATA
;	.line	137; main.c	INTCONbits.GIE = 1;
	BSF	_INTCONbits, 7
;	.line	138; main.c	INTCONbits.PEIE = 1;
	BSF	_INTCONbits, 6
;	.line	139; main.c	INTCONbits.RBIE = 0;
	BCF	_INTCONbits, 3
;	.line	140; main.c	INTCON2bits.RBPU = 0;
	BCF	_INTCON2bits, 7
;	.line	141; main.c	INTCON2bits.RBIP = 1;
	BSF	_INTCON2bits, 0
;	.line	142; main.c	RCONbits.IPEN = 1;
	BSF	_RCONbits, 7
;	.line	145; main.c	INTCONbits.TMR0IE = 1;
	BSF	_INTCONbits, 5
;	.line	146; main.c	INTCON2bits.TMR0IP = 1;
	BSF	_INTCON2bits, 2
;	.line	148; main.c	T0CONbits.T08BIT = 1;
	BSF	_T0CONbits, 6
;	.line	149; main.c	T0CONbits.T0CS = 0; // Source internal oscilator
	BCF	_T0CONbits, 5
;	.line	150; main.c	T0CONbits.PSA = 0;
	BCF	_T0CONbits, 3
;	.line	154; main.c	T0CONbits.T0PS = 0x7;
	MOVF	_T0CONbits, W
	ANDLW	0xf8
	IORLW	0x07
	MOVWF	_T0CONbits
;	.line	155; main.c	T0CONbits.TMR0ON = 1;
	BSF	_T0CONbits, 7
;	.line	156; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__count1kbak	code
_count1kbak:
;	.line	114; main.c	void count1kbak(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	115; main.c	for(int i = 9999; i >= 0; i--) {
	MOVLW	0x0f
	MOVWF	r0x00
	MOVLW	0x27
	MOVWF	r0x01
_00229_DS_:
	BSF	STATUS, 0
	BTFSS	r0x01, 7
	BCF	STATUS, 0
	BC	_00231_DS_
;	.line	116; main.c	display(i);
	MOVF	r0x00, W
	MOVWF	r0x02
	MOVF	r0x01, W
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_display
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	117; main.c	delay100ktcy(5);
	MOVLW	0x05
	CALL	_delay100ktcy
;	.line	115; main.c	for(int i = 9999; i >= 0; i--) {
	MOVLW	0xff
	ADDWF	r0x00, F
	ADDWFC	r0x01, F
	BRA	_00229_DS_
_00231_DS_:
;	.line	119; main.c	}
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__count1k	code
_count1k:
;	.line	108; main.c	void count1k(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	109; main.c	for(int i = 0; i < 9999; i++) {
	CLRF	r0x00
	CLRF	r0x01
_00205_DS_:
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x59
	BNZ	_00222_DS_
	MOVLW	0x0f
	SUBWF	r0x00, W
_00222_DS_:
	BC	_00207_DS_
;	.line	110; main.c	display(i);
	MOVF	r0x00, W
	MOVWF	r0x02
	MOVF	r0x01, W
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_display
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	111; main.c	delay100ktcy(5);
	MOVLW	0x05
	CALL	_delay100ktcy
;	.line	109; main.c	for(int i = 0; i < 9999; i++) {
	INFSNZ	r0x00, F
	INCF	r0x01, F
	BRA	_00205_DS_
_00207_DS_:
;	.line	113; main.c	}
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__display	code
_display:
;	.line	98; main.c	void display(uint16_t num){
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
;	.line	100; main.c	if (num > 9999) return;
	MOVF	r0x00, W
	MOVWF	r0x02
	MOVF	r0x01, W
	MOVWF	r0x03
	MOVLW	0x27
	SUBWF	r0x03, W
	BNZ	_00198_DS_
	MOVLW	0x10
	SUBWF	r0x02, W
_00198_DS_:
	BC	_00177_DS_
;	.line	101; main.c	while(num) {
	CLRF	r0x02
_00174_DS_:
	MOVF	r0x01, W
	IORWF	r0x00, W
	BZ	_00177_DS_
;	.line	102; main.c	digit[i] = num%10;
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
;	.line	103; main.c	num = num/10;
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
;	.line	104; main.c	i++;
	INCF	r0x02, F
	BRA	_00174_DS_
_00177_DS_:
;	.line	106; main.c	}
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
;	.line	60; main.c	uint8_t number_to_7seg(uint8_t number) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	61; main.c	switch (number) {
	MOVLW	0x10
	SUBWF	r0x00, W
	BTFSC	STATUS, 0
	BRA	_00156_DS_
	CLRF	PCLATH
	CLRF	PCLATU
	RLCF	r0x00, W
	RLCF	PCLATH, F
	RLCF	WREG, W
	RLCF	PCLATH, F
	ANDLW	0xfc
	ADDLW	LOW(_00167_DS_)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_00167_DS_)
	ADDWFC	PCLATH, F
	MOVLW	UPPER(_00167_DS_)
	ADDWFC	PCLATU, F
	MOVF	PREINC1, W
	MOVWF	PCL
_00167_DS_:
	GOTO	_00140_DS_
	GOTO	_00141_DS_
	GOTO	_00142_DS_
	GOTO	_00143_DS_
	GOTO	_00144_DS_
	GOTO	_00145_DS_
	GOTO	_00146_DS_
	GOTO	_00147_DS_
	GOTO	_00148_DS_
	GOTO	_00149_DS_
	GOTO	_00150_DS_
	GOTO	_00151_DS_
	GOTO	_00152_DS_
	GOTO	_00153_DS_
	GOTO	_00154_DS_
	GOTO	_00155_DS_
_00140_DS_:
;	.line	63; main.c	return 0x3F;
	MOVLW	0x3f
	BRA	_00158_DS_
_00141_DS_:
;	.line	65; main.c	return 0x06;
	MOVLW	0x06
	BRA	_00158_DS_
_00142_DS_:
;	.line	67; main.c	return 0x5B;
	MOVLW	0x5b
	BRA	_00158_DS_
_00143_DS_:
;	.line	69; main.c	return 0x4F;
	MOVLW	0x4f
	BRA	_00158_DS_
_00144_DS_:
;	.line	71; main.c	return 0x66;
	MOVLW	0x66
	BRA	_00158_DS_
_00145_DS_:
;	.line	73; main.c	return 0x6D;
	MOVLW	0x6d
	BRA	_00158_DS_
_00146_DS_:
;	.line	75; main.c	return 0x7D;
	MOVLW	0x7d
	BRA	_00158_DS_
_00147_DS_:
;	.line	77; main.c	return 0x07;
	MOVLW	0x07
	BRA	_00158_DS_
_00148_DS_:
;	.line	79; main.c	return 0x7F;
	MOVLW	0x7f
	BRA	_00158_DS_
_00149_DS_:
;	.line	81; main.c	return 0x6F;
	MOVLW	0x6f
	BRA	_00158_DS_
_00150_DS_:
;	.line	83; main.c	return 0x77;
	MOVLW	0x77
	BRA	_00158_DS_
_00151_DS_:
;	.line	85; main.c	return 0x7c;
	MOVLW	0x7c
	BRA	_00158_DS_
_00152_DS_:
;	.line	87; main.c	return 0x39;
	MOVLW	0x39
	BRA	_00158_DS_
_00153_DS_:
;	.line	89; main.c	return 0x5e;
	MOVLW	0x5e
	BRA	_00158_DS_
_00154_DS_:
;	.line	91; main.c	return 0x79;
	MOVLW	0x79
	BRA	_00158_DS_
_00155_DS_:
;	.line	93; main.c	return 0x71;
	MOVLW	0x71
	BRA	_00158_DS_
_00156_DS_:
;	.line	95; main.c	return 0;
	CLRF	WREG
_00158_DS_:
;	.line	97; main.c	}
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__tmr_isr	code
_tmr_isr:
;	.line	37; main.c	void tmr_isr(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	38; main.c	LATA = LATE = 0;
	CLRF	_LATE
	CLRF	_LATA
;	.line	39; main.c	LATD = number_to_7seg(digit[dsp_en]);
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
;	.line	40; main.c	switch (dsp_en) {
	MOVLW	0x04
	BANKSEL	_dsp_en
	SUBWF	_dsp_en, W, B
	BC	_00116_DS_
	CLRF	PCLATH
	CLRF	PCLATU
	BANKSEL	_dsp_en
	RLCF	_dsp_en, W, B
	RLCF	PCLATH, F
	RLCF	WREG, W
	RLCF	PCLATH, F
	ANDLW	0xfc
	ADDLW	LOW(_00134_DS_)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_00134_DS_)
	ADDWFC	PCLATH, F
	MOVLW	UPPER(_00134_DS_)
	ADDWFC	PCLATU, F
	MOVF	PREINC1, W
	MOVWF	PCL
_00134_DS_:
	GOTO	_00112_DS_
	GOTO	_00113_DS_
	GOTO	_00114_DS_
	GOTO	_00115_DS_
_00112_DS_:
;	.line	42; main.c	LATA = 0;
	CLRF	_LATA
;	.line	43; main.c	LATE = 0x4;
	MOVLW	0x04
	MOVWF	_LATE
;	.line	44; main.c	break;
	BRA	_00116_DS_
_00113_DS_:
;	.line	46; main.c	LATE = 0x2;
	MOVLW	0x02
	MOVWF	_LATE
;	.line	47; main.c	break;
	BRA	_00116_DS_
_00114_DS_:
;	.line	49; main.c	LATE = 0x1;
	MOVLW	0x01
	MOVWF	_LATE
;	.line	50; main.c	break;
	BRA	_00116_DS_
_00115_DS_:
;	.line	52; main.c	LATE = 0;
	CLRF	_LATE
;	.line	53; main.c	LATA = 0x10;
	MOVLW	0x10
	MOVWF	_LATA
_00116_DS_:
	BANKSEL	_dsp_en
;	.line	56; main.c	dsp_en++;
	INCF	_dsp_en, F, B
;	.line	57; main.c	if (dsp_en > 3) dsp_en = 0;
	MOVLW	0x04
	BANKSEL	_dsp_en
	SUBWF	_dsp_en, W, B
	BNC	_00119_DS_
	BANKSEL	_dsp_en
	CLRF	_dsp_en, B
_00119_DS_:
;	.line	58; main.c	}
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__isr	code
_isr:
;	.line	29; main.c	void isr(void) __interrupt (1) {
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
;	.line	30; main.c	if (INTCONbits.TMR0IF){
	BTFSS	_INTCONbits, 2
	BRA	_00106_DS_
;	.line	31; main.c	tmr_isr();
	CALL	_tmr_isr
;	.line	32; main.c	TMR0 = RATE;
	MOVLW	0xe6
	MOVWF	_TMR0
_00106_DS_:
;	.line	34; main.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
;	.line	35; main.c	}
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
; code size:	  974 (0x03ce) bytes ( 0.74%)
;           	  487 (0x01e7) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    9 (0x0009) bytes


	end
