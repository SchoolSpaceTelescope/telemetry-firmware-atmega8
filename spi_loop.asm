SPI_LOOP:
nop
nop
nop
nop
sbi PORTB, SCK ;strobe
nop
sbic PINC, SO ;read bit, skip if 0
rjmp r1_bit
clc ;if 0 reset carry
rjmp rend_bit

r1_bit:
sec ;if 1 set carry

rend_bit:
rol temp2 ;roll left with carry
cbi PORTB, SCK ;strobe
nop
dec temp1
brne SPI_LOOP
ret
