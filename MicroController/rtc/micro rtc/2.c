/*****************************************************
Project :Clock
Author : mh sha
Company : Pishro Noavaran Kavosh
*****************************************************/
#include <mega16.h>
#include <lcd.h>
#include <stdio.h>
#asm
.equ __lcd_port=0x1B ;PORTA
#endasm
unsigned char second, minute,hour;
unsigned char lcd_buff[10];
interrupt [TIM2_OVF] void timer2_ovf_isr(void)
  {
    if(second==59)
    {
    second=0;
     if(minute==59)
     {
     minute=0;
      if(hour==23)
      hour=0;
     else
     hour++;
     }
    else
    minute++;
    }
    else
    second++;
    sprintf(lcd_buff,"Time = %02d:%02d:%02d",hour, minute,second);
    lcd_clear();
    lcd_puts(lcd_buff);
    }
void main(void)
{
// Clock source: TOSC1 pin
// Clock value: PCK2/128
// Mode: Normal top=FFh
// OC2 output: Disconnected
ASSR=0x08;
TCCR2=0x05;
TCNT2=0x00;
OCR2=0x00;
// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x40;
lcd_init(16);
#asm("sei") // Global enable interrupts
}