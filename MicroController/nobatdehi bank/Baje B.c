/*****************************************************
Project : Nobat Deheie Bank with UART 
Author  : Hossein Ghavami (89515265) & Aryan Yazdanpanah(89515236) & Masod Mardanshahi(88515097)                                              
Chip type           : ATmega16
Clock frequency     : 4.000000 MHz
*****************************************************/
#include <mega16.h>
#include <stdio.h>
#include <delay.h>
#include <lcd.h>
#asm
.equ __lcd_PORT=0x1b; PORTA
#endasm
unsigned char lcdm[31];
void main(){
unsigned char a;
UCSRA=0x00;
UCSRB=0x10;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x67;
DDRC=0X00;
PORTC.0=1;
DDRB=0XFF;
PORTB=0x00;
while(1){ a=getchar();
if (a=='B')
{delay_ms(1000);
a=getchar();
if ((a!='A')&(a!='B'))
{sprintf(lcdm,"number=%4u",a);
lcd_gotoxy(0,0);
lcd_puts(lcdm);
a='n'   ;
putchar(a);
}
}

}
}