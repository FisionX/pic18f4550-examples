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
	global	_main
	global	_rota1
	global	_rota2
	global	_rota3
	global	_rota4
	global	_rota5
	global	_sram_end

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

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1


ustat_main_00	udata	0X07FF
_sram_end      	res	0

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_main__main	code
_main:
;	.line	23; main.c	TRISD = 0;
	CLRF	_TRISD
;	.line	24; main.c	LATD = 0;
	CLRF	_LATD
;	.line	25; main.c	TRISE = 0;
	CLRF	_TRISE
;	.line	26; main.c	LATE = 0x04;
	MOVLW	0x04
	MOVWF	_LATE
;	.line	27; main.c	TRISB = 0xff;
	MOVLW	0xff
	MOVWF	_TRISB
;	.line	30; main.c	INTCON2bits.RBPU = 0;
	BCF	_INTCON2bits, 7
;	.line	31; main.c	ADCON1 = 0x0f;
	MOVLW	0x0f
	MOVWF	_ADCON1
_00112_DS_:
;	.line	35; main.c	port = PORTB;
	MOVFF	_PORTB, r0x00
;	.line	36; main.c	switch (port) {
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00105_DS_
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00106_DS_
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_00107_DS_
	MOVF	r0x00, W
	XORLW	0x08
	BZ	_00108_DS_
	MOVF	r0x00, W
	XORLW	0x10
	BZ	_00109_DS_
	BRA	_00110_DS_
_00105_DS_:
;	.line	38; main.c	rota1();
	CALL	_rota1
;	.line	39; main.c	break;
	BRA	_00110_DS_
_00106_DS_:
;	.line	41; main.c	rota2();
	CALL	_rota2
;	.line	42; main.c	break;
	BRA	_00110_DS_
_00107_DS_:
;	.line	44; main.c	rota3();
	CALL	_rota3
;	.line	45; main.c	break;
	BRA	_00110_DS_
_00108_DS_:
;	.line	47; main.c	rota4();
	CALL	_rota4
;	.line	48; main.c	break;
	BRA	_00110_DS_
_00109_DS_:
;	.line	50; main.c	rota5();
	CALL	_rota5
_00110_DS_:
;	.line	53; main.c	delay1ktcy(50); // 1s @ 1MHz
	MOVLW	0x32
	CALL	_delay1ktcy
	BRA	_00112_DS_
;	.line	55; main.c	}
	RETURN	

; ; Starting pCode block
S_main__rota5	code
_rota5:
;	.line	134; main.c	void rota5(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	135; main.c	LATD = 0x55;
	MOVLW	0x55
	MOVWF	_LATD
;	.line	136; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	137; main.c	LATD = 0xAA;
	MOVLW	0xaa
	MOVWF	_LATD
;	.line	138; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	139; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__rota4	code
_rota4:
;	.line	122; main.c	void rota4(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	123; main.c	LATD = 1;
	MOVLW	0x01
	MOVWF	_LATD
_00343_DS_:
;	.line	124; main.c	while (LATD != 0x80) {
	MOVF	_LATD, W
	XORLW	0x80
	BZ	_00345_DS_
;	.line	125; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	126; main.c	RLCF(LATD);
	RLNCF	_LATD, W
	ANDLW	0xfe
	MOVWF	r0x00
	RLNCF	_LATD, W
	ANDLW	0x01
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, W
	MOVWF	_LATD
	BRA	_00343_DS_
_00345_DS_:
;	.line	128; main.c	LATD = 0x80;
	MOVLW	0x80
	MOVWF	_LATD
_00346_DS_:
;	.line	129; main.c	while (LATD != 0x01) {
	MOVF	_LATD, W
	XORLW	0x01
	BZ	_00349_DS_
;	.line	130; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	131; main.c	RRCF(LATD);
	RRNCF	_LATD, W
	ANDLW	0x7f
	MOVWF	r0x00
	RRNCF	_LATD, W
	ANDLW	0x80
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, W
	MOVWF	_LATD
	BRA	_00346_DS_
_00349_DS_:
;	.line	133; main.c	}
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__rota3	code
_rota3:
;	.line	73; main.c	void rota3(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	74; main.c	LATD = 0x01;
	MOVLW	0x01
	MOVWF	_LATD
_00212_DS_:
;	.line	75; main.c	while (LATD != 0x80) {
	MOVF	_LATD, W
	XORLW	0x80
	BZ	_00214_DS_
;	.line	76; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	77; main.c	RLCF(LATD);
	RLNCF	_LATD, W
	ANDLW	0xfe
	MOVWF	r0x00
	RLNCF	_LATD, W
	ANDLW	0x01
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, W
	MOVWF	_LATD
	BRA	_00212_DS_
_00214_DS_:
;	.line	79; main.c	LATD = 0x81;
	MOVLW	0x81
	MOVWF	_LATD
_00215_DS_:
;	.line	80; main.c	while (LATD != 0xC0) {
	MOVF	_LATD, W
	XORLW	0xc0
	BZ	_00217_DS_
;	.line	81; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	82; main.c	LATD = LATD << 1;
	BCF	STATUS, 0
	RLCF	_LATD, F
;	.line	83; main.c	LATD |= 0x80;
	BSF	_LATD, 7
	BRA	_00215_DS_
_00217_DS_:
;	.line	85; main.c	LATD = 0xC1;
	MOVLW	0xc1
	MOVWF	_LATD
_00218_DS_:
;	.line	86; main.c	while (LATD != 0xE0) {
	MOVF	_LATD, W
	XORLW	0xe0
	BZ	_00220_DS_
;	.line	87; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	88; main.c	LATD = LATD << 1;
	BCF	STATUS, 0
	RLCF	_LATD, F
;	.line	89; main.c	LATD |= 0xC0;
	MOVLW	0xc0
	IORWF	_LATD, F
	BRA	_00218_DS_
_00220_DS_:
;	.line	91; main.c	LATD = 0xE1;
	MOVLW	0xe1
	MOVWF	_LATD
_00221_DS_:
;	.line	92; main.c	while (LATD != 0xF0) {
	MOVF	_LATD, W
	XORLW	0xf0
	BZ	_00223_DS_
;	.line	93; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	94; main.c	LATD = LATD << 1;
	BCF	STATUS, 0
	RLCF	_LATD, F
;	.line	95; main.c	LATD |= 0xE0;
	MOVLW	0xe0
	IORWF	_LATD, F
	BRA	_00221_DS_
_00223_DS_:
;	.line	97; main.c	LATD = 0xF1;
	MOVLW	0xf1
	MOVWF	_LATD
_00224_DS_:
;	.line	98; main.c	while (LATD != 0xF8) {
	MOVF	_LATD, W
	XORLW	0xf8
	BZ	_00226_DS_
;	.line	99; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	100; main.c	LATD = LATD << 1;
	BCF	STATUS, 0
	RLCF	_LATD, F
;	.line	101; main.c	LATD |= 0xF0;
	MOVLW	0xf0
	IORWF	_LATD, F
	BRA	_00224_DS_
_00226_DS_:
;	.line	103; main.c	LATD = 0xF9;
	MOVLW	0xf9
	MOVWF	_LATD
_00227_DS_:
;	.line	104; main.c	while (LATD != 0xFC) {
	MOVF	_LATD, W
	XORLW	0xfc
	BZ	_00229_DS_
;	.line	105; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	106; main.c	LATD = LATD << 1;
	BCF	STATUS, 0
	RLCF	_LATD, F
;	.line	107; main.c	LATD |= 0xF8;
	MOVLW	0xf8
	IORWF	_LATD, F
	BRA	_00227_DS_
_00229_DS_:
;	.line	109; main.c	LATD = 0xFD;
	MOVLW	0xfd
	MOVWF	_LATD
_00230_DS_:
;	.line	110; main.c	while (LATD != 0xFE) {
	MOVF	_LATD, W
	XORLW	0xfe
	BZ	_00232_DS_
;	.line	111; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	112; main.c	LATD = LATD << 1;
	BCF	STATUS, 0
	RLCF	_LATD, F
;	.line	113; main.c	LATD |= 0xFC;
	MOVLW	0xfc
	IORWF	_LATD, F
	BRA	_00230_DS_
_00232_DS_:
;	.line	115; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	116; main.c	LATD = 0xFE;
	MOVLW	0xfe
	MOVWF	_LATD
;	.line	117; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	118; main.c	LATD = 0xFF;
	MOVLW	0xff
	MOVWF	_LATD
;	.line	119; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	121; main.c	}
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__rota2	code
_rota2:
;	.line	65; main.c	void rota2(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	66; main.c	LATD = 0x80;
	MOVLW	0x80
	MOVWF	_LATD
_00189_DS_:
;	.line	67; main.c	while (LATD != 0x01) {
	MOVF	_LATD, W
	XORLW	0x01
	BZ	_00192_DS_
;	.line	68; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	69; main.c	RRCF(LATD);
	RRNCF	_LATD, W
	ANDLW	0x7f
	MOVWF	r0x00
	RRNCF	_LATD, W
	ANDLW	0x80
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, W
	MOVWF	_LATD
	BRA	_00189_DS_
_00192_DS_:
;	.line	72; main.c	}
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__rota1	code
_rota1:
;	.line	57; main.c	void rota1(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	58; main.c	LATD = 1;
	MOVLW	0x01
	MOVWF	_LATD
_00166_DS_:
;	.line	59; main.c	while (LATD != 0x80) {
	MOVF	_LATD, W
	XORLW	0x80
	BZ	_00169_DS_
;	.line	60; main.c	delay1ktcy(150);
	MOVLW	0x96
	CALL	_delay1ktcy
;	.line	61; main.c	RLCF(LATD);
	RLNCF	_LATD, W
	ANDLW	0xfe
	MOVWF	r0x00
	RLNCF	_LATD, W
	ANDLW	0x01
	MOVWF	r0x01
	MOVF	r0x01, W
	IORWF	r0x00, W
	MOVWF	_LATD
	BRA	_00166_DS_
_00169_DS_:
;	.line	64; main.c	}
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  608 (0x0260) bytes ( 0.46%)
;           	  304 (0x0130) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    2 (0x0002) bytes


	end
