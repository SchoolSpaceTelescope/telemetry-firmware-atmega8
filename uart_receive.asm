;uart_receive.asm

USART_RXC:
in temp, UDR ; receive
sbrc temp, 4 ;if cmd1 bit clear, skip
rjmp CH_SET

sbrs temp, 3 ;if cmd0 bit set, skip
rjmp VERSION_ANSW ;if clear, answer version
;rjmp CH_ALL ;else transmit all channels
reti

CH_SET:
mov ch, temp
andi ch, 0b00001111 ;mask ch_type in CMD0 and CH_NUM
rcall CH_SELECT
reti


CH_SELECT:
mov ch_num, ch
andi ch_num, 0b00000111 ; mask for channel number

sbrs ch, 3
rjmp SPI_CH
rjmp ADC_CH


VERSION_ANSW:
ldi temp, VERSION
UART_Tx temp
reti


.include "adc_ch.asm"
.include "spi_ch.asm"
