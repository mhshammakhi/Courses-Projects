/*****************************************************
This program was produced by the
CodeWizardAVR V2.04.4a Advanced
Automatic Program Generator
© Copyright 1998-2009 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : Saate alarmdar
Version : 1.0.00
Date    : 5/17/2013
Author  : mohammad hasan shammakhi
Company : MHSHAH
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/

#include <mega16.h>
#include <delay.h>
#include <stdio.h>
#include <stdlib.h>

// I2C Bus functions
#asm
   .equ __i2c_port=0x15 ;PORTC
   .equ __sda_bit=3
   .equ __scl_bit=4
#endasm
#include <i2c.h>
#include <ds1307.h>
#asm
   .equ __lcd_port=0x12 ;PORTD
#endasm
#include <lcd.h>

// Declare your global variables here
unsigned char zm=0,zh=0,h=0,m=0,s=0,y=0,w=0,mo=0,d=0,t[14],l[14],zmo[14];
int alarm=0,k=0;
void main(void)
{
// Declare your local variables here

PORTA=0x00;
DDRA=0x00;

PORTB=0x00;
DDRB=0x00;

PORTC=0x00;
DDRC=0x01;

PORTD=0x00;
DDRD=0x00;


// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;

// I2C Bus initialization
i2c_init();

// DS1307 Real Time Clock initialization
// Square wave output on pin SQW/OUT: On
// Square wave frequency: 1Hz
rtc_init(0,0,0);
i2c_start();
rtc_set_time(0,0,0);
rtc_set_date(0,0,5,10);
// LCD module initialization
lcd_init(16);

while (1)
      {
         
      if(PINA.0==1)
       {
       m++;
       if (m==60)
       m=0;
       rtc_set_time(h,m,s);
       }
      
      else if(PINA.1==1)      
       {
       h++;
       if (h==24)
       h=0;
       rtc_set_time(h,m,s);
       
       }
      else if(PINA.4==1)
      rtc_set_date(w,d+1,mo,y);
      else if(PINA.5==1)
      rtc_set_date(w,d,mo+1,y);      
      else if(PINA.6==1)
      rtc_set_date(w,d,mo,y+1);
            
         
      if (PINB.0==1)
      k++;
      while (0<k & k<5)
        {
        lcd_clear();
        
            if(k==1)
            {
            sprintf(zmo,"  :%02d:00",zm);
            lcd_gotoxy(0,0);
            lcd_puts(zmo);
            if (PINB.1==1)
            zm++;
              if(zm==60)
              zm=0;
            }
            else if(k==2)
            {
            sprintf(zmo,"%02d:  :  ",zh);
            lcd_gotoxy(0,0);
            lcd_puts(zmo);
            if (PINB.1==1)
            zh++;
              if(zh==24)
              zh=0;
            }
            else if(k==3)
            {
            alarm=1;
            k=0;
            }
            
        delay_ms(150);
        if (PINB.0==1)
        k++;
        }
     
      rtc_get_time(&h,&m,&s);
      rtc_get_date(&w,&d,&mo,&y);
      if (alarm==1 & m==zm & h==zh & s==0)
      alarm=2;        
      if (alarm==2 & m==(zm+1) & h==zh & s==0)
      alarm=1;
      sprintf(t,"time:%02d:%02d:%02d",h,m,s);
      sprintf(l,"date:20%02d:%02d:%02d",y,mo,d);
      lcd_clear();
      lcd_gotoxy(0,0);
      lcd_puts(t);
      lcd_gotoxy(0,1);
      lcd_puts(l); 
      delay_ms(150);
   
      };          
}
