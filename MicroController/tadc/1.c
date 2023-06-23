/*****************************************************
This program was produced by the
CodeWizardAVR V2.04.4a Advanced
Automatic Program Generator
© Copyright 1998-2009 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 2013/05/16
Author  : NeVaDa
Company : mh
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 2.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/

#include <mega16.h>
#include <delay.h>


char d;
// ADC interrupt service routine
interrupt [ADC_INT] void adc_isr(void)
{

// Read the 8 most significant bits
// of the AD conversion result
PORTD=ADCL;
d=ADCL;



ADCSRA=0x40;
  
}

// Declare your global variables here

void main(void)
{
PORTA=0x00;
DDRA=0x00;
PORTC=0x00;
DDRC=0xff;
PORTD=0x00;
DDRD=0xff;


TIMSK=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: AREF pin
// ADC Auto Trigger Source: None
// Only the 8 most significant bits of
// the AD conversion result are used
ADMUX=0x40;
ADCSRA=0x8D;

// Global enable interrupts
#asm("sei")

while (1)
      {
ADCSRA=0x89;



ADCSRA=0xC9;
      };
}
