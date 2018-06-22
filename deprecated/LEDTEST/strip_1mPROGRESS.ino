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
unsigned char leftRed, centerRed, rightRed, leftGreen, centerGreen, rightGreen,
  leftBlue, centerBlue, rightBlue;
unsigned long rightColor, rcColor, centerColor, lcColor, leftColor;

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
  if (Serial.available()>=4) {
    if(Serial.read() == 0xff){
      //red = Serial.read();
      //green= Serial.read();
      //blue = Serial.read();
      leftRed = Serial.read();
      leftGreen = Serial.read();
      leftBlue = Serial.read();
    }
    if (Serial.read() == 0xff){
      centerRed = Serial.read();
      centerGreen = Serial.read();
      centerBlue = Serial.read();
    }
    if (Serial.read() == 0xff){
      rightRed = Serial.read();
      rightGreen = Serial.read();
      rightBlue = Serial.read();
    }
  }
  delay(2);
  rightColor = (rightGreen*65536)+(rightBlue*256)+rightRed;
  rcColor = ((((rightGreen + centerGreen)/2)*65536)+
        (((rightBlue + centerBlue)/2)*256)+(rightRed+centerRed)/2);
  centerColor = (centerGreen*65536)+(centerBlue*256)+centerRed;
  lcColor = ((((leftGreen + centerGreen)/2)*65536)+
        (((leftBlue + centerBlue)/2)*256)+(leftRed+centerRed)/2);
  leftColor = (leftGreen*65536)+(leftBlue*256)+leftRed;
  noInterrupts();
  send_strip(leftColor);
  send_strip(leftColor);
  send_strip(lcColor);
  send_strip(centerColor);
  send_strip(centerColor);
  send_strip(centerColor);
  send_strip(centerColor);
  send_strip(rcColor);
  send_strip(rightColor);
  send_strip(rightColor);
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











