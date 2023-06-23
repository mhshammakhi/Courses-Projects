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
unsigned char lcd[31];
void main(){
unsigned char a='p';
unsigned int c=0;
unsigned int b=0;
unsigned int counter=0;
unsigned int n=0;
lcd_init(16);
lcd_clear();
UCSRA=0x00;
UCSRB=0x10;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x67;
DDRC=0x00;
PORTC.0=1;

lcd_gotoxy(0,0);
lcd_putsf("Wellcome to Bank");

while(1){

if (PINC.0==0)
{counter++;
b++;

sprintf(lcdm,"Your number=%4u",counter);
lcd_gotoxy(0,0);
lcd_puts(lcdm);
delay_ms(350);
PORTC.0=1;
 }  
    a=getchar();    
 if ((a=='A')|(a=='B')){
if(n>0)
{n--;
}
c=counter-n;
lcd_gotoxy(1,1);
sprintf(lcd,"%4u Go badget %c",c,a);
lcd_puts(lcd);
a='p';
} 
 if ( b>0){
  if ( a=='n'){
n++;
b=0;
 }
 }
    }}
