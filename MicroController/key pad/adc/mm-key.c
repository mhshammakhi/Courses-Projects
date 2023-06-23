/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 5/22/2013
Author  : mohammad hasan-masoud
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
#include <stdlib.h>

#define ADC_VREF_TYPE 0x40
#asm
   .equ __lcd_port=0x12 ;
#endasm
char a,x,b[16];
#include <lcd.h>
// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}

// Declare your global variables here

void main(void)
{

// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: AVCC pin
// ADC Auto Trigger Source: ADC Stopped
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0x82;

// SPI initialization
// SPI disabled
SPCR=0x00;

// TWI initialization
// TWI disabled
TWCR=0x00;
   lcd_init(16);
    lcd_gotoxy(0,1);
    sprintf(b,"mh.sha-m.mar");
    lcd_puts(b);
while (1)
      {
      
      a=read_adc(0);
     if (a){ 
     if (a==40) x='0';
     else if (a==45) x='1';
     else if (a==50) x='2';
     else if (a==55) x='3';
     else if (a==57) x='4';
     else if (a==66) x='5';
     else if (a==76) x='6';
     else if (a==98) x='7';
     else if (a==128) x='8';
     else if (a==171) x='9';
     else if (a==37) x='c';
     else if (a==44) x='=';
     else if (a==47) x='+';
     else if (a==60) x='-';
     else if (a==85) x='*';
     else if (a==227) x='/';
     
     
     lcd_gotoxy(0,0);
     
     lcd_putchar(x);
      
     }   
      delay_ms(10); 
       }

     
}
