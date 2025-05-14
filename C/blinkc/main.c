#include <delay.h>
#include <pic18fregs.h>

// FUSES START
#pragma config XINST = OFF
#pragma config FOSC = HS
#pragma config WDT = OFF
#pragma config LVP = OFF

// FUSES END

#define LED_LAT LATDbits.LATD1
#define LED_TRIS TRISDbits.TRISD1

void main(void) {
  LED_TRIS = 0; // Pin as output
  LED_LAT = 0;  // LED off

  while (1) {
    LED_LAT = !LED_LAT; // Toggle LED
    delay1ktcy(500);    // 500ms @ 1MHz
  }
}
