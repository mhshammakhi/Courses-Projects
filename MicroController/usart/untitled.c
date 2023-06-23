/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
� Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : reciver mh
Version : 
Date    : 5/22/2013
Author  : mh
Company : 
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 4.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/

#include <mega16.h>
#include <delay.h>
#include <stdio.h>
#asm
.equ __lcd_port=0x1B
#endasm
#include <lcd.h>
char b[10],c;
void main(void)
{
PORTB=0x00;
DDRB=0x00;

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: Off
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud Rate: 4800 (Double Speed Mode)
UCSRA=0x00;
UCSRB=0x10;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x67;


while (1)
      {
c=getchar();
sprintf(mh,"data:%d",c);
lcd_gotoxy(0,0);
lcd_puts(mh);
delay_ms(500);
      }
}