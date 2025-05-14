#include <pic18fregs.h>
#include <delay.h>
#include <stdint.h>

/* Configs options */
#pragma config XINST = OFF /* Extended instruction set */
#pragma config FOSC = HS   /* Internal osc             */
#pragma config WDT = OFF   /* Watchdog timer           */
#pragma config LVP = OFF   /* Single Supply ICSP OFF   */
#pragma config MCLRE = OFF

#define LED_LAT LATDbits.LATD1
#define LED_TRIS TRISDbits.TRISD1

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

void main(void) {
    uint8_t i;

    TRISD = 0;
    LATD = 0;
    TRISE = 0;
    LATE = 0x04;

    while (1) {
        for (i = 0; i < 15; i++) {
            LATD = number_to_7seg(i);
            delay1ktcy(250); // 1s @ 1MHz
        }
    }
}
