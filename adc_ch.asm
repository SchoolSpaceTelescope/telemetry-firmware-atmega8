;adc_ch.asm

ADC_CH:
in temp, ADMUX ; get current ADMUX
andi temp, 0b11110000 ; mask for other regs in ADMUX

or temp, ch_num ; concat params (MUX and others)

out ADMUX, temp ; set mux

in	temp, ADCSRA
ori	temp, (1 << ADSC) ; start conversion
out	ADCSRA, temp
ret

ADC_Complete:
in temp1, ADCL
in temp2, ADCH

andi temp1, 0b11110000 ;maxk for low bits, clearing for ch settings
or temp1, ch ;concat with ch settings

UART_Tx temp2
UART_Tx temp1
reti

