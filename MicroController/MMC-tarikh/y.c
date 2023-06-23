/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 6/11/2013
Author  : PerTic@n
Company : hadi
Comments: 


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 1.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*****************************************************/

#include <mega32.h>

#include <delay.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#asm
.equ __i2c_port=0x18  //address PORTB 
.equ __sda_bit=5
.equ __scl_bit=4
#endasm

// Alphanumeric LCD functions
#include <alcd.h>
unsigned char sec , dag , hour,day ,month,a,s,d,f,t,q,h,z;
unsigned int year,x,j; 
int count=0 ; 
char str2[20]; 
bit chang=0 ;


int i;          
char String[20];


int adc1,tempreture;
       float v_sensor;
          char sig[5];

 #define ADC_VREF_TYPE 0xc0
// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input|ADC_VREF_TYPE;
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete /R.S/
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}


#include <i2c.h>

#define EEPROM_BUS_ADDRESS 0XA0

/* function eeprom_read for read 
a byte from the external eeprom*/
unsigned char eeprom_read(unsigned char address)
 {
 unsigned char data;
 i2c_start();
 i2c_write(EEPROM_BUS_ADDRESS);
 i2c_write(address);
 i2c_start();
 i2c_write(EEPROM_BUS_ADDRESS | 1);
 data=i2c_read(0);
 i2c_stop();
 return data;
 }
 
/* function eeprom_write for writ 
a byte to the external eeprom*/
unsigned char eeprom_write(unsigned char address,unsigned char data)
 {
 i2c_start();
 i2c_write(EEPROM_BUS_ADDRESS);
 i2c_write(address);
 i2c_write(data);
 i2c_stop();
 delay_ms(20);   // 10 ms delay to complete the write opertion
 } 

char not_leap(void)
{
  if(!(year%100))
   return (char)(year%400); 
  else
   return (char)(year%4);
}

// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
count++ ;
if (count>=61)
        {
        sec ++ ;
        if (sec==60)
                {
                dag ++ ;
                sec=0 ;
                }
        if (dag==60)
                {
                hour ++ ;
                dag=0 ;
                }
        if (hour==24)
                {
                day ++;
                hour=0;
                }
         if (day==32)
                {
                month ++;
                day=1;
                }
        else if (day==31)
                {
                   if((month==4) || (month==6) || (month ==9) || (month==11))
                    {month ++;
                     day=1;}

                 }
       else if (day==30)
                {if(month==2)
                  {month ++;
                   day=1;
                   }
                }
       else if(day==29)
                   {if((month==2) && (not_leap()))
                     {month ++;
                      day=1;
                      }
                    }
       if(month==13)
           {month=1;
            year++;
           }
         
        count=0;
        lcd_clear();
        sprintf(str2,"date %04u:%02u:%02u",year,month,day);
        lcd_gotoxy(0,0);
        lcd_puts(str2);
        }


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
DDRB=0xB8;

// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x00;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=P State6=P State5=P State4=P State3=P State2=P State1=P State0=P 
PORTD=0xFF;
DDRD=0x00;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 15.625 kHz
// Mode: Normal top=0xFF
// OC0 output: Disconnected
TCCR0=0x03;
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
TIMSK=0x01;

// USART initialization
// USART disabled
UCSRB=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
// Analog Comparator Output: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC Clock frequency: 62.500 kHz
// ADC Voltage Reference: Int., cap. on AREF
ADMUX=ADC_VREF_TYPE;
ADCSRA=0x87;

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

lcd_putsf("be name khoda");
delay_ms(2000);
lcd_clear();
sprintf(str2,"date %04u:%02u:%02u",year,month,day);
lcd_gotoxy(0,0);
lcd_puts(str2);

     

 

i2c_init();
// Global enable interrupts
#asm("sei")

while (1)
      {
       
        if (PIND.0==1)
        {
        chang=1;
        }       
      if (PIND.1==1)
        {
        chang=0; 
        TIMSK=0x01; //Timer/Counter(0) Interrupt = on  
        }
      if (chang==1)
        { 
        lcd_clear();
        sprintf(str2,"date %04u:%02u:%02u",year,month,day);
        lcd_gotoxy(0,0);
        lcd_puts(str2);
        delay_ms(100);  
        
        TIMSK=0x00;  //Timer/Counter(0) Interrupt = off   

        if (PIND.4==1)
                {
                day ++ ;
                delay_ms(150);
                if (day==32)
                        {
                        day=1;
                        }
                }
        if (PIND.5==1)
                {
                month ++ ;
                delay_ms(150);
                if (month==13)
                        {
                        month=1;
                        }

                 }
        if (PIND.6==1)
                {
                year ++ ;
                delay_ms(150);
                }
        if (PIND.7==1)
              {
              year=year+100;
              delay_ms(150);               
              }
        }
       
          if (PIND.2==1)
              {
             lcd_clear();  
             lcd_gotoxy(0,1);

  
      
   
              adc1=read_adc(1);          //read adc value
       v_sensor=adc1*(2.55/1024); //converts adc to sensor voltage
       tempreture=v_sensor*100;   //converts sensor voltage to tempreature /R.S/
       x=year;
       x>>=8;
       t=x;

      eeprom_write(0,year); 
      eeprom_write(1,month); 
      eeprom_write(2,day); 
      eeprom_write(3,tempreture); 
      eeprom_write(4,t);
      
       z=eeprom_read(0);
        s=eeprom_read(1);
         d=eeprom_read(2);
          f=eeprom_read(3);
          h=eeprom_read(4); 
          j=h;
          j<<=8;
          j|=z;
          
          
          
           sprintf(String,"%04u:%02u:%02u %02u",j,s,d,f);
           lcd_puts(String);
     delay_ms(200); 


     }
         
           
     
                    if (PIND.3==1)
                {

                
         lcd_clear();
        lcd_gotoxy(0,1);



       
       adc1=read_adc(1);          //read adc value
       v_sensor=adc1*(2.55/1024); //converts adc to sensor voltage
       tempreture=v_sensor*100;   //converts sensor voltage to tempreature /R.S/
       
       
       itoa(tempreture,sig);  //get ASCII code of tempreture variable in order to display on lcd
       lcd_putsf("Temp:     \xdfC ");
       lcd_gotoxy(6,1);
       lcd_puts(sig);
       delay_ms(2000);
       lcd_clear();
    
           }
      }
}
