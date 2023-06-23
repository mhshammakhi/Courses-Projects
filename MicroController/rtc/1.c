/*****************************************************
This program was produced by the
CodeWizardAVR V2.04.4a Advanced
Automatic Program Generator
© Copyright 1998-2009 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 13/05/2013
Author  : NeVaDa
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

// Alphanumeric LCD Module functions
#asm
   .equ __lcd_port=0x1B ;PORTA
#endasm
#include <lcd.h>

// Declare your global variables here
flash char key[4][4]={{'c','0','=','+'},{'1','2','3','-'},{'4','5','6','*'},{'7','8','9','/'}};
flash char row[]={0xfe,0xfd,0xfb,0xf7};
unsigned char x,ac,table;
unsigned int r,a=0,b=0;

void keypad()
 {
 PORTB=0xff;
 DDRB=0x0f;
 lcd_gotoxy(a,b);
    while (1)
    {
    for(r=0;r<=3;r++)
     {
     ac=4;
     PORTB=row[r];
     DDRB=0x0f;
     if (PINB.4==0)
     ac=0;
     if (PINB.4==0)
     ac=1;
     if (PINB.4==0)
     ac=2;
     if (PINB.4==0)
     ac=3;
      if(!(ac==4))
       {
       table=key[r][ac];
       lcd_putchar(table);
       a++;
       }
      while (PORTB.4==0) {}
      while (PORTB.5==0) {}
      while (PORTB.6==0) {}
      while (PORTB.7==0) {}
      }     
     }
     }
    
void main(void)
{
// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;


// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x00;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0x00;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=FFh
// OC0 output: Disconnected
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=FFh
// OC2 output: Disconnected
ASSR=0x00;
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// LCD module initialization

while (1)
      {
PORTB=0x0f;
DDRB=0x0f;
x=PINB;
if (x!=0)
keypad();

      };
}
