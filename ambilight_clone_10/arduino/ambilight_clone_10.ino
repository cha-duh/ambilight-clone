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
  g7, g8, g9, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9;
unsigned long color0, color1, color2, color3, color4, color5, color6, color7,
  color8, color9;

// ***********************************************************************************************************
// *
// *                            Power Up Init.
// *
// *
// ***********************************************************************************************************
void setup() {           

  Serial.begin(9600);  

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
  if (Serial.available()>=40) {
    if(Serial.read() == 0xff){
      //red = Serial.read();
      //green= Serial.read();
      //blue = Serial.read();
      r0 = Serial.read();
      g0 = Serial.read();
      b0 = Serial.read();
    }
    if (Serial.read() == 0xff){
      r1 = Serial.read();
      g1 = Serial.read();
      b1 = Serial.read();
    }
    if (Serial.read() == 0xff){
      r2 = Serial.read();
      g2 = Serial.read();
      b2 = Serial.read();
    }
    if(Serial.read() == 0xff){
      //red = Serial.read();
      //green= Serial.read();
      //blue = Serial.read();
      r3 = Serial.read();
      g3 = Serial.read();
      b3 = Serial.read();
    }
    if (Serial.read() == 0xff){
      r4 = Serial.read();
      g4 = Serial.read();
      b4 = Serial.read();
    }
    if (Serial.read() == 0xff){
      r5 = Serial.read();
      g5 = Serial.read();
      b5 = Serial.read();
    }
    if(Serial.read() == 0xff){
      //red = Serial.read();
      //green= Serial.read();
      //blue = Serial.read();
      r6 = Serial.read();
      g6 = Serial.read();
      b6 = Serial.read();
    }
    if (Serial.read() == 0xff){
      r7 = Serial.read();
      g7 = Serial.read();
      b7 = Serial.read();
    }
    if (Serial.read() == 0xff){
      r8 = Serial.read();
      g8 = Serial.read();
      b8 = Serial.read();
    }
    if (Serial.read() == 0xff){
      r9 = Serial.read();
      g9 = Serial.read();
      b9 = Serial.read();
    }
  }
  delay(2);
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
  
 
  for (i=0;i<24;i++)
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











