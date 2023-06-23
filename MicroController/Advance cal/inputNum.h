/*****************************************************
Header  : INPUT NUMBER FROM KEYPAD
Version : 1.1
Date    : 03/03/2012 1390/12/13
Author  : Amir hossein Ebrahimi
Company : 
Comments:
             
          
 EXP: a=input_digit();         
*****************************************************/
 
 void lcd_space(){
  lcd_puts(" ");
 }
 
 float input_digit(){
   
   char key;
   unsigned char k,count,count2,i,t,indigt[10];
   unsigned char neg=0,ashar=0;
   unsigned long int zarib[9]={1,10,100,1000,10000,100000,1000000,10000000,100000000};
   float n,n2=0;
   if(op) lcd_putchar(op); //display op on lcd

 lable:
    op=count=count2=t=n=0;
         
      while(!op){
        key=keypad();
              if(dis){
                lcd_clear();
                sprintf(buffer,"\n%f",ans);
                lcd_puts(buffer);
                lcd_gotoxy(0,0);
                _lcd_write_data(0x0f);
                dis=0;
              }
        
        if((key=='0')||(key=='1')||(key=='2')||(key=='3')||(key=='4')||(key=='5')||(key=='6')||(key=='7')||(key=='8')||(key=='9')){
           if(count<9){ //max input  
                    if(sh==1){
                     shift=key;
                     if(shift != '9') lcd_clear();
                        switch(key){
                            case '1': 
                            lcd_puts(char_sin);
                            lcd_space();
                            break;
                            
                            case '2': 
                            lcd_puts(char_cos);
                            lcd_space();
                            break;
                            
                            case '3': 
                            lcd_puts(char_tan);
                            lcd_space();
                            break;
                            
                            case '4': 
                            lcd_puts(char_asin);
                            lcd_space();
                            break;
                            
                            case '5': 
                            lcd_puts(char_acos);
                            lcd_space();
                            break;
                            
                            case '6': 
                            lcd_puts(char_atan);
                            lcd_space();
                            break;
                            
                            case '7': 
                            lcd_puts(char_log);
                            lcd_space();
                            break;
                            
                            case '8': 
                            lcd_puts(char_alog);
                            lcd_space();
                            break;
                            
                            case '9': 
                            op='^';
                            shift='';
                            sh=0;
                            goto Esc;
                            break;
                        }

                       sh=0;
                       goto lable;
                    }
            lcd_putchar(key);
            k=key&0x0f; //change ascii to integer
            indigt[count]=k;
            count++;
            count2=count;
           }
           
         }else{
           op=key;
         }
         
      Esc:
         
         if(op=='n'){ //negative namber in and op=0
          op=0;
          neg=1;
          lcd_putchar('-');       
         }
         
         if(op=='.'){
          if(!ashar) lcd_putchar('.');
          ashar=1; //ashar darim
         }
      }
       
        if(count){   
          count-=1;
          t=count;
        } 
        
        for(i=0; i<=t; i++){ //change arry to integer
          n+=indigt[i]*zarib[count];
          count--;
        }
        
        if(ashar==1){ //integer copy to n2 & ashar2 & goto
         ashar=2;
         n2=n;
         goto lable;
         }
         
        if(ashar==2){
         n/=zarib[i];
         n+=n2;
        } 
        
        if(neg){ //negative number
          neg=0;
          n*=-1;
        }
        
        if(count2==0){ //if first press one of OPs
            n=ans;
            lcd_putsf("Ans");
        }
  return n;         
 }

