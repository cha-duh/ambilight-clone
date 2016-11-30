//Developed by Rajarshi Roy
import java.awt.Robot; //java library that lets us take screenshots
import java.awt.AWTException;
import java.awt.event.InputEvent;
import java.awt.image.BufferedImage;
import java.awt.Rectangle;
import java.awt.Dimension;
import processing.serial.*; //library for serial communication


Serial port; //creates object "port" of serial class
Robot robby; //creates object "robby" of robot class
int ALPHAFACTOR = 3;

void setup()
{
  println(Serial.list());
  port = new Serial(this, Serial.list()[1], 9600); //set baud rate
  size(100, 100); //window size (doesn't matter)
  try //standard Robot class error check
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Robot class not supported by your system!");
    exit();
  }
}

void draw()
{
  int Lpixel, Cpixel, Rpixel; //ARGB variable with 32 int bytes where
  //sets of 8 bytes are: Alpha, Red, Green, Blue
  float rL=0;
  float gL=0;
  float bL=0;
  float rC=0;
  float gC=0;
  float bC=0;
  float rR=0;
  float gR=0;
  float bR=0;

  //get screenshot into object "screenshot" of class BufferedImage
  BufferedImage screenshot = robby.createScreenCapture(new Rectangle(new Dimension(1368, 928)));
  //1368*928 is the screen resolution


  int i=0;
  int j=0;
  //1368*928
  //I skip every alternate pixel making my program 4 times faster
  for (i =0;i<3*displayWidth/10; i=i+2) {
    for (j=0; j<displayHeight;j=j+2) {
      Lpixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      rL = rL+(int)(255&(Lpixel>>16)); //add up reds
      gL = gL+(int)(255&(Lpixel>>8)); //add up greens
      bL = bL+(int)(255&(Lpixel)); //add up blues
    }
  }

  for (i =3*displayWidth/10;i<7*displayWidth/10; i=i+2) {
    for (j=0; j<displayHeight;j=j+2) {
      Cpixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      rC = rC+(int)(255&(Cpixel>>16)); //add up reds
      gC = gC+(int)(255&(Cpixel>>8)); //add up greens
      bC = bC+(int)(255&(Cpixel)); //add up blues
    }
  }

  for (i=7*displayWidth/10;i<displayWidth; i=i+2) {
    for (j=0; j<displayHeight;j=j+2) {
      Rpixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      rR = rR+(int)(255&(Rpixel>>16)); //add up reds
      gR = gR+(int)(255&(Rpixel>>8)); //add up greens
      bR = bR+(int)(255&(Rpixel)); //add up blues
    }
  }

  //Average on left
  rL=rL/((displayWidth/2*displayHeight/2)/ALPHAFACTOR); //average red (remember that I skipped ever alternate pixel)
  gL=gL/(((displayWidth/2*displayHeight/2)/ALPHAFACTOR)); //average green
  bL=bL/(((displayWidth/2*displayHeight/2)/ALPHAFACTOR)); //average blue

  //Average at center
  rC=rC/(((displayWidth/2*displayHeight/2)/ALPHAFACTOR)); //average red (remember that I skipped ever alternate pixel)
  gC=gC/(((displayWidth/2*displayHeight/2)/ALPHAFACTOR)); //average green
  bC=bC/(((displayWidth/2*displayHeight/2)/ALPHAFACTOR)); //average blue

  //Average on right
  rR=rR/(((displayWidth/2*displayHeight/2)/ALPHAFACTOR)); //average red (remember that I skipped ever alternate pixel)
  gR=gR/(((displayWidth/2*displayHeight/2)/ALPHAFACTOR)); //average green
  bR=bR/(((displayWidth/2*displayHeight/2)/ALPHAFACTOR)); //average blue

  //String allLeft = "0xFF" + hex((byte)rL) + hex((byte)gL) + hex((byte)bL); 
  //String allCenter = "0xFF" + hex((byte)rC) + hex((byte)gC) + hex((byte)bC);
  //String allRight = "0xFF" + hex((byte)rR) + hex((byte)gR) + hex((byte)bR);
  //String LCTrans = "0xFF" + hex((byte)(rL+rC)/2) + hex((byte)(gL+gC)/2) + hex((byte)(bL+bC)/2);
  //String CRTrans = "0xFF" + hex((byte)(rC+rR)/2) + hex((byte)(gC+gR)/2) + hex((byte)(bC+bR)/2);

  //long LEFT2 = Integer.parseInt(allLeft, 16);
  //long LC1   = Integer.parseInt(LCTrans, 16);
  //long CENT4 = Integer.parseInt(allCenter, 16);
  //long CR1   = Integer.parseInt(CRTrans, 16);
  //long RIGHT2= Integer.parseInt(allRight, 16);
  //long[] screen = {LEFT2,LEFT2,LC1,CENT4,CENT4,CENT4,CENT4,CR1,RIGHT2,RIGHT2};

  port.write(0xff);
  port.write((byte)rL);
  port.write((byte)gL);
  port.write((byte)bL);
  port.write(0xff);
  port.write((byte)rC);
  port.write((byte)gC);
  port.write((byte)bC);
  port.write(0xff);
  port.write((byte)rR);
  port.write((byte)gR);
  port.write((byte)bR);
  delay(10);
  background(rC, gC, bC); //make window background average color
}

