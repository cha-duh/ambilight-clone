/******************** (C) COPYRIGHT 2012 RadioSHack ********************
 * File Name          : strip.pde
 * Author             : TRS
 * Version            : V1.0
 * Date               : 27/04/2012
 * Description        : Main program body
 ********************************************************************************
 * THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
 * AS A RESULT, RS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
 * INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
 * CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
 * INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
 *******************************************************************************/

#include <avr/pgmspace.h>

// ******** DEBUG ==== should auto config to adapt different mother board *********
//#define DATA_1 (PORTF |=  0X01)    // DATA 1    // for ATMEGA
//#define DATA_0 (PORTF &=  0XFE)    // DATA 0    // for ATMEGA
//#define STRIP_PINOUT DDRF=0xFF  // for ATMEGA
#define DATA_1 (PORTC |=  0X01)    // DATA 1    // for UNO
#define DATA_0 (PORTC &=  0XFE)    // DATA 0    // for UNO
#define STRIP_PINOUT (DDRC=0xFF)    // for UNO
#define numBufSize 6

unsigned char r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, g0, g1, g2, g3, g4, g5, g6,
  g7, g8, g9, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, r10, r11, r12, r13, r14, r15, 
  r16, r17, r18, r19, g10, g11, g12, g13, g14, g15, g16, g17, g18, g19, b10, b11,
  b12, b13, b14, b15, b16, b17, b18, b19;

unsigned long color0, color1, color2, color3, color4, color5, color6, color7,
  color8, color9, color10, color11, color12, color13, color14, color15, color16, color17,
  color18, color19;

// ***********************************************************************************************************
// *
// *                            Power Up Init.
// *
// *
// ***********************************************************************************************************
void setup() {           

  Serial.begin(115200);  

  STRIP_PINOUT;        // set output pin - DEBUG: should auto detect which mother board for use

  reset_strip();
  //noInterrupts();

}



// ***********************************************************************************************************
// *
// *                            Main Loop 
// *
// *
// ***********************************************************************************************************
void loop() 
{
  interrupts();
  if (Serial.available()>=61) {
    if(Serial.read() == 0xff){
      r0  = Serial.read();
      g0  = Serial.read();
      b0  = Serial.read();
      r1  = Serial.read();
      g1  = Serial.read();
      b1  = Serial.read();
      r2  = Serial.read();
      g2  = Serial.read();
      b2  = Serial.read();
      r3  = Serial.read();
      g3  = Serial.read();
      b3  = Serial.read();
      r4  = Serial.read();
      g4  = Serial.read();
      b4  = Serial.read();
      r5  = Serial.read();
      g5  = Serial.read();
      b5  = Serial.read();
      r6  = Serial.read();
      g6  = Serial.read();
      b6  = Serial.read();
      r7  = Serial.read();
      g7  = Serial.read();
      b7  = Serial.read();
      r8  = Serial.read();
      g8  = Serial.read();
      b8  = Serial.read();
      r9  = Serial.read();
      g9  = Serial.read();
      b9  = Serial.read();
      r10 = Serial.read();
      g10 = Serial.read();
      b10 = Serial.read();
      r11 = Serial.read();
      g11 = Serial.read();
      b11 = Serial.read();
      r12 = Serial.read();
      g12 = Serial.read();
      b12 = Serial.read();
      r13 = Serial.read();
      g13 = Serial.read();
      b13 = Serial.read();
      r14 = Serial.read();
      g14 = Serial.read();
      b14 = Serial.read();
      r15 = Serial.read();
      g15 = Serial.read();
      b15 = Serial.read();
      r16 = Serial.read();
      g16 = Serial.read();
      b16 = Serial.read();
      r17 = Serial.read();
      g17 = Serial.read();
      b17 = Serial.read();
      r18 = Serial.read();
      g18 = Serial.read();
      b18 = Serial.read();
      r19 = Serial.read();
      g19 = Serial.read();
      b19 = Serial.read();
    }
  }
  delay(20);
  color0 = (g0*65536)+(b0*256)+r0;
  color1 = (g1*65536)+(b1*256)+r1;
  color2 = (g2*65536)+(b2*256)+r2;
  color3 = (g3*65536)+(b3*256)+r3;
  color4 = (g4*65536)+(b4*256)+r4;
  color5 = (g5*65536)+(b5*256)+r5;
  color6 = (g6*65536)+(b6*256)+r6;
  color7 = (g7*65536)+(b7*256)+r7;
  color8 = (g8*65536)+(b8*256)+r8;
  color9 = (g9*65536)+(b9*256)+r9;
  color10 = (g10*65536)+(b10*256)+r10;
  color11 = (g11*65536)+(b11*256)+r11;
  color12 = (g12*65536)+(b12*256)+r12;
  color13 = (g13*65536)+(b13*256)+r13;
  color14 = (g14*65536)+(b14*256)+r14;
  color15 = (g15*65536)+(b15*256)+r15;
  color16 = (g16*65536)+(b16*256)+r16;
  color17 = (g17*65536)+(b17*256)+r17;
  color18 = (g18*65536)+(b18*256)+r18;
  color19 = (g19*65536)+(b19*256)+r19;
        
  noInterrupts();
  send_strip(color0);
  send_strip(color1);
  send_strip(color2);
  send_strip(color3);
  send_strip(color4);
  send_strip(color5);
  send_strip(color6);
  send_strip(color7);
  send_strip(color8);
  send_strip(color9);
  send_strip(color10);
  send_strip(color11);
  send_strip(color12);
  send_strip(color13);
  send_strip(color14);
  send_strip(color15);
  send_strip(color16);
  send_strip(color17);
  send_strip(color18);
  send_strip(color19);
}




/*******************************************************************************
 * Function Name  : send_1M_pattern
 * Description    : Transmit pattern to whole 1 meter strip
 *                  
 * Input          : pointer to ROM pattern; pattern length; frame rate
 *                  
 * Output         : None
 * Return         : None
 *******************************************************************************/
void send_1M_pattern(unsigned long data, int pattern_no, int frame_rate)
{
  int i=0;
  int j=0;
  uint32_t temp_data;

  for (i=0;i<pattern_no;i++)
  {
    noInterrupts();
    for (j=0;j<10;j++)
    {
      temp_data=pgm_read_dword_near(&data);
      send_strip(temp_data);
    }
    interrupts();

    delay(frame_rate);

  }




}


/*******************************************************************************
 * Function Name  : send_strip
 * Description    : Transmit 24 pulse to LED strip
 *                  
 * Input          : 24-bit data for the strip
 *                  
 * Output         : None
 * Return         : None
 *******************************************************************************/
void send_strip(uint32_t data)
{
  int i;
  unsigned long j=0x800000;
  
 
  for (i=0;i<25;i++)
  {
    if (data & j)
    {
           DATA_1;
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");    
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      DATA_0;
    }
    else
    {
      DATA_1;
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");
      __asm__("nop\n\t");    
      DATA_0;
    }


    j>>=1;
  }


  
}

/*******************************************************************************
 * Function Name  : reset_strip
 * Description    : Send reset pulse to reset all color of the strip
 *                  
 * Input          : None
 *                  
 * Output         : None
 * Return         : None
 *******************************************************************************/
void	reset_strip()
{
  DATA_0;
  delayMicroseconds(20);
}











