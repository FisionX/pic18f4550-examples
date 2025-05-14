#include <delay.h>
#include <pic18fregs.h>

// FUSES START
#pragma config XINST = OFF
#pragma config FOSC = HS
#pragma config WDT = OFF
#pragma config LVP = OFF
#pragma config MCLRE = OFF

void setup(void);
void isr(void) __interrupt (1);
int main(void);

void setup(void){
    LATD = 0;
    TRISD = 0;
    
    TRISB = 0xff;
    LATB = 0x00;
    ADCON1 = 0xf;

    INTCONbits.GIE = 1;
    INTCONbits.PEIE = 1;
    INTCONbits.RBIE = 0;
    INTCON2bits.RBPU = 0;
    INTCON2bits.RBIP = 1;
    RCONbits.IPEN = 1;

    //NTCONbits.INT0IE = 1;
}

void isr(void) __interrupt (1) {
    if (INTCONbits.RBIF) {
    //if (INTCONbits.INT0IF) {
    WREG = PORTB; /* Read portb to elimitate mismatch condition */
    LATD = ~LATD;
    delay1ktcy(250);
    }
    //INTCONbits.INT0IF = 0;
    INTCONbits.RBIF = 0;
}

int main(void) {
    setup();
    for (;;) {
        //PORTD = PORTB /* LATB does not work for reading */
        PORTDbits.RD0 = PORTBbits.RB0;
        if (PORTDbits.RD0){
            PORTDbits.RD1 = 1;
        } else PORTDbits.RD1 = 0;


    }
    return 0;
}
