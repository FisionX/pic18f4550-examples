#include <stdio.h>
#include <stdint.h>

uint8_t digit[4] = { 0 };

void splitdigit(uint16_t);
void splitdigit(uint16_t num) {
    uint8_t i = 0;
    while (num) {
        digit[i] = num%10;
        num = num/10;
        i++;
    }
}

int main(void) {
    uint8_t i;
    uint8_t y = 2;
    uint8_t x = 3;
    splitdigit(24);
    for (i = 0; i < 4; i++) {
        printf("%d\n", digit[i]);
    }
    y = x = 2;
    printf("x = %d\n", x);
    printf("y = %d\n", y);

    return 0;
}
