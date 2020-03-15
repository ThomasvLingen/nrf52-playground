#include <boards.h>
#include <nrf_delay.h>
#include <SEGGER_RTT.h>


int main(void)
{
    unsigned int blinks = 0;

    SEGGER_RTT_Init();
    bsp_board_init(BSP_INIT_LEDS);

    while (true) {
        bsp_board_led_invert(0);
        SEGGER_RTT_printf(0, "Blink %d\n", blinks++);

        nrf_delay_ms(500);
    }
}
