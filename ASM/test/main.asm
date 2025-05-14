; Input output test
LIST P=18F4550, F=INHX32  ; Specify processor and hex format
#include <p18f4550.inc>

CONFIG FOSC = HS ; Use internal oscillator, RA6 as clock output
CONFIG WDT = OFF          ; Watchdog Timer off
CONFIG LVP = OFF          ; Low-Voltage Programming off
CONFIG MCLRE = OFF        ; MCLR pin disabled, RE3 input enabled
R1 EQU 0x020
R2 EQU 0x021
TEMP EQU 0x22

    ORG 0x00                 ; Program starts at address 0

Start:
    ; Initialize PORTB
    CLRF TRISD               ; Set all PORTB pins as output
    CLRF LATD                ; Clear PORTB outputs

    BCF INTCON2, 7
    MOVLW 0fh           ; Set all pins to digital I/0
    MOVWF ADCON1
    MOVLW 0xFF
    MOVWF TRISB
    CLRF LATB
    ;MOVLW 0x0E
    ;MOVWF PORTB


loop: ; Read first nibble of port D and print it to the second nibble
    MOVFF PORTB, PORTD

    END                      ; End of program
