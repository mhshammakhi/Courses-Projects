/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 6/5/2013
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
// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
// Place your code here
x++;
if (x==18) {n++;x=0;}


}
#asm
   .equ __lcd_port=0x12 ;PORTD
#endasm

#define FIRST_ADC_INPUT 0
#define LAST_ADC_INPUT 1
unsigned char adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];
#define ADC_VREF_TYPE 0x60

// ADC interrupt service routine
// with auto input scanning
interrupt [ADC_INT] void adc_isr(void)
{
static unsigned char input_index=0;
// Read the AD conversion result
adc_data[input_index]=ADCH;
// Select next ADC input
if (++input_index > (LAST_ADC_INPUT-FIRST_ADC_INPUT))
   input_index=0;
ADMUX=(FIRST_ADC_INPUT | (ADC_VREF_TYPE & 0xff))+input_index;
// Delay needed for the stabilization of the ADC input voltage

if (adc_data[0]==0xff&a==0) {TCCR0=0x0D;TCNT0=0x00;OCR0=0xD9;a=1;}  //dar in khat mokarrar check mikone bbine signale1 be peak reside ya na har vaght berese timer shoru mikone be shomordan ....
else if (adc_data[0]!=0xff&a==1) {a=2;} //inja check mishe ke bbinim in signal az peak kharej mishe ya na
else if (adc_data[0]==0xff&a==2)   // inja dobare check mishe ke dobare bbinim signale1 dobare be peak reside ya na ke dar in halat tedad afzayesh zamani dar in ta in moghe haman dore signal ast ke dar f zakhire mishavad. sepas timer az aval shoru be shomordan mikonad
{f=(TCNT0+(18*n+x)*217);TCCR0=0x0D;TCNT0=0x00;OCR0=0xD9;a=3;x=0;n=0;} 
// nesbate e be f ekhtelafe nesbi zamin ast ke ba zarb shodane in adad dar 360 ekhtelafe phase be dast miayad
else if (a==3&adc_data[1]==0xff)
{p=(TCNT0+(18*n+x)*217);TCCR0=0x00;a=4;} //dar in ja check mishe ke bbinim signale2 peak reside ya na. harvaght berese timer ghat mishe o tedade vahed zamane teyshode ke neshane ekhtelafe zamanie miane peak shodan ast ke dar inja dar p zakhire mishavad
else if(a==4) 
{ef=((360*p)/f)*1.029;lcd_init(16);lcd_clear();sprintf(str,"Phase= %d",ef);lcd_puts(str);a=5;} //ta inja hamechi bedast amade va az inja be bad bayad namayesh dade shavad

//PORTC=adc_data[1];
// Start the AD conversion

ADCSRA|=0x40;
}

// Declare your global variables here

void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;

// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0xff;

// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0xff;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0xff;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 3.906 kHz
// Mode: Normal top=0xFF
// OC0 output: Disconnected
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;


// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x01;

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
// ADC Voltage Reference: AVCC pin
// ADC Auto Trigger Source: ADC Stopped
ADMUX=FIRST_ADC_INPUT | (ADC_VREF_TYPE & 0xff);
ADCSRA=0xCA;

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
      // Place your code here

      }
}
