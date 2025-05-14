LIST P=18F4550
#include <p18f4550.inc>

CONFIG FOSC = HS ; Use internal oscillator, RA6 as clock output
CONFIG WDT = OFF          ; Watchdog Timer off
CONFIG LVP = OFF          ; Low-Voltage Programming off
CONFIG MCLRE = ON        ; MCLR pin disabled, RE3 input enabled

;mem
R1 EQU 0x020
R2 EQU 0x021
R3 EQU 0x024
R4 EQU 0x026
R5 EQU 0x027
TEMP EQU 0x23
CUENTA EQU 0x022
CUENTA2 EQU 0x034
DISP0 EQU 0x30
DISP1 EQU 0x31
DISP2 EQU 0x32
DISP3 EQU 0x33

    ORG 0x00
    GOTO INIT

    ORG 0x08   ; Interrupt vector for high-priority interrupts
    goto ISR   ; Jump to Interrupt Service Routine

INIT:
    ; === Configure RB4-RB7 as Input ===
    movlw 0xff
    movwf TRISB
    clrf TRISD
    clrf LATD

    movlw 0x0f
    movwf ADCON1

    clrf CUENTA
    clrf CUENTA2

    clrf TRISE
    clrf LATE
    clrf TRISA
    clrf LATA

    ; === Enable RB Port Change Interrupt ===
    BSF RCON, IPEN
    BCF INTCON2, RBPU  ; Enable PORTB pull-ups
    BSF INTCON2, 0     ; Set interrupt on high priority RBIP
    ;BSF INTCON, RBIE   ; Enable RB Port Change Interrupt
    BSF INTCON, GIE    ; Enable Global Interrupts
    BSF INTCON, PEIE   ; Enable Peripheral Interrupts
    ; INT0
    BSF INTCON, INT0IE
    BCF INTCON2, INTEDG0
    ;BSF INTCON, INT1IE
    ;BSF INTCON2, INTEDG1

    movlw 0x00
    movwf CUENTA
    call splitDigit

MAIN_LOOP:
    ;MOVFF PORTB, PORTD
    call Delay
    GOTO MAIN_LOOP     ; Stay in loop, wait for interrupts

; === Interrupt Service Routine ===
ISR:
    ;BTFSS INTCON, RBIF  ; Check if RB Change interrupt occurred
    ;RETFIE; Return if not triggered
    BTFSS INTCON, INT0IF
    RETFIE
    MOVF PORTB, W       ; Read PORTB (necessary to clear mismatch condition)
    ; Interrupt code
    incf CUENTA, W
    daw
    movwf CUENTA
    call splitDigit
    call SDelay

    ;BCF INTCON, RBIF    ; Clear the RBIF flag
    BCF INTCON, INT0IF
    ;BCF INTCON, INT1IF
    RETFIE; Return from interrupt

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
    call display
    DECFSZ R1, F             ; Decrement outer loop counter
    GOTO Delay_Outer         ; Repeat outer loop
    RETURN                   ; Return from delay

SDelay:
    MOVLW D'150'             ; Outer loop count
    MOVWF R4                
SDelay_Outer:
    MOVLW D'250'             ; Inner loop count
    MOVWF R5                
SDelay_Inner:
    NOP                      ; Do nothing (No Operation)
    NOP
    DECFSZ R5, F             ; Decrement inner loop counter
    GOTO SDelay_Inner         ; Repeat inner loop
    call display
    DECFSZ R4, F             ; Decrement outer loop counter
    GOTO SDelay_Outer         ; Repeat outer loop
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

    END
