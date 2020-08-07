# Telemetry Firmware for ATMega8
Firmware for ATMega8 chip on electrical system and termal mode telemetry board.

## UART commands description
Here is description of transmit bits of commands:
Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0
-- | -- | -- | -- | -- | -- | -- | --
0 | 0 | 0 | CMD1 | CMD0 | CH_NUM2 | CH_NUM1 | CH_NUM0

- ### CMD - command

CMD1 | CMD0 |  Description
-- | -- | --
0 | 0 | Get firmware version
0 | 1 | Reserved
1 | 0 | Get value of SPI channel
1 | 1 | Get value of ADC channel

- ### CH_NUM – select channel (from 0 to 7)

CH_NUM2 | CH_NUM1 | CH_NUM0 |  Description
-- | -- | -- | --
0 | 0 | 0 | Select channel 0
0 | 0 | 1 | Select channel 1
0 | 1 | 0 | Select channel 2
… | … | … | …


### 1.	Firmware version
Get version of firmware and check properly working of chip:
Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0
-- | -- | -- | -- | -- | -- | -- | --
0 | 0 | 0 | CMD1 | CMD0 | CH_NUM2 | CH_NUM1 | CH_NUM0
0 | 0 | 0 | 0 | 0 | 0 | 0 | 0


Chip answer (version 5):
Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0
-- | -- | -- | -- | -- | -- | -- | --
VER7 | VER6 | VER5 | VER4 | VER3 | VER2 | VER1 | VER0
0 | 0 | 0 | 0 | 0 | 1 | 0 | 1

### 2.	Get value of SPI channel
Here is an example of getting value of SPI channel 4:
Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0
-- | -- | -- | -- | -- | -- | -- | --
0 | 0 | 0 | CMD1 | CMD0 | CH_NUM2 | CH_NUM1 | CH_NUM0
0 | 0 | 0 | 1 | 0 | 1 | 0 | 0

Chip answer (temperature +25 °C):
Bit 15 | Bit 14 | Bit 13 | Bit 12 | Bit 11 | Bit 10 | Bit 9 | Bit 8 | Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0
-- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --
D15 | D14 | D13 | D12 | D11 | D10 | D9 | D8 | D7 | D6 | D5 | D4 | CMD0 | CH_NUM2 | CH_NUM1 | CH_NUM0
0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0

D15 is sign part, D14-D7 is integer part, D6-D4 is fractional part.
For temperature value examples and more info see MAX6630 [datasheet](https://datasheets.maximintegrated.com/en/ds/MAX6629-MAX6632.pdf).

### 3.	Get value of ADC channel
Here is an example of getting value of ADC channel 6:
Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0
-- | -- | -- | -- | -- | -- | -- | --
0 | 0 | 0 | CMD1 | CMD0 | CH_NUM2 | CH_NUM1 | CH_NUM0
0 | 0 | 0 | 1 | 0 | 1 | 1 | 0

Chip answer (raw value 2523):
Bit 15 | Bit 14 | Bit 13 | Bit 12 | Bit 11 | Bit 10 | Bit 9 | Bit 8 | Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0
-- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --
D12 | D11 | D10 | D9 | D8 | D7 | D6 | D5 | D4 | D3 | D2 | D1 | CMD0 | CH_NUM2 | CH_NUM1 | CH_NUM0
1 | 0 | 0 | 1 | 1 | 1 | 0 |1 | 1 | 0 |1 | 1 | 1 | 1 | 1 | 0
