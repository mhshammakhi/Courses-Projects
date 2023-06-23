/*****************************************************
Project : Nobat Deheie Bank with UART 
Author  : Hossein Ghavami (89515265) & Aryan Yazdanpanah(89515236) & Masoud Mardanshahi(88515097)                                              
Chip type           : ATmega16
Clock frequency     : 4.000000 MHz
*****************************************************/
#include <mega16.h>
#include <sleep.h>
#include <stdio.h>
#include <delay.h>

void main(){
unsigned char a;
UCSRA=0x00;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x67;
DDRC=0X00;
PORTC=0x00;
DDRB=0XFF;
PORTB=0x00;
while(1){
if (PINC.0==0|PINC.1==0){
UCSRB=0x00;
delay_ms(1000);
PORTC=0xFF;
 PORTB=0x00;
}

if(PINC.0==1&PINC.1==1){
UCSRB=0x08;
 PORTB=0xFF;
a='n';
putchar(a);
delay_ms(100);
  PORTB=0x00;
PORTC=0X00;

}
}
}