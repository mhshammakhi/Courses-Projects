/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Advanced
Automatic Program Generator
© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 6/8/2013
Author  : mohammad hasan shammakhi
Company : 
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/

#include <mega16.h>
#include <spi.h>
#include <stdio.h>
#include <delay.h>
// Alphanumeric LCD Module functions
#include <lcd.h>
    #asm
    .equ __lcd_port=0x15;
    #endasm
int n=0;
char a[3];

//int b1,b2,b3;
char buf1[16],buf2[16],buf3[16];
char mode;
// SPI interrupt service routine
interrupt [SPI_STC] void spi_isr(void)
{
unsigned char data;
data=SPDR;
a[n]=data;
n++;
if(n==3) {n=0;}
// Place your code here

}

// Declare your global variables here

void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x03;
DDRA=0x00;

// Port B initialization
// Func7=In Func6=Out Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=0 State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x40;

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
// Mode: Normal top=0xFF
// OC0 output: Disconnected
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
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

// USART initialization
// USART disabled
UCSRB=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC disabled
ADCSRA=0x00;

// SPI initialization
// SPI Type: Slave
// SPI Clock Phase: Cycle Start
// SPI Clock Polarity: Low
// SPI Data Order: MSB First
SPCR=0xC0;
SPSR=0x00;

// Clear the SPI interrupt flag
#asm
    in   r30,spsr
    in   r30,spdr
#endasm

// TWI initialization
// TWI disabled
TWCR=0x00;

// Alphanumeric LCD initialization
// Connections specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTC Bit 0
// RD - PORTC Bit 1
// EN - PORTC Bit 2
// D4 - PORTC Bit 4
// D5 - PORTC Bit 5
// D6 - PORTC Bit 6
// D7 - PORTC Bit 7
// Characters/line: 8
lcd_init(16);

// Global enable interrupts
#asm("sei")

while (1)
      {
      // Place your code here

      
      if(PINA.0==0)
      {
        PORTD=0XF0;
         sprintf(buf2,"temp1=%d C",a[0]);
     
      lcd_gotoxy(0,0);
      lcd_puts(buf2);
      mode=1;  
      
      }             
      if(PINA.1==0)
      {
      sprintf(buf3,"temp3=%u C",a[2]);
      PORTD=0X0F;
      lcd_gotoxy(0,0);
      lcd_puts(buf3);
      mode=1;
      }
      if(mode==0)
      {
      sprintf(buf1,"temp2=%u C",a[1]);

      lcd_gotoxy(0,0);
      lcd_puts(buf1);     

      }   
      delay_ms(1000);

      mode=0;
      }
}
