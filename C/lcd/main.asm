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
	global	_LCD_Initialize
	global	_LCDWriteNibble
	global	_LCDPutChar
	global	_LCDPutCmd
	global	_LCDPutStr
	global	_LCDGoto
	global	_sram_end
	global	_main

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	__gptrload
	extern	__gptrget1
	extern	_stdin
	extern	_stdout
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
PCLATH	equ	0xffa
WREG	equ	0xfe8
TBLPTRL	equ	0xff6
TBLPTRH	equ	0xff7
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODH	equ	0xff4


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1


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
;	.line	72; main.c	OSCCON=0x72; // Select internal oscillator with frequency = 8MHz
	MOVLW	0x72
	MOVWF	_OSCCON
;	.line	73; main.c	LCD_Initialize();
	CALL	_LCD_Initialize
;	.line	74; main.c	LCDPutStr(" Hello World!"); //Display String "Hello World"
	MOVLW	UPPER(___str_0)
	MOVWF	r0x02
	MOVLW	HIGH(___str_0)
	MOVWF	r0x01
	MOVLW	LOW(___str_0)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_LCDPutStr
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	75; main.c	LCDGoto(8,1); //Go to column 8 of second line
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	_LCDGoto
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	76; main.c	LCDPutChar('1'); //Display character '1'
	MOVLW	0x31
	MOVWF	POSTDEC1
	CALL	_LCDPutChar
	MOVF	POSTINC1, F
;	.line	77; main.c	DisplayClr(); // Clear the display
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_LCDPutCmd
	MOVF	POSTINC1, F
;	.line	79; main.c	LCDPutStr(" LCD Display"); // Dispay a string "LCD Display"
	MOVLW	UPPER(___str_1)
	MOVWF	r0x02
	MOVLW	HIGH(___str_1)
	MOVWF	r0x01
	MOVLW	LOW(___str_1)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_LCDPutStr
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	80; main.c	LCDGoto(0,1); //Go to second line 
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDGoto
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	81; main.c	LCDPutStr("Micro Lab"); //Display String "Micro Lab" 
	MOVLW	UPPER(___str_2)
	MOVWF	r0x02
	MOVLW	HIGH(___str_2)
	MOVWF	r0x01
	MOVLW	LOW(___str_2)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_LCDPutStr
	MOVLW	0x03
	ADDWF	FSR1L, F
_00106_DS_:
;	.line	82; main.c	while (1)
	BRA	_00106_DS_
;	.line	87; main.c	}
	RETURN	

; ; Starting pCode block
S_main__LCDGoto	code
_LCDGoto:
;	.line	191; main.c	void LCDGoto(char pos,char ln)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	194; main.c	if ((ln > (NB_LINES-1)) || (pos > (NB_COL-1)))
	MOVF	r0x01, W
	MOVWF	r0x02
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x7e
	BC	_00141_DS_
	MOVLW	0x10
	SUBWF	r0x00, W
	BNC	_00142_DS_
_00141_DS_:
;	.line	197; main.c	return;
	BRA	_00144_DS_
_00142_DS_:
;	.line	201; main.c	LCDPutCmd((ln == 1) ? (0xC0 | pos) : (0x80 | pos));
	MOVF	r0x01, W
	XORLW	0x01
	BNZ	_00146_DS_
	MOVLW	0xc0
	IORWF	r0x00, W
	MOVWF	r0x01
	BRA	_00147_DS_
_00146_DS_:
	MOVLW	0x80
	IORWF	r0x00, W
	MOVWF	r0x01
_00147_DS_:
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_LCDPutCmd
	MOVF	POSTINC1, F
;	.line	204; main.c	delay1ktcy(LCD_delay);
	MOVLW	0x05
	CALL	_delay1ktcy
_00144_DS_:
;	.line	205; main.c	}
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__LCDPutStr	code
_LCDPutStr:
;	.line	178; main.c	void LCDPutStr(const char *str)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	183; main.c	while (str[i])
	CLRF	r0x03
_00133_DS_:
	MOVF	r0x03, W
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	WREG
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	WREG
	ADDWFC	r0x02, W
	MOVWF	r0x06
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, PCLATH
	CALL	__gptrload
	CALL	__gptrget1
	MOVWF	r0x04
	MOVF	r0x04, W
	BZ	_00136_DS_
;	.line	186; main.c	LCDPutChar(str[i++]);
	MOVF	r0x03, W
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	WREG
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	WREG
	ADDWFC	r0x02, W
	MOVWF	r0x06
	INCF	r0x03, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, PCLATH
	CALL	__gptrload
	CALL	__gptrget1
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_LCDPutChar
	MOVF	POSTINC1, F
	BRA	_00133_DS_
_00136_DS_:
;	.line	189; main.c	}
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
S_main__LCDPutCmd	code
_LCDPutCmd:
;	.line	161; main.c	void LCDPutCmd(char ch)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	163; main.c	delay1ktcy(LCD_delay);
	MOVLW	0x05
	CALL	_delay1ktcy
;	.line	166; main.c	LCDWriteNibble(ch,instr);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_LCDWriteNibble
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	169; main.c	ch = (ch << 4);
	SWAPF	r0x00, W
	ANDLW	0xf0
	MOVWF	r0x01
;	.line	171; main.c	delay1ktcy(1);
	MOVLW	0x01
	CALL	_delay1ktcy
;	.line	174; main.c	LCDWriteNibble(ch,instr);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_LCDWriteNibble
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	175; main.c	}
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__LCDPutChar	code
_LCDPutChar:
;	.line	146; main.c	void LCDPutChar(char ch)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	148; main.c	delay1ktcy(LCD_delay);
	MOVLW	0x05
	CALL	_delay1ktcy
;	.line	151; main.c	LCDWriteNibble(ch,data);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_LCDWriteNibble
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	154; main.c	ch = (ch << 4);
	SWAPF	r0x00, W
	ANDLW	0xf0
	MOVWF	r0x01
;	.line	157; main.c	LCDWriteNibble(ch,data);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_LCDWriteNibble
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	158; main.c	}
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__LCDWriteNibble	code
_LCDWriteNibble:
;	.line	119; main.c	void LCDWriteNibble(char ch, char rs)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	122; main.c	ch = (ch >> 4);
	SWAPF	r0x00, W
	ANDLW	0x0f
	MOVWF	r0x00
;	.line	125; main.c	ch = (ch & 0x0F);
	MOVLW	0x0f
	ANDWF	r0x00, F
;	.line	128; main.c	LCD_PORT = (LCD_PORT & 0xF0);
	MOVFF	_PORTD, r0x02
	MOVLW	0xf0
	ANDWF	r0x02, W
	MOVWF	_PORTD
;	.line	131; main.c	LCD_PORT = (LCD_PORT | ch);
	MOVF	r0x00, W
	IORWF	_PORTD, F
;	.line	134; main.c	LCD_RS = rs;
	MOVF	r0x01, W
	ANDLW	0x01
	SWAPF	WREG, W
	MOVWF	PRODH
	MOVF	_PORTDbits, W
	ANDLW	0xef
	IORWF	PRODH, W
	MOVWF	_PORTDbits
;	.line	137; main.c	LCD_RW = 0;
	BCF	_PORTDbits, 5
;	.line	140; main.c	LCD_EN = 1;
	BSF	_PORTDbits, 6
;	.line	143; main.c	LCD_EN = 0;
	BCF	_PORTDbits, 6
;	.line	144; main.c	}
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__LCD_Initialize	code
_LCD_Initialize:
;	.line	89; main.c	void LCD_Initialize()
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	92; main.c	LCD_PORT = 0;
	CLRF	_PORTD
;	.line	94; main.c	TRISD = 0x00;
	CLRF	_TRISD
;	.line	97; main.c	LCD_PWR = 1;
	BSF	_PORTDbits, 7
;	.line	100; main.c	delay1ktcy(LCD_Startup);
	MOVLW	0x0f
	CALL	_delay1ktcy
;	.line	103; main.c	LCDPutCmd(0x32);
	MOVLW	0x32
	MOVWF	POSTDEC1
	CALL	_LCDPutCmd
	MOVF	POSTINC1, F
;	.line	106; main.c	LCDPutCmd(FUNCTION_SET);
	MOVLW	0x28
	MOVWF	POSTDEC1
	CALL	_LCDPutCmd
	MOVF	POSTINC1, F
;	.line	109; main.c	LCDPutCmd(DISPLAY_SETUP);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_LCDPutCmd
	MOVF	POSTINC1, F
;	.line	111; main.c	DisplayClr();
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_LCDPutCmd
	MOVF	POSTINC1, F
;	.line	114; main.c	LCDPutCmd(ENTRY_MODE);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_LCDPutCmd
	MOVF	POSTINC1, F
;	.line	116; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
___str_0:
	DB	0x20, 0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64
	DB	0x21, 0x00
; ; Starting pCode block
___str_1:
	DB	0x20, 0x4c, 0x43, 0x44, 0x20, 0x44, 0x69, 0x73, 0x70, 0x6c, 0x61, 0x79
	DB	0x00
; ; Starting pCode block
___str_2:
	DB	0x4d, 0x69, 0x63, 0x72, 0x6f, 0x20, 0x4c, 0x61, 0x62, 0x00


; Statistics:
; code size:	  802 (0x0322) bytes ( 0.61%)
;           	  401 (0x0191) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    7 (0x0007) bytes


	end
