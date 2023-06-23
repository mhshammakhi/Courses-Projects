/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 05/06/2013
Author  : Mandegar
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
#include <stdlib.h>
#include <stdio.h>
#include <delay.h>

// Alphanumeric LCD functions
#include <alcd.h>
bit g1=1;
bit g2=0;
bit g3=0;
bit g4=0;
int key,t,tt,kr,kg,tr,tg,p;
int m=0;
char str[16];
// Timer 0 overflow interrupt service routine

interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
  m=m+1;
  if (m==18)
  {
    if (kg!=0)
        {m=0;
            if (g1==1 && g2==0 && g3==0 && g4==0)
            {
                kg=kg-1;t=t-1;p=p-1;kr=kr-1;
                sprintf(str,"%ds %ds %ds %ds",kg,t,p,kr);
                lcd_clear();
                lcd_gotoxy(0,0);
                lcd_puts(str);
                PORTD=0X00;PORTB=0X00;PORTA=0X00;
                PORTD.0=1;PORTD.5=1;PORTB.2=1;PORTB.5=1;
                PORTB.7=1;PORTD.6=1;PORTA.4=1;PORTA.6=1;
                g1=1;g2=0;g3=0;g4=0;
                    if (t==0)
                    {
                        t=tg;g1=1;g2=1;g3=0;g4=0;  
                    }
            }
            else if (g1==1 && g2==1 && g3==0 && g4==0)
            {
                kg=kg-1;t=t-1;p=p-1;kr=kr-1;
                sprintf(str,"%ds %ds %ds %ds",kg,t,p,kr);
                lcd_clear();
                lcd_gotoxy(0,0);
                lcd_puts(str);
                PORTD=0X00;PORTB=0X00;PORTA=0X00;
                PORTD.0=1;PORTD.3=1;PORTB.2=1;PORTB.5=1;
                PORTB.6=1;PORTD.6=1;PORTA.4=1;PORTA.6=1;
                g1=1;g2=1;g3=0;g4=0;
                    if (kg==0)
                    {
                        g1=0;g2=1;g3=0;g4=0;kg=tr;
                        PORTD=0X00;PORTB=0X00;PORTA=0X00;
                        PORTD.1=1;PORTD.3=1;PORTB.2=1;PORTB.5=1;
                        PORTB.6=1;PORTD.6=1;PORTA.4=1;PORTA.6=1;
                        delay_ms(1000);      
                    }                
            }
            else if (g1==0 && g2==1 && g3==0 && g4==0)
            {   
                kg=kg-1;t=t-1;p=p-1;kr=kr-1;
                sprintf(str,"%ds %ds %ds %ds",kg,t,p,kr);
                lcd_clear();
                lcd_gotoxy(0,0);
                lcd_puts(str);
                PORTD=0X00;PORTB=0X00;PORTA=0X00;
                PORTD.2=1;PORTD.3=1;PORTB.2=1;PORTB.5=1;
                PORTB.6=1;PORTD.7=1;PORTA.4=1;PORTA.6=1;
                g1=0;g2=1;g3=0;g4=0;
                    if (t==0)
                    {
                        g1=0;g2=0;g3=1;g4=0;t=tr;p=tg;
                        PORTD=0X00;PORTB=0X00;PORTA=0X00;
                        PORTD.2=1;PORTD.4=1;PORTB.2=1;PORTB.5=1;
                        PORTB.6=1;PORTD.6=1;PORTA.4=1;PORTA.6=1;
                        delay_ms(1000);    
                    }
            }
            else if (g1==0 && g2==0 && g3==1 && g4==0)
            {
                kg=kg-1;t=t-1;p=p-1;kr=kr-1;
                sprintf(str,"%ds %ds %ds %ds",kg,t,p,kr);
                lcd_clear();
                lcd_gotoxy(0,0);
                lcd_puts(str);
                PORTD=0X00;PORTB=0X00;PORTA=0X00;
                PORTD.2=1;PORTD.5=1;PORTB.2=1;PORTB.3=1;
                PORTB.6=1;PORTD.6=1;PORTA.5=1;PORTA.6=1;
                g1=0;g2=0;g3=1;g4=0;
                    if (kr==0)
                    {
                        g1=0;g2=0;g3=1;g4=1;kr=tg;    
                    }
            }
            else if (g1==0 && g2==0 && g3==1 && g4==1)
            {
                kg=kg-1;t=t-1;p=p-1;kr=kr-1;
                sprintf(str,"%ds %ds %ds %ds",kg,t,p,kr);
                lcd_clear();
                lcd_gotoxy(0,0);
                lcd_puts(str);
                PORTD=0X00;PORTB=0X00;PORTA=0X00;
                PORTD.2=1;PORTD.5=1;PORTB.0=1;PORTB.3=1;
                PORTB.6=1;PORTD.6=1;PORTA.4=1;PORTA.6=1;
                g1=0;g2=0;g3=1;g4=1;
                    if (p==0)
                    {
                        g1=0;g2=0;g3=0;g4=1;p=tr;
                        PORTD=0X00;PORTB=0X00;PORTA=0X00;
                        PORTD.2=1;PORTD.5=1;PORTB.0=1;PORTB.4=1;
                        PORTB.6=1;PORTD.6=1;PORTA.4=1;PORTA.6=1;
                        delay_ms(1000);    
                    }
            }
            else if (g1==0 && g2==0 && g3==0 && g4==1)
            {
                kg=kg-1;t=t-1;p=p-1;kr=kr-1;
                sprintf(str,"%ds %ds %ds %ds",kg,t,p,kr);
                lcd_clear();
                lcd_gotoxy(0,0);
                lcd_puts(str);
                PORTD=0X00;PORTB=0X00;PORTA=0X00;
                PORTD.2=1;PORTD.5=1;PORTB.0=1;PORTB.5=1;
                PORTB.6=1;PORTD.6=1;PORTA.4=1;PORTA.7=1;
                g1=0;g2=0;g3=0;g4=1;
                    if (kr==0)
                    {
                        g1=1;g2=0;g3=0;g4=0;kg=tg;kr=tr;
                        PORTD=0X00;PORTB=0X00;PORTA=0X00;
                        PORTD.2=1;PORTD.5=1;PORTB.1=1;PORTB.5=1;
                        PORTB.6=1;PORTD.6=1;PORTA.4=1;PORTA.6=1;
                        delay_ms(1000);    
                    }
            }              
        }
  } 
} 


#define ADC_VREF_TYPE 0x40

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

int i=0;
int a[3];
int n=0;


void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=In 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=T 
PORTA=0x00;
DDRA=0xFE;

// Port B initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTB=0x00;
DDRB=0xFF;

// Port C initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTC=0x00;
DDRC=0xFF;

// Port D initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTD=0x00;
DDRD=0xFF;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 3.906 kHz
// Mode: CTC top=OCR0
// OC0 output: Disconnected
TCCR0=0x00;
TCNT0=0x00;
OCR0=0xD9;

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
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0x82;

// SPI initialization
// SPI disabled
SPCR=0x00;

// TWI initialization
// TWI disabled
TWCR=0x00;

// Alphanumeric LCD initialization
// Connections are specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTC Bit 0
// RD - PORTC Bit 1
// EN - PORTC Bit 2
// D4 - PORTC Bit 4
// D5 - PORTC Bit 5
// D6 - PORTC Bit 6
// D7 - PORTC Bit 7
// Characters/line: 16
lcd_init(16);

// Global enable interrupts
#asm("sei")

while (1)
      {
        key=read_adc(0);

            if (key!=0)
            {   
                if (n==0)
                {
                    TCCR0=0x00;
                    lcd_clear();
                    lcd_gotoxy(0,0);
                }
                if (key==216)
                {
                    lcd_gotoxy(i,0);
                    lcd_puts("1");
                    delay_ms(300);i++;a[n]=1;n++;}
                if (key==410)
                {
                    lcd_gotoxy(i,0);
                    lcd_puts("2");
                    delay_ms(300);i++;a[n]=2;n++;}
                if (key==647)
                {
                    lcd_gotoxy(i,0);
                    lcd_puts("3");
                    delay_ms(300);i++;a[n]=3;n++;}
                if (key==205)
                {
                    lcd_gotoxy(i,0);
                    lcd_puts("4");
                    delay_ms(300);i++;a[n]=4;n++;}
                if (key==384)
                {
                    lcd_gotoxy(i,0);
                    lcd_puts("5");
                    delay_ms(300);i++;a[n]=5;n++;}
                if (key==614)
                {
                    lcd_gotoxy(i,0);
                    lcd_puts("6");
                    delay_ms(300);i++;a[n]=6;n++;}
                if(key==186)
                {
                    lcd_gotoxy(i,0);
                    lcd_puts("7");
                    delay_ms(300);i++;a[n]=7;n++;}
                if (key==341)
                {
                    lcd_gotoxy(i,0);
                    lcd_puts("8");
                    delay_ms(300);i++;a[n]=8;n++;}      
                if (key==558)
                {
                    lcd_gotoxy(i,0);
                    lcd_puts("9");
                    delay_ms(300);i++;a[n]=9;n++;}
                if (key==256)
                {
                    lcd_gotoxy(i,0);
                    lcd_puts("0");
                    delay_ms(300);i++;a[n]=0;n++;}
                if (key==146)
                {
                    if (n==3)
                        kr=100*a[0]+10*a[1]+a[2];
                    else if (n==2)
                        kr=10*a[0]+a[1];
                    else if (n==1)
                        kr=a[0];
                    tr=kr;
                    n=0;i=0;
                    lcd_clear();
                    lcd_gotoxy(0,0);
                }
                if (key==439)
                {
                    if (n==3)
                        kg=100*a[0]+10*a[1]+a[2];
                    else if (n==2)
                        kg=10*a[0]+a[1];
                    else if (n==1)
                        kg=a[0];
                    tg=kg;
                    t=(kr-kg)/2;tt=t;p=kr-t;
                    n=0;i=0;
                    lcd_clear();
                    lcd_gotoxy(0,0);                    
                    TCCR0=0x0D;
                }
            }

      }
}
