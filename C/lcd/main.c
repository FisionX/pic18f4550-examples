//#include <xc.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <delay.h>
#include <pic18fregs.h>

#pragma config XINST = OFF
#pragma config FOSC = HS
#pragma config WDT = OFF
#pragma config LVP = OFF
#pragma config MCLRE = OFF
//#include "newxc8_header.h"
#define _XTAL_FREQ 8000000
//#define delay1ktcy(x) _delay((unsigned long)((x)*(_XTAL_FREQ/4000.0)))
// set up the timing for the LCD delays
#define LCD_delay 5 // ~5mS
#define LCD_Startup 15 // ~15mS

// Command set for Hitachi 44780U LCD display controller
#define LCD_CLEAR 0x01
#define LCD_HOME 0x02
#define LCD_CURSOR_BACK 0x10
#define LCD_CURSOR_FWD 0x14
#define LCD_PAN_LEFT 0x18
#define LCD_PAN_RIGHT 0x1C
#define LCD_CURSOR_OFF 0x0C
#define LCD_CURSOR_ON 0x0E
#define LCD_CURSOR_BLINK 0x0F
#define LCD_CURSOR_LINE2 0xC0

// display controller setup commands from page 46 of Hitachi datasheet
#define FUNCTION_SET 0x28 // 4 bit interface, 2 lines, 5x8 font
#define ENTRY_MODE 0x06 // increment mode
#define DISPLAY_SETUP 0x0C // display on, cursor off, blink offd

#define LCDLine1() LCDPutCmd(LCD_HOME) // legacy support
#define LCDLine2() LCDPutCmd(LCD_CURSOR_LINE2) // legacy support
#define shift_cursor() LCDPutCmd(LCD_CURSOR_FWD) // legacy support
#define cursor_on() LCDPutCmd(LCD_CURSOR_ON) // legacy support
#define DisplayClr() LCDPutCmd(LCD_CLEAR) // Legacy support


//----------------------------------------------------------------------
// Definitions specific to the PICDEM 2 Plus
// These apply to the Black (2011) version.
//----------------------------------------------------------------------

// single bit for selecting command register or data register
#define instr 0
#define data 1

// These #defines create the pin connections to the LCD in case they are changed on a future demo board
#define LCD_PORT PORTD
#define LCD_PWR PORTDbits.RD7 // LCD power pin
#define LCD_EN PORTDbits.RD6 // LCD enable
#define LCD_RW PORTDbits.RD5 // LCD read/write line
#define LCD_RS PORTDbits.RD4 // LCD register select line

#define NB_LINES 2 // Number of display lines
#define NB_COL 16 // Number of characters per line

void LCD_Initialize(void);
void LCDPutChar(char ch);
void LCDPutCmd(char ch);
void LCDPutStr(const char *); 
void LCDWriteNibble(char ch, char rs);
void LCDGoto(char pos, char ln);

void main(void) 
{
    OSCCON=0x72; // Select internal oscillator with frequency = 8MHz
    LCD_Initialize();
    LCDPutStr(" Hello World!"); //Display String "Hello World"
    LCDGoto(8,1); //Go to column 8 of second line
    LCDPutChar('1'); //Display character '1'
    DisplayClr(); // Clear the display

    LCDPutStr(" LCD Display"); // Dispay a string "LCD Display"
    LCDGoto(0,1); //Go to second line 
    LCDPutStr("Micro Lab"); //Display String "Micro Lab" 
    while (1)
    {
        // Add your application code
    }
    return;
}

void LCD_Initialize()
{
    // clear latches before enabling TRIS bits
    LCD_PORT = 0;

    TRISD = 0x00;

    // power up the LCD
    LCD_PWR = 1;

    // required by display controller to allow power to stabilize
    delay1ktcy(LCD_Startup);

    // required by display initialization
    LCDPutCmd(0x32);

    // set interface size, # of lines and font
    LCDPutCmd(FUNCTION_SET);

    // turn on display and sets up cursor
    LCDPutCmd(DISPLAY_SETUP);

    DisplayClr();

    // set cursor movement direction
    LCDPutCmd(ENTRY_MODE);

}


void LCDWriteNibble(char ch, char rs)
{
    // always send the upper nibble
    ch = (ch >> 4);

    // mask off the nibble to be transmitted
    ch = (ch & 0x0F);

    // clear the lower half of LCD_PORT
    LCD_PORT = (LCD_PORT & 0xF0);

    // move the nibble onto LCD_PORT
    LCD_PORT = (LCD_PORT | ch);

    // set data/instr bit to 0 = insructions; 1 = data
    LCD_RS = rs;

    // RW - set write mode
    LCD_RW = 0;

    // set up enable before writing nibble
    LCD_EN = 1;

    // turn off enable after write of nibble
    LCD_EN = 0;
}

void LCDPutChar(char ch)
{
    delay1ktcy(LCD_delay);

    //Send higher nibble first
    LCDWriteNibble(ch,data);

    //get the lower nibble
    ch = (ch << 4);

    // Now send the low nibble
    LCDWriteNibble(ch,data);
}


void LCDPutCmd(char ch)
{
    delay1ktcy(LCD_delay);

    //Send the higher nibble
    LCDWriteNibble(ch,instr);

    //get the lower nibble
    ch = (ch << 4);

    delay1ktcy(1);

    //Now send the lower nibble
    LCDWriteNibble(ch,instr);
}


void LCDPutStr(const char *str)
{
    char i=0;

    // While string has not been fully traveresed
    while (str[i])
    {
        // Go display current char
        LCDPutChar(str[i++]);
    }

}

void LCDGoto(char pos,char ln)
{
    // if incorrect line or column
    if ((ln > (NB_LINES-1)) || (pos > (NB_COL-1)))
    {
        // Just do nothing
        return;
    }

    // LCD_Goto command
    LCDPutCmd((ln == 1) ? (0xC0 | pos) : (0x80 | pos));

    // Wait for the LCD to finish
    delay1ktcy(LCD_delay);
}
