//<<<<<> Author: Jaber Alvandi <<<<>>>> Book: Microcontrollers AVR  
//>>>>>>>>>>>>>>>>>>>>> www.mcs-51a.blogfa.com <<<<<<<<<<<<<<<<
#include <mega16.h>  
#include <delay.h>
#asm                   
   .equ __lcd_port=0x1B ;// PORTA
#endasm
#include <lcd.h>
#define c1 PINB.4
#define c2 PINB.5
#define c3 PINB.6
#define c4 PINB.7
flash char row[]={0xfe,0xfd,0xfb,0xf7};
flash char data_key[]={
'1','2','3','A',
'4','5','6','B',
'7','8','9','C',
'*','0','#','D'};
unsigned char ac,table;
unsigned int r;
//________________________________________
void keypad(){    
lcd_gotoxy(0,1);
lcd_putsf("~");    
while (1){
 for (r=0;r<4;r++){
   ac=4;
   PORTB=row[r];
   DDRB=0x0f;   
   if (c1==0)  ac=0; 
   if (c2==0)  ac=1;  
   if (c3==0)  ac=2;    
   if (c4==0)  ac=3; 
   if (!(ac==4)){            
   table=data_key[(r*4)+ac]; 
   lcd_putchar(table);   
   while (c1==0){} 
   while (c2==0){} 
   while (c3==0){} 
   while (c4==0){} 
   delay_ms(50);                          
    }
  }
 }
}
//_________________________________________
void main(){  
PORTB=0xff;
DDRB=0x0f;
lcd_init(16);
lcd_gotoxy(0,0);
lcd_putsf("test keypad");  
keypad(); 
while(1){ 
 };
}