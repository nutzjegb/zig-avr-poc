#define F_CPU 20000000UL
#define BAUD_RATE 115200

#include <stdint.h>
#include <stdbool.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

#define PB3_LED0        8
#define PB2_SW0         4
#define PC0_USART1_TX   1

static volatile uint16_t delay = 1000;

ISR(PORTB_PORT_vect)
{
    switch(delay) {
        case 100: delay = 250; break;
        case 250: delay = 500; break;
        case 500: delay = 1000; break;
        case 1000: delay = 100; break;
        default: delay = 1000; break;
    }
    PORTB.INTFLAGS = 0xff;
}

static void usart_init(void) {
    uint16_t buadrate = (64 * F_CPU) / (16 * BAUD_RATE);
    USART1.BAUD = buadrate;
    USART1.CTRLC = USART_CMODE_ASYNCHRONOUS_gc | USART_PMODE_ODD_gc | USART_SBMODE_1BIT_gc | USART_CHSIZE_8BIT_gc;

    // Configure the TX pin as output
    PORTC.DIRSET = PC0_USART1_TX;

    // Enable USART
    USART1.CTRLB = 1 << USART_TXEN_bp;
}

static void putstr(const char *str) {
    while (*str != '\0') {
        while ((USART1.STATUS & USART_DREIF_bm) == 0) {}
        USART1.TXDATAL = *str;
        str++;
    }
}

int main(void)
{
    CCP = CCP_IOREG_gc;
    CLKCTRL.MCLKCTRLB = 0;

    PORTB.DIRSET = PB3_LED0;

    usart_init();
    putstr("Hello world!\n");

    /* Enable SW0 int */
    PORTB.INTFLAGS = 0xff;
    PORTB.PIN2CTRL = PORT_ISC_RISING_gc | PORT_PULLUPEN_bm;
    sei();

    bool led_on = true;
    while(true) {
        if (led_on)
            PORTB.OUTSET = PB3_LED0;
        else
            PORTB.OUTCLR = PB3_LED0;
        led_on = !led_on;

        putstr("delay ");
        switch(delay) {
            case 100: putstr("100\n"); _delay_ms(100); break;
            case 250: putstr("250\n"); _delay_ms(250); break;
            case 500: putstr("500\n"); _delay_ms(500); break;
            case 1000:
            default:
                      putstr("1000\n"); _delay_ms(1000); break;
        }
    }
    return 0;
}
