LIST P=18F4550, F=INHX32  ; Specify processor and hex format
#include <p18f4550.inc>

CONFIG FOSC = HS ; Use internal oscillator, RA6 as clock output
CONFIG WDT = OFF          ; Watchdog Timer off
CONFIG LVP = OFF          ; Low-Voltage Programming off
CONFIG MCLRE = ON        ; MCLR pin disabled, RE3 input enabled
;CONFIG PBADEN = OFF


ROTA1 EQU 0x01
ROTA2 EQU 0x02
ROTA3 EQU 0x04
ROTA4 EQU 0x08
ROTA5 EQU 0x10
ROTA6 EQU 0x20
R1 EQU 0x020
R2 EQU 0x021
R3 EQU 0x024
CUENTA EQU 0x022
CUENTA2 EQU 0x034
TEMP EQU 0x23
DISP0 EQU 0x30
DISP1 EQU 0x31
DISP2 EQU 0x32
DISP3 EQU 0x33

ORG 0x0000
    goto Start

ORG 0x0008
    goto loop

Start:
    ; Initialize PORTB
    CLRF TRISD               ; Set all PORTB pins as output
    CLRF LATD                ; Clear PORTB outputs

    CLRF LATB
    BCF INTCON2, RBPU
    MOVLW 0xff
    MOVWF TRISB         ; set port b to input
    movlw 0x0f
    movwf ADCON1
    
    clrf LATA
    clrf TRISA
    
    bsf RCON, IPEN    ; enable priority modes
    bsf INTCON, RBIF  ; RB Port change interrupt
    bsf INTCON, PEIE  ; enable peripheral interrupts
    bsf INTCON, GIE   ; enable global interrupts
    bsf INTCON2, RBIP ; rb to high priority

    clrf LATE
    clrf TRISE
    clrf CUENTA2


loop:
    movf PORTB, W
    bcf INTCON, RBIF
    clrf CUENTA
    call splitDigit
    call Delay

    movf PORTB, W
    xorlw ROTA1
    btfsc STATUS, Z 
    goto hexa            ; cuenta 1
    xorlw ROTA2^ROTA1
    btfsc STATUS, Z 
    goto decimal         ; cuenta 2
    xorlw ROTA2^ROTA3
    btfsc STATUS, Z
    goto des             ; cuenta 3 wip
    xorlw ROTA3^ROTA4
    btfsc STATUS, Z
    goto hexAsc
    xorlw ROTA4^ROTA5
    btfsc STATUS, Z
    goto bcdt
    xorlw ROTA5^ROTA6
    btfsc STATUS, Z
    goto hext
    goto loop

hexa:
    call splitDigit
    call Delay
    incf CUENTA, F
    call Delay
    goto hexa

des:
    clrf CUENTA
    clrf CUENTA2
rl:
    call splitDigit
    call Delay
    incf CUENTA, W
    daw
    movwf CUENTA
    xorlw 0x60
    btfss STATUS, Z
    goto rl
    clrf CUENTA
    incf CUENTA2, W
    daw
    movwf CUENTA2
    xorlw 0x60
    btfsc STATUS, Z
    return
    goto rl

decimal:
    call splitDigit
    call Delay
    incf CUENTA, W
    daw
    movwf CUENTA
    Call Delay
    goto decimal

hexAsc:
    movlw 0xff
    movwf CUENTA
rl2:
    call splitDigit
    call Delay
    decfsz CUENTA
    goto rl2
    goto hexAsc

bcdt:     ;; count to a thousand
    clrf CUENTA
    clrf CUENTA2
co: 
    call splitDigit
    call Delay
    incf CUENTA, W
    daw
    movwf CUENTA
    btfss STATUS, C
    goto co
    incf CUENTA2, W
    daw
    movwf CUENTA2
    btfss STATUS, C
    goto co
    return

hext:
    clrf CUENTA
    clrf CUENTA2
ht: 
    call splitDigit
    call Delay
    incf CUENTA, W
    movwf CUENTA
    btfss STATUS, Z
    goto ht
    clrf CUENTA
    incf CUENTA2, W
    movwf CUENTA2
    btfss STATUS, Z
    goto ht
    return

splitDigit:
    movf CUENTA, W
    andlw 0x0f
    movwf DISP0
    swapf CUENTA, W
    andlw 0x0f
    movwf DISP1
    movf CUENTA2, W
    andlw 0x0f
    movwf DISP2
    swapf CUENTA2, W
    andlw 0x0f
    movwf DISP3
    return

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


; Delay subroutine (approx 500ms)
Delay:
    MOVLW D'250'             ; Outer loop count
    MOVWF R1                
Delay_Outer:
    MOVLW D'250'             ; Inner loop count
    MOVWF R2                
Delay_Inner:
    NOP                      ; Do nothing (No Operation)
    NOP
    DECFSZ R2, F             ; Decrement inner loop counter
    GOTO Delay_Inner         ; Repeat inner loop
    ;; Multiplex code
    call display

    DECFSZ R1, F             ; Decrement outer loop counter
    GOTO Delay_Outer         ; Repeat outer loop
    RETURN                   ; Return from delay

display:
    clrf PORTD
    movff DISP0, TEMP
    call sevensw
    movwf PORTD
    movlw 0x04
    movwf PORTE
    call disp_delay

    clrf PORTD
    movff DISP1, TEMP
    call sevensw
    movwf PORTD
    movlw 0x02
    movwf PORTE
    call disp_delay

    clrf PORTD
    movff DISP2, TEMP
    call sevensw
    movwf PORTD
    movlw 0x01
    movwf PORTE
    call disp_delay

    clrf PORTD
    clrf PORTE
    movff DISP3, TEMP
    call sevensw
    movwf PORTD
    movlw 0x10
    movwf PORTA
    call disp_delay
    clrf PORTA
    return

    END                      ; End of program
;todopic y aquihayapuntes
