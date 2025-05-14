    LIST P=18F4550
    #include <P18F4550.inc>

    CONFIG FOSC = HS ; Use internal oscillator, RA6 as clock output
    CONFIG WDT = OFF          ; Watchdog Timer off
    CONFIG LVP = OFF          ; Low-Voltage Programming off
    CONFIG MCLRE = ON        ; MCLR pin disabled, RE3 input enabled
    ORG 0x00
    GOTO INIT

    ORG 0x08   ; Interrupt vector for high-priority interrupts
    GOTO ISR   ; Jump to Interrupt Service Routine

INIT:
    ; === Configure RB4-RB7 as Input ===
    movlw 0xff
    movwf TRISB
    clrf TRISD
    clrf LATD

    movlw 0x0f
    movwf ADCON1

    ; === Enable RB Port Change Interrupt ===
    BCF INTCON2, RBPU  ; Enable PORTB pull-ups
    BSF INTCON2, 0     ; Set interrupt on high priority RBIP
    BSF INTCON, RBIE   ; Enable RB Port Change Interrupt
    BSF INTCON, GIE    ; Enable Global Interrupts
    BSF INTCON, PEIE   ; Enable Peripheral Interrupts
    ;BSF INTCON2, 6
    ; INT0
    BSF INTCON, INT0IE
    BSF INTCON2, INTEDG0
    BSF INTCON, INT1IE
    BSF INTCON2, INTEDG1

MAIN_LOOP:
    ;MOVFF PORTB, PORTD
    GOTO MAIN_LOOP     ; Stay in loop, wait for interrupts

; === Interrupt Service Routine ===
ISR:
    ;BTFSS INTCON, RBIF  ; Check if RB Change interrupt occurred
    ;RETFIE              ; Return if not triggered
    ;BTFSS INTCON, INT0IF
    ;RETFIE

    MOVF PORTB, W       ; Read PORTB (necessary to clear mismatch condition)
    NOP
    NOP
    NOP
    NOP
    
    ; === Your Custom Interrupt Handling Code ===
    ; Example: Toggle PORTD on RB change
    ;BTG PORTD, 0
    MOVFF PORTB, PORTD
    
    BCF INTCON, RBIF    ; Clear the RBIF flag
    BCF INTCON, INT0IF
    BCF INTCON, INT1IF
    RETFIE              ; Return from interrupt

    END

