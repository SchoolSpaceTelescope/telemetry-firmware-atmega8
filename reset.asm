RESET:
ldi temp, high(RAMEND)
out SPH, temp
ldi temp, low(RAMEND)
out SPL, temp

;================= USART
ldi temp, high(UBRR_CONST) ;BAUDRATE
out UBRRH, temp
ldi temp, low(UBRR_CONST)
out UBRRL, temp

ldi temp, (1<<RXCIE)|(1<<TXCIE)|(1<<RXEN)|(1<<TXEN) ;enable USART and interrupts
out UCSRB, temp
ldi temp, (1<<URSEL)|(1<<UCSZ1)|(1<<UCSZ0)
out UCSRC, temp

;================ PORTS
ldi temp, 0xFF ;out
out DDRB, temp

ldi temp, (0<<2)|(1<<1)|(1<<0) ;config sck and 2 cs
out PORTB, temp 

ldi temp, 0b11111110 ;out (except RxD)
out DDRD, temp

ldi temp, 0b11111100 ;config cs (except RxD and TxD)
out PORTD, temp

ldi temp, 0 ;in
out DDRC, temp


;================ ADC
ldi temp, 0x00 ;in
out DDRC, temp

ldi temp, 1<<ADLAR ;ext Vref and left adjust
out ADMUX, temp

ldi temp, (1<<ADEN)|(1<<ADIE)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0) ;enable ADC, manual mode, with interrupt
out ADCSRA, temp ;prescale FREQ/128
;================
sei ;enable interrupts
