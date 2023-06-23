/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 6/7/2013
Author  : mh
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
#include <lcd.h>
#include <delay.h>
#include <stdio.h>
#include <stdlib.h>
int ef;
unsigned long int f,p;
unsigned char a=0,x=0,n=0,str[10];

// Timer2 overflow interrupt service routine
interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{
// Place your code here
x++;
if (x==18) {x=0;n++;}   // ye meyare zamani ke in dar inja 0.5 sanie ast
}
#define ADC_VREF_TYPE 0x60
#asm
   .equ __lcd_port=0x12 ;PORTD  
#endasm

// Read the 8 most significant bits
// of the AD conversion result
unsigned char read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);  // baraye tasbit adc ast
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCH;
}

// Declare your global variables here

void main(void)
{
// Declare your local variables here
PORTA=0x00;
DDRA=0x00;
// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x40;

// USART initialization
// USART disabled
UCSRB=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: AREF pin
// ADC Auto Trigger Source: Free Running
// Only the 8 most significant bits of
// the AD conversion result are used
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0xA3;
SFIOR&=0x1F;

// SPI initialization
// SPI disabled
SPCR=0x00;

// TWI initialization
// TWI disabled
TWCR=0x00;

// Global enable interrupts
#asm("sei")

while (1)
      {
      if ((read_adc(0)==0xff)&a==0) {TCCR2=0x0F;TCNT2=0x00;OCR2=0xD9;a=1;}  // harvaght signale aval be peak bresad timer shrou mikone be shomordan
      if ((read_adc(0)!=0xff)&a==1) {a=2;}   // bara inke vaghti if balayi injam shod belafasele payini anjam nashe va motmaen mishim az peak kharej shodim
      if (read_adc(0)==0xff&a==2) //check mikonim bbinim dobare peak shode
      {f=(TCNT2+(18*n+x)*217);TCCR2=0x0f;TCNT2=0x00;OCR2=0xD9;a=3;x=0;n=0;} //in f va formuli ke neveshte shode tedade afzayesh haye tcnt ra moshakhas mikonad va timer az aval shoru be shomordan mikone 
       if (a==3&read_adc(1)==0xff) //inja check mishe ke signale dovom be peak reside ya na 
      {p=(TCNT2+(18*n+x)*217);TCCR2=0x00;a=4;} //va tedade afzayesh haye tcnt ro moshakhas mikone
// age bekham tozihaye bala ro kamel konam bayad begam ke ma aval harvaght peak signal1 beshe timer shoru mikone harvaght dobare peak beshe ghat mikone tedad vahed zamanayi ke ta un moghe tey shode ro mohasebe mikone va dar f save mikone ke hamun dore tanavobe.
// badesh timer dobare shuru mikone ta zamani ke signale dovomi peak bokhore va zaman dar p save mishe ke hamun ekhtelaf zamanie beyne peak shodane signale 1 o 2 hastesh
// hala nesbate p be f hamun ekhtelaf phase nesbie ke dar 360 zarb beshe mishe ekhtelaf phase bedast miad       
      if(a==4){ef=(((360*p)/f))*1.03;lcd_init(16);lcd_clear();sprintf(str,"Phase= %d",ef);lcd_puts(str);a=5;} //hala ef ro ru safhe namayesh mibinim ke hamun ekhtelaf phase hastesh
      
      }
}
