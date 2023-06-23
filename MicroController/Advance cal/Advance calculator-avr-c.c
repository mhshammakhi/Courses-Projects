/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 02/03/2012
Author  : Amir hossein Ebrahimi
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
#include <alcd.h>
#include <stdio.h>
#include <math.h>

    char char_sin[]="Sin",char_cos[]="Cos",char_tan[]="Tan";
    char char_asin[]="Sin-1",char_acos[]="Cos-1",char_atan[]="Tan-1";
    char char_log[]="Log",char_alog[]="Log-1";
    char shift=0,op,last_op,dis,buffer[40];
    bit sh=0;
    float ans,a,b;
    eeprom float M;
        
#include <keypad.h>
#include <inputNum.h>
    
//--------------------------
    char ma_error[]="Ma ERROR";
//--------------------------

 void display1 (){
    lcd_clear();
    sprintf(buffer,"%f\n%f",a,ans);
    lcd_puts(buffer);
    dis=1;
 }
  
 void display2 (){
    op=last_op;
    lcd_clear();
    sprintf(buffer,"%.3f%c%.3f\n%f",a,op,b,ans);
    lcd_puts(buffer);
    dis=1;
 }
 
  void display3 (unsigned char sign_char){
    lcd_clear();
    lcd_write_byte(0x80,sign_char);
    sprintf(buffer,"%f\n%f",a,ans);
    lcd_puts(buffer);
    dis=1;
  }
  
  void display_advance (char sign_char[]){
    lcd_clear();
    sprintf(buffer,"%s %f\n%f",sign_char,a,ans);
    lcd_puts(buffer);
    dis=1;
  }
 
 void display4 (float m){
    lcd_clear();
    sprintf(buffer,"MEMORY\nM=%f",m);
    lcd_puts(buffer);
    dis=1;
 } 
 
 float deg2rad(){
    float tmp;
   tmp=(a*3.141592654)/180;
   return tmp;
 }
 
 float rad2deg(){
    float tmp;
   tmp=(ans*180)/3.141592654;
   return tmp;
 }
 
  void calculat_xy(){
  b=input_digit();   
  ans=pow(a,b);
  //op='^';
  display2();
 }
  
 void equal(){
    switch(shift){
        case '1':
        ans=sin(deg2rad());
        display_advance(char_sin);
        break;
                                    
        case '2':
        ans=cos(deg2rad());
        display_advance(char_cos);
        break;
                                    
        case '3': 
        ans=tan(deg2rad());
        display_advance(char_tan);
        break;
        
        case '4': 
        ans=asin(a);
        ans=rad2deg();
        display_advance(char_asin);
        break;
        
        case '5': 
        ans=acos(a);
        ans=rad2deg();
        display_advance(char_acos);
        break;
        
        case '6': 
        ans=atan(a);
        ans=rad2deg();
        display_advance(char_atan);
        break;
        
        case '7': 
        ans=log10(a);
        display_advance(char_log);
        break;
        
        case '8': 
        ans=pow(10,a);
        display_advance(char_alog);
        break;
        
        default:
        shift='';
        ans=a;
        display1();
        break;
    }
   
   
 }
 
  void may_error(){
      lcd_clear();
      lcd_gotoxy(6,0);
      lcd_puts(ma_error);
      dis=1;
  }
 
 void clear_var(){
    ans=a=b=op=last_op=sh=0;
    lcd_clear();
    lcd_gotoxy(19,1);
    lcd_putchar('0');
    lcd_gotoxy(0,0);
    _lcd_write_data(0x0f);
 } 
 
 void calculat_add(){
  b=input_digit();
  ans=a+b; 
  display2();
 }  

 void calculat_min(){
  b=input_digit();
  ans=a-b;
  display2();
 } 
 
  void calculat_mul(){
  b=input_digit();   
  ans=a*b;
  display2();
 }
 
  void calculat_div(){
  b=input_digit();
    if(b==0){
        may_error();
    }else{
     ans=a/b;
     display2();
   }
 }
 
  void calculat_squ(){   
  if(a<0){
    may_error();
   }else{
    ans=sqrt(a);
    display3(0xE8); //E8 on datasheet LCD is code signe square 
   }
 } 
 
 
 void calculat_percent(){
   b=input_digit();
   ans=(b/100)*a;
   display2();
 }


    void main(void){
        lcd_init(20); 
        clear_var(); 
        
        while (1){
            a=input_digit();
            last_op=op;
            
             switch(op){
               case '=': 
               equal();
               break;
               
               case 'c': 
               clear_var();
               break;
               
               case '+': 
               calculat_add();
               break;
               
               case '-': 
               calculat_min();
               break;
               
               case '*': 
               calculat_mul();
               break;
               
               case '/': 
               calculat_div();
               break;
               
               case 's': //square
               calculat_squ();
               break;
               
               case 'i': //increment memory
                M+=ans;
                ans=M;
                display4(M);
                break;
               
               case 'd': //decrement memory
                M-=ans;
                ans=M;
                display4(M);
                break;
               
               case 'm': //show memory
                M=0;
                display4(M);
                break;
               
               case '%': //percent
               calculat_percent();
               break;
               
               case '^':
               calculat_xy();
               break;   
             }
             op=0;
        }
    }
