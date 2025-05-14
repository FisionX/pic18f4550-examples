/* this program makes light sequences using leds in port B */
#include <pic18fregs.h>
#include <delay.h>
#include <stdint.h>

/* Configs options */
#pragma config XINST = OFF /* Extended instruction set */
#pragma config FOSC = HS   /* Internal osc             */
#pragma config WDT = OFF   /* Watchdog timer           */
#pragma config LVP = OFF   /* Single Supply ICSP OFF   */
#pragma config MCLRE = OFF

#define RRCF(F) F = ((F >> 1) | (F << 7))
#define RLCF(F) F = ((F << 1) | (F >> 7))

void rota1(void);
void rota2(void);
void rota3(void);
void rota4(void);
void rota5(void);
void main(void);

void main(void) {
    TRISD = 0;
    LATD = 0;
    TRISE = 0;
    LATE = 0x04;
    TRISB = 0xff;
    //LATB = 0;

    INTCON2bits.RBPU = 0;
    ADCON1 = 0x0f;
    uint8_t port = 0;

    while (1) {
        port = PORTB;
        switch (port) {
            case 0x01:
                rota1();
                break;
            case 0x02:
                rota2();
                break;
            case 0x04:
                rota3();
                break;
            case 0x08:
                rota4();
                break;
            case 0x10:
                rota5();
                break;
        }
        delay1ktcy(50); // 1s @ 1MHz
    }
}

void rota1(void) {
    LATD = 1;
    while (LATD != 0x80) {
        delay1ktcy(150);
        RLCF(LATD);
    }
    return;
}
void rota2(void) {
    LATD = 0x80;
    while (LATD != 0x01) {
        delay1ktcy(150);
        RRCF(LATD);
    }
    return;
}
void rota3(void) { /* this is a mess, don't pay too much attention to this */
    LATD = 0x01;
    while (LATD != 0x80) {
        delay1ktcy(150);
        RLCF(LATD);
    }
    LATD = 0x81;
    while (LATD != 0xC0) {
        delay1ktcy(150);
        LATD = LATD << 1;
        LATD |= 0x80;
    }
    LATD = 0xC1;
    while (LATD != 0xE0) {
        delay1ktcy(150);
        LATD = LATD << 1;
        LATD |= 0xC0;
    }
    LATD = 0xE1;
    while (LATD != 0xF0) {
        delay1ktcy(150);
        LATD = LATD << 1;
        LATD |= 0xE0;
    }
    LATD = 0xF1;
    while (LATD != 0xF8) {
        delay1ktcy(150);
        LATD = LATD << 1;
        LATD |= 0xF0;
    }
    LATD = 0xF9;
    while (LATD != 0xFC) {
        delay1ktcy(150);
        LATD = LATD << 1;
        LATD |= 0xF8;
    }
    LATD = 0xFD;
    while (LATD != 0xFE) {
        delay1ktcy(150);
        LATD = LATD << 1;
        LATD |= 0xFC;
    }
    delay1ktcy(150);
    LATD = 0xFE;
    delay1ktcy(150);
    LATD = 0xFF;
    delay1ktcy(150);
    return;
}
void rota4(void) {
    LATD = 1;
    while (LATD != 0x80) {
        delay1ktcy(150);
        RLCF(LATD);
    }
    LATD = 0x80;
    while (LATD != 0x01) {
        delay1ktcy(150);
        RRCF(LATD);
    }
}
void rota5(void) {
    LATD = 0x55;
    delay1ktcy(150);
    LATD = 0xAA;
    delay1ktcy(150);
}

/* NOTES
 * Use PORT instead of LAT for reading
 * != as a not equal condition doesn't work in SDCC
 */
