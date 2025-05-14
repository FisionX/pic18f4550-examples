    LIST P=18F4550
    #include <p18f4550.inc>

    CONFIG FOSC = HS ; Use internal oscillator, RA6 as clock output
    CONFIG WDT = OFF          ; Watchdog Timer off
    CONFIG LVP = OFF          ; Low-Voltage Programming off
    CONFIG MCLRE = OFF        ; MCLR pin disabled, RE3 input enabled

; Definitions
R3 EQU 0x024
R4 EQU 0x025
R5 EQU 0x026
TEMP EQU 0x038
COL EQU 0x039
READ EQU 0x03A
SHIFT EQU 0x03B

    ORG 0x00
    GOTO INIT

    ORG 0x08
    GOTO ISR

INIT:
    CLRF LATB
    movlw 0xf0    ; PORTB setup
    MOVWF TRISB

    movlw 0x0f
    movwf ADCON1

    clrf TRISD    ; Set port D as output
    clrf LATD
    CLRF TRISE
    CLRF LATE

    BSF PORTE, 2
    CLRF TEMP
    CLRF COL
    CLRF SHIFT
    CLRF READ

    ;    Configure interrupts
    BSF RCON, IPEN     ;
    BSF INTCON, GIE    ; Enable Global Interrupts
    BSF INTCON, PEIE   ; Enable Peripheral Interrupts
    BSF INTCON, RBIE   ; Enable RB Port Change Interrupt
    BCF INTCON2, RBPU  ; Enable PORTB pull-ups
    BSF INTCON2, RBIP  ; Set interrupt on high priority RBIP

LOOP:
    MOVLW 0x0E
    MOVWF SHIFT
    MOVWF PORTB

    CALL disp_delay
    MOVLW 0x0D
    MOVWF SHIFT
    MOVWF PORTB

    CALL disp_delay
    MOVLW 0x0B
    MOVWF SHIFT
    MOVWF PORTB

    CALL disp_delay
    MOVLW 0x07
    MOVWF SHIFT
    MOVWF PORTB
    
    CALL disp_delay
    GOTO LOOP

ISR:
    BTFSS INTCON, RBIF
    RETFIE

    MOVF PORTB, W
    NOP
    ANDLW 0xf0
    MOVWF COL
    SWAPF COL
    SUBLW 0xf0
    BTFSC STATUS, Z
    GOTO ret
    CALL decode
    MOVWF TEMP
    CALL sevensw
    MOVWF PORTD
    CALL SDelay
    CALL SDelay
    CALL SDelay
    CALL SDelay
    CALL SDelay
ret:    
    BCF INTCON, RBIF
    RETFIE


decode:
    BTFSC SHIFT, 0 ; Check if row 1 is active
    GOTO col1
    BTFSS COL, 0   ; Check every column
    RETLW 0x01
    BTFSS COL, 1
    RETLW 0x02
    BTFSS COL, 2
    RETLW 0x03
    BTFSS COL, 3
    RETLW 0x0A
col1:
    BTFSC SHIFT, 1
    GOTO col2
    BTFSS COL, 0   ; Check every column
    RETLW 0x04
    BTFSS COL, 1
    RETLW 0x05
    BTFSS COL, 2
    RETLW 0x06
    BTFSS COL, 3
    RETLW 0x0B
col2:
    BTFSC SHIFT, 2
    GOTO col3
    BTFSS COL, 0   ; Check every column
    RETLW 0x07
    BTFSS COL, 1
    RETLW 0x08
    BTFSS COL, 2
    RETLW 0x09
    BTFSS COL, 3
    RETLW 0x0C
col3
    BTFSC SHIFT, 3
    RETLW 0x00
    BTFSS COL, 0   ; Check every column
    RETLW 0x00
    BTFSS COL, 1
    RETLW 0x00
    BTFSS COL, 2
    RETLW 0x00
    BTFSS COL, 3
    RETLW 0x0D
    RETLW 0x00


SDelay:
    MOVLW D'250'
    MOVWF R4                
SDelay_Outer:
    MOVLW D'250'
    MOVWF R5                
SDelay_Inner:
    NOP
    NOP
    DECFSZ R5, F             ; Decrement inner loop counter
    GOTO SDelay_Inner         ; Repeat inner loop
    DECFSZ R4, F             ; Decrement outer loop counter
    GOTO SDelay_Outer         ; Repeat outer loop
    RETURN                   ; Return from delay

disp_delay:
    movlw D'250'
    movwf R3
disp_delay_inner:
    NOP
    NOP
    NOP
    NOP
    decfsz R3, F
    goto disp_delay_inner
    return

sevensw:
    movlw high(sevenjmp)
    movwf PCLATH
    movf TEMP, W
    addwf TEMP, W
    addlw low(sevenjmp)
    btfsc STATUS, 0
    incf PCLATH, 1
    movwf PCL
sevenjmp:
    retlw 3Fh
    retlw 06h
    retlw 5Bh
    retlw 4Fh
    retlw 66h
    retlw 6Dh
    retlw 7Dh
    retlw 07h ; siete
    retlw 7Fh ; ocho
    retlw 6Fh ; nueve
    retlw 77h ; A
    retlw 7Ch ; B
    retlw 39h ; C
    retlw 5Eh ; D
    retlw 79h ; E
    retlw 71h ; F

    END
