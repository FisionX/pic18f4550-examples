LIST P=18F4550, F=INHX32  ; Specify processor and hex format
#include <p18f4550.inc>

CONFIG FOSC = INTOSCIO_EC ; Use internal oscillator, RA6 as clock output
CONFIG WDT = OFF          ; Watchdog Timer off
CONFIG LVP = OFF          ; Low-Voltage Programming off
CONFIG MCLRE = OFF        ; MCLR pin disabled, RE3 input enabled
R1 EQU 0x020
R2 EQU 0x021

ORG 0x00                 ; Program starts at address 0

Start:
    ; Initialize PORTB
    CLRF TRISD               ; Set all PORTB pins as output
    CLRF LATD                ; Clear PORTB outputs
    MOVLW 0x01
    MOVWF PORTD

left:
    CALL Delay               ; Delay
    RLCF PORTD, F
    BTFSS STATUS,0
    GOTO left                ; Repeat the loop
right:
    CALL Delay               ; Delay
    RRCF PORTD, F
    BTFSS STATUS,0
    GOTO right                ; Repeat the loop
    GOTO left

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
