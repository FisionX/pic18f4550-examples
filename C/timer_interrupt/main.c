/* A blink program using a timer overflow interrupt */

#include <delay.h>
#include <pic18fregs.h>
#include <stdint.h>

// FUSES START
#pragma config XINST = OFF
#pragma config FOSC = HS
#pragma config WDT = OFF
#pragma config LVP = OFF
#pragma config MCLRE = OFF

#define NDIGITS 4
#define RATE 250


uint8_t digit[NDIGITS] = { 0 };
uint8_t dsp_en = 0;

void setup(void);
void isr(void) __interrupt (1);
void tmr_isr(void);
uint8_t number_to_7seg(uint8_t);
void display(uint16_t);
int main(void);

void setup(void){
    /* Port setup */
    LATD = 0;
    TRISD = 0;
    
    TRISB = 0xff;
    LATB = 0x00;
    ADCON1 = 0xf;

    TRISE = 0;
    LATE = 0;

    TRISA = 0;
    LATA = 0;

    /* Interrupt setup */
    INTCONbits.GIE = 1;
    INTCONbits.PEIE = 1;
    INTCONbits.RBIE = 0;
    INTCON2bits.RBPU = 0;
    INTCON2bits.RBIP = 1;
    RCONbits.IPEN = 1;

    /* timer interrupt setup */
    INTCONbits.TMR0IE = 1;
    INTCON2bits.TMR0IP = 1;

    T0CONbits.T08BIT = 1;
    T0CONbits.T0CS = 0; // Source internal oscilator
    T0CONbits.PSA = 0;
    //T0CONbits.T0PS0 = 1;
    //T0CONbits.T0PS1 = 1;
    //T0CONbits.T0PS2 = 1;
    T0CONbits.T0PS = 0x7;
    T0CONbits.TMR0ON = 1;
}

void isr(void) __interrupt (1) {
    if (INTCONbits.TMR0IF){
        tmr_isr();
        TMR0 = RATE;
    }
    INTCONbits.TMR0IF = 0;
}

void tmr_isr(void){
    LATA = LATE = 0;
    LATD = number_to_7seg(digit[dsp_en]);
    switch (dsp_en) {
        case 0:
            LATA = 0;
            LATE = 0x4;
            break;
        case 1:
            LATE = 0x2;
            break;
        case 2:
            LATE = 0x1;
            break;
        case 3:
            LATE = 0;
            LATA = 0x10;
            break;
    }
    dsp_en++;
    if (dsp_en > 3) dsp_en = 0;
}

uint8_t number_to_7seg(uint8_t number) {
    switch (number) {
        case 0:
            return 0x3F;
        case 1:
            return 0x06;
        case 2:
            return 0x5B;
        case 3:
            return 0x4F;
        case 4:
            return 0x66;
        case 5:
            return 0x6D;
        case 6:
            return 0x7D;
        case 7:
            return 0x07;
        case 8:
            return 0x7F;
        case 9:
            return 0x6F;
        case 0xa:
            return 0x77;
        case 0xb:
            return 0x7c;
        case 0xC:
            return 0x39;
        case 0xd:
            return 0x5e;
        case 0xe:
            return 0x79;
        case 0xf:
            return 0x71;
        default:
            return 0;
    }
}
void display(uint16_t num){
    uint8_t i = 0;
    if (num > 9999) return;
    while(num) {
        digit[i] = num%10;
        num = num/10;
        i++;
    }
}

int main(void) {
    uint16_t cuenta = 0;
    setup();
    for (;;) {
        display(cuenta);
        delay1ktcy(500);
        cuenta++;
    }
    return 0;
}
