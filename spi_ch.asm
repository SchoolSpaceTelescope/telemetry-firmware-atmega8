.equ SCK = 2  ;pb2
.equ SO = 2 ;pc2

;cs0..1 pb0..1
;cs2..7 pd2..7
.include "spi_loop.asm"


rol_cnt:
rol temp1
dec temp2
brne rol_cnt
ret

SPI_CH: ;prepare channel
cbi PORTB, SCK ;drop sck
cpi ch_num, 2 ;if channel 2..7
brsh cs_d_0 ;set channels 2..7

cs_b_0: ;set ch 0..1 (chip_select)
in temp, PORTB ;get portb
ldi temp1, 0b11111110 ;set 0 for mask
mov temp2, ch_num ;copy ch num for counter
sec
sbrc temp2, 0 ;if ch = 0, skip
rcall rol_cnt ;roll left ch_num times
and temp, temp1 ; set bit mask
out PORTB, temp
rjmp SPI_R

cs_d_0:
in temp, PORTD
ldi temp1, 0b11111110
mov temp2, ch_num
sec
rcall rol_cnt
and temp, temp1
out PORTD, temp

SPI_R: ;read
ldi temp1, 8 ;counter
clr temp2 ;clear data byte
rcall SPI_LOOP

UART_Tx temp2

ldi temp1, 8 ;counter
clr temp2 ;clear data byte
rcall SPI_LOOP

andi temp2, 0b11110000 ;mask
or temp2, ch

UART_Tx temp2

cpi ch_num, 2 ;if channel 2..7
brsh cs_d_1 ;set channels 2..7

cs_b_1: ;set ch 0..1 (chip_select)
in temp, PORTB ;get portb
ldi temp1, 1 ;set 1 for mask
mov temp2, ch_num ;copy ch num for counter
clc
sbrc temp2, 0 ;if ch = 0, skip
rcall rol_cnt ;roll left ch_num times
or temp, temp1 ; set bit mask
out PORTB, temp
ret

cs_d_1:
in temp, PORTD
ldi temp1, 1
mov temp2, ch_num
clc
rcall rol_cnt
or temp, temp1
out PORTD, temp
ret


