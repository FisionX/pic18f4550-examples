LIST P=18F4550, F=INHX32  ; Specify processor and hex format
#include <p18f4550.inc>

CONFIG FOSC = HS ; Use internal oscillator, RA6 as clock output
CONFIG WDT = OFF          ; Watchdog Timer off
CONFIG LVP = OFF          ; Low-Voltage Programming off
CONFIG MCLRE = OFF        ; MCLR pin disabled, RE3 input enabled
CONFIG PBADEN = OFF

ORG 0x00                 ; Program starts at address 0
ROTA1 EQU 0x01
ROTA2 EQU 0x02
ROTA3 EQU 0x04
ROTA4 EQU 0x08
ROTA5 EQU 0x10
ROTA6 EQU 0x20
R1 EQU 0x020
R2 EQU 0x021



Start:
    ; Initialize PORTB
    CLRF TRISD               ; Set all PORTB pins as output
    CLRF LATD                ; Clear PORTB outputs

    CLRF LATB
    BCF INTCON2, 7
    MOVLW 0xff
    MOVWF TRISB         ; set port b to input
    movlw 0x0f
    movwf ADCON1

    MOVLW 0x01
    MOVWF PORTD

loop:
    movf PORTB, W
    xorlw ROTA1
    btfsc STATUS, Z 
    goto leftright
    xorlw ROTA2^ROTA1
    btfsc STATUS, Z 
    goto right
    xorlw ROTA2^ROTA3
    btfsc STATUS, Z
    goto left
    xorlw ROTA3^ROTA4
    btfsc STATUS, Z
    goto alternate
    xorlw ROTA4^ROTA5
    btfsc STATUS, Z
    goto centerout
    xorlw ROTA5^ROTA6
    btfsc STATUS, Z
    goto outcenter
    goto loop

leftright:
    CALL Delay               ; Delay
    RLCF PORTD, f
    BTFSS STATUS,0
    GOTO leftright                ; Repeat the loop
lright:
    CALL Delay               ; Delay
    RRCF PORTD, F
    BTFSS STATUS,0
    GOTO lright                ; Repeat the loop
    return

left:
    MOVLW 0x80
    MOVWF PORTD
rl: CALL Delay               ; Delay
    RRCF PORTD, F
    BTFSS STATUS,0
    GOTO rl                ; Repeat the loop
    return

right:
    MOVLW 0x01
    MOVWF PORTD
rr: CALL Delay               ; Delay
    RLCF PORTD, F
    BTFSS STATUS,0
    GOTO rr                ; Repeat the loop
    return

alternate:
    movlw 0xaa
    movwf PORTD
    call Delay
    movlw 0x55
    movwf PORTD
    call Delay
    return

centerout:
    movlw 0x18
    movwf PORTD
    call Delay
    movlw 0x24
    movwf PORTD
    call Delay
    movlw 0x42
    movwf PORTD
    call Delay
    movlw 0x81
    movwf PORTD
    call Delay
    return

outcenter:
    movlw 0x81
    movwf PORTD
    call Delay
    movlw 0x42
    movwf PORTD
    call Delay
    movlw 0x24
    movwf PORTD
    call Delay
    movlw 0x18
    movwf PORTD
    call Delay
    return

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
    DECFSZ R1, F             ; Decrement outer loop counter
    GOTO Delay_Outer         ; Repeat outer loop
    RETURN                   ; Return from delay

    END                      ; End of program
;todopic y aquihayapuntes
