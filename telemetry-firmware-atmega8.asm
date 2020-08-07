.include "m8def.inc"
.def temp = R16
.def temp1 = R17
.def temp2 = R18
.def ch = R19 ; channel_type and channel_num reg
.def ch_num = R20
.def temp3 = R21


.equ VERSION = 4

.equ BAUD = 9600
.equ FREQ = 14745600
.equ UBRR_CONST = FREQ / (16 * BAUD) - 1

.dseg

.cseg
.org 0


.macro UART_Tx
usart_loop:
sbis UCSRA, UDRE
rjmp usart_loop
out UDR, @0
.endmacro


rjmp RESET
.org $00b
rjmp USART_RXC ; USART RX Complete Handler
.org $00d
reti ; USART TX Complete Handler
.org $00e
rjmp ADC_Complete ; ADC Conversion Complete Handler


.include "reset.asm"

MAIN:
rjmp MAIN


;================

.include "uart_receive.asm"





