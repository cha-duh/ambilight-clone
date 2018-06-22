//Developed by Rajarshi Roy heavily modified by bld @ http://captain-slow.dk/
import java.awt.Robot; //java library that lets us take screenshots
import java.awt.AWTException;
import java.awt.event.InputEvent;
import java.awt.image.BufferedImage;
import java.awt.Rectangle;
import java.awt.Dimension;
import processing.serial.*; //library for serial communication

Serial port; //creates object "port" of serial class
Robot robby; //creates object "robby" of robot class

//each section is 1/32 the size of the screen.
//1/8th horizontally
//1/4th vertically
//can brighten by raising alphaFactor
//or dim by lowering it.
int alphaFactor = 32;

//uncomment for specific w/h
//int screenW  =  1920;
//int screenH  =  1080;

//uncomment for dynamic w/h
int screenW = displayWidth;
int screenH = displayHeight;

//Color adjustments, use this to adjust the color values to match your LEDs
int maxRed      = 255;
int maxGreen    = 255;
int maxBlue     = 255;

//How many pixels to skip while reading
int pixelSpread = 2;

void setup()
{
  println(Serial.list());
  println(displayWidth + " x " + displayHeight);
  strokeWeight(2);
  stroke(255);

  port = new Serial(this, Serial.list()[0], 115200); //set baud rate
  size(displayWidth/5, displayHeight/5); //window size

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
  int pixel; //ARGB variable with 32 int bytes where

  //sets of 8 bytes are: Alpha, Red, Green, Blue
  float r0=0;
  float g0=0;
  float b0=0;

  float r1=0;
  float g1=0;
  float b1=0;

  float r2=0;
  float g2=0;
  float b2=0;

  float r3=0;
  float g3=0;
  float b3=0;

  float r4=0;
  float g4=0;
  float b4=0;

  float r5=0;
  float g5=0;
  float b5=0;

  float r6=0;
  float g6=0;
  float b6=0;

  float r7=0;
  float g7=0;
  float b7=0;

  float r8=0;
  float g8=0;
  float b8=0;

  float r9=0;
  float g9=0;
  float b9=0;

  float r10=0;
  float g10=0;
  float b10=0;

  float r11=0;
  float g11=0;
  float b11=0;

  float r12=0;
  float g12=0;
  float b12=0;

  float r13=0;
  float g13=0;
  float b13=0;

  float r14=0;
  float g14=0;
  float b14=0;

  float r15=0;
  float g15=0;
  float b15=0;

  float r16=0;
  float g16=0;
  float b16=0;

  float r17=0;
  float g17=0;
  float b17=0;

  float r18=0;
  float g18=0;
  float b18=0;

  float r19=0;
  float g19=0;
  float b19=0;

  //get screenshot into object "screenshot" of class BufferedImage.  To take color samples from a second
  //monitor, change 1920 to the width of your monitor.
  BufferedImage screenshot = robby.createScreenCapture(new Rectangle(new Dimension(displayWidth,displayHeight)));

  //Calculate first top rectangle
  for (int i=0; i<displayWidth/8; i=i+2) {
    for (int j=0; j<displayHeight/4; j=j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r0 = r0+(int)(maxRed&(pixel>>16)); //add up reds
      g0 = g0+(int)(maxGreen&(pixel>>8)); //add up greens
      b0 = b0+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r0 = r0 / ( (top0W / pixelSpread) * (top0H / pixelSpread) ); //average red
  //g0 = g0 / ( (top0W / pixelSpread) * (top0H / pixelSpread) ); //average green
  //b0 = b0 / ( (top0W / pixelSpread) * (top0H / pixelSpread) ); //average blue
  r0 = r0/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g0 = g0/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b0 = b0/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);

  port.write(0xff); //sync
  port.write((byte)(r0)); //red
  port.write((byte)(g0)); //green
  port.write((byte)(b0)); //blue

  color top0 = color(r0, g0, b0);
  fill(top0);
  //rect(borderLeft, borderTop, top1W, top1H);
  rect(0,0,width/8,height/4);
  
  //Calculate second top rectangle
  for (int i=displayWidth/8; i<2*displayWidth/8; i=i+2) {
    for (int j=0; j<displayHeight/4; j=j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r1 = r1+(int)(maxRed&(pixel>>16)); //add up reds
      g1 = g1+(int)(maxGreen&(pixel>>8)); //add up greens
      b1 = b1+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r1 = r1 / ( (top1W / pixelSpread) * (top1H / pixelSpread) ); //average red
  //g1 = g1 / ( (top1W / pixelSpread) * (top1H / pixelSpread) ); //average green
  //b1 = b1 / ( (top1W / pixelSpread) * (top1H / pixelSpread) ); //average blue
  r1 = r1/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g1 = g1/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b1 = b1/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r1)); //red
  port.write((byte)(g1)); //green
  port.write((byte)(b1)); // blue

  color top1 = color(r1, g1, b1);
  fill(top1);
  //rect(borderLeft*2 + top1W, borderTop, top1W, top1H);
  rect(width/8,0,width/8,height/4);
  
  //Calculate third top rectangle
 for (int i=2*displayWidth/8; i<3*displayWidth/8; i=i+2) {
    for (int j=0; j<displayHeight/4; j=j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r2 = r2+(int)(maxRed&(pixel>>16)); //add up reds
      g2 = g2+(int)(maxGreen&(pixel>>8)); //add up greens
      b2 = b2+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r2 = r2 / ( (top2W / pixelSpread) * (top2H / pixelSpread) ); //average red
  //g2 = g2 / ( (top2W / pixelSpread) * (top2H / pixelSpread) ); //average green
  //b2 = b2 / ( (top2W / pixelSpread) * (top2H / pixelSpread) ); //average blue
  r2 = r2/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g2 = g2/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b2 = b2/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r2)); //red
  port.write((byte)(g2)); //green
  port.write((byte)(b2)); // blue

  color top2 = color(r2, g2, b2);
  fill(top2);
  //rect((borderLeft*3 + top2W*2), borderTop, top2W, top2H);
  rect(2*width/8,0,width/8,height/4);

  //Calculate fourth top rectangle
 for (int i=3*displayWidth/8; i<4*displayWidth/8; i=i+2) {
    for (int j=0; j<displayHeight/4; j=j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r3 = r3+(int)(maxRed&(pixel>>16)); //add up reds
      g3 = g3+(int)(maxGreen&(pixel>>8)); //add up greens
      b3 = b3+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r3 = r3 / ( (top3W / pixelSpread) * (top3H / pixelSpread) ); //average red
  //g3 = g3 / ( (top3W / pixelSpread) * (top3H / pixelSpread) ); //average green
  //b3 = b3 / ( (top3W / pixelSpread) * (top3H / pixelS9pread) ); //average blue
  r3 = r3/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g3 = g3/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b3 = b3/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);

  port.write(0xff); //sync
  port.write((byte)(r3)); //red
  port.write((byte)(g3)); //green
  port.write((byte)(b3)); // blue

  color top3 = color(r3, g3, b3);
  fill(top3);
  //rect(borderLeft*4 + top3W*3, borderTop, top3W, top3H);
  rect(3*width/8,0,width/8,height/4);

  //Calculate fifth top rectangle
 for (int i=4*displayWidth/8; i<5*displayWidth/8; i=i+2) {
    for (int j=0; j<displayHeight/4; j=j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r4 = r4+(int)(maxRed&(pixel>>16)); //add up reds
      g4 = g4+(int)(maxGreen&(pixel>>8)); //add up greens
      b4 = b4+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r4 = r4 / ( (top3W / pixelSpread) * (top3H / pixelSpread) ); //average red
  //g4 = g4 / ( (top3W / pixelSpread) * (top3H / pixelSpread) ); //average green
  //b4 = b4 / ( (top3W / pixelSpread) * (top3H / pixelSpread) ); //average blue
  r4 = r4/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g4 = g4/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b4 = b4/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r4)); //red
  port.write((byte)(g4)); //green
  port.write((byte)(b4)); // blue

  color top4 = color(r4, g4, b4);
  fill(top4);
  //rect(borderLeft*5 + top4W*4, borderTop, top4W, top4H);
  rect(4*width/8,0,width/8,height/4);

  //Calculate sixth top rectangle
  for (int i=5*displayWidth/8; i<6*displayWidth/8; i=i+2) {
    for (int j=0; j<displayHeight/4; j=j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r5 = r5+(int)(maxRed&(pixel>>16)); //add up reds
      g5 = g5+(int)(maxGreen&(pixel>>8)); //add up greens
      b5 = b5+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r5 = r5 / ( (top5W / pixelSpread) * (top5H / pixelSpread) ); //average red
  //g5 = g5 / ( (top5W / pixelSpread) * (top5H / pixelSpread) ); //average green
  //b5 = b5 / ( (top5W / pixelSpread) * (top5H / pixelSpread) ); //average blue
  r5 = r5/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g5 = g5/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b5 = b5/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);

  port.write(0xff); //sync
  port.write((byte)(r5)); //red
  port.write((byte)(g5)); //green
  port.write((byte)(b5)); // blue

  color top5 = color(r5, g5, b5);
  fill(top5);
  //rect(borderLeft*6 + top5W*5, borderTop, top5W, top5H);
  rect(5*width/8,0,width/8,height/4);
  
  //Calculate seventh top rectangle
  for (int i=6*displayWidth/8; i<7*displayWidth/8; i=i+2) {
    for (int j = 0; j<displayHeight/4; j = j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r6 = r6+(int)(maxRed&(pixel>>16)); //add up reds
      g6 = g6+(int)(maxGreen&(pixel>>8)); //add up greens
      b6 = b6+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r6 = r6 / ( (top6W / pixelSpread) * (top6H / pixelSpread) ); //average red
  //g6 = g6 / ( (top6W / pixelSpread) * (top6H / pixelSpread) ); //average green
  //b6 = b6 / ( (top6W / pixelSpread) * (top6H / pixelSpread) ); //average blue
  r6 = r6/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g6 = g6/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b6 = b6/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r6)); //red
  port.write((byte)(g6)); //green
  port.write((byte)(b6)); // blue

  color top6 = color(r6, g6, b6);
  fill(top6);
  //rect(borderLeft*7 + top6W*6, borderTop, top6W, top6H);
  rect(6*width/8,0,width/8,height/4);
  
  //Calculate eighth top rectangle
  for (int i=7*displayWidth/8; i<displayWidth; i=i+2) {
    for (int j=0; j<displayHeight/4; j=j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r7 = r7+(int)(maxRed&(pixel>>16)); //add up reds
      g7 = g7+(int)(maxGreen&(pixel>>8)); //add up greens
      b7 = b7+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r7 = r7 / ( (top7W / pixelSpread) * (top7H / pixelSpread) ); //average red
  //g7 = g7 / ( (top7W / pixelSpread) * (top7H / pixelSpread) ); //average green
  //b7 = b7 / ( (top7W / pixelSpread) * (top7H / pixelSpread) ); //average blue
  r7 = r7/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g7 = g7/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b7 = b7/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r7)); //red
  port.write((byte)(g7)); //green
  port.write((byte)(b7)); // blue

  color top7 = color(r7, g7, b7);
  fill(top7);
  //rect(borderLeft*8 + top3W*7, borderTop, top7W, top7H);
  rect(7*width/8,0,width/8,height/4);
  
  //Calculate right top middle rectangle
  for (int i=7*displayWidth/8; i<displayWidth; i=i+2) {
    for (int j = displayHeight/4; j<2*displayHeight/4; j=j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r8 = r8+(int)(maxRed&(pixel>>16)); //add up reds
      g8 = g8+(int)(maxGreen&(pixel>>8)); //add up greens
      b8 = b8+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r8 = r8 / ( (tmid1W / pixelSpread) * (tmid1H / pixelSpread) ); //average red
  //g8 = g8 / ( (tmid1W / pixelSpread) * (tmid1H / pixelSpread) ); //average green
  //b8 = b8 / ( (tmid1W / pixelSpread) * (tmid1H / pixelSpread) ); //average blue
  r8 = r8/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g8 = g8/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b8 = b8/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r8)); //red
  port.write((byte)(g8)); //green
  port.write((byte)(b8)); // blue

  color tmid8 = color(r8, g8, b8);
  fill(tmid8);
  //rect(borderLeft*8 + tmid1W*7, borderTop*2 + top7H, tmid1W, tmid1H); 
  rect(7*width/8,height/4,width/8,height/4);
  
  //Calculate right bottom middle rectangle
  for (int i = 7*displayWidth/8;i<displayWidth; i = i+2) {
    for (int j = 2*displayHeight/4; j<3*displayHeight/4; j=j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r9 = r9+(int)(maxRed&(pixel>>16)); //add up reds
      g9 = g9+(int)(maxGreen&(pixel>>8)); //add up greens
      b9 = b9+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r9 = r9 / ( (bmid1W / pixelSpread) * (bmid1H / pixelSpread) ); //average red
  //g9 = g9 / ( (bmid1W / pixelSpread) * (bmid1H / pixelSpread) ); //average green
  //b9 = b9 / ( (bmid1W / pixelSpread) * (bmid1H / pixelSpread) ); //average blue
  r9 = r9/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g9 = g9/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b9 = b9/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r9)); //red
  port.write((byte)(g9)); //green
  port.write((byte)(b9)); // blue

  color bmid9 = color(r9, g9, b9);
  fill(bmid9);
  //rect(borderLeft*8 + bmid1W*7, (borderTop*3) + (bmid1H) + (top7H), bmid1W, bmid1H); 
  rect(7*width/8,2*height/4,width/8,height/4);
  
  //Calculate eighth bottom rectangle
  for (int i = 7*displayWidth/8; i<displayWidth; i = i+2) {
    for (int j = 3*displayHeight/4; j<displayHeight; j = j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r10 = r10+(int)(maxRed&(pixel>>16)); //add up reds
      g10 = g10+(int)(maxGreen&(pixel>>8)); //add up greens
      b10 = b10+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r10 = r10 / ( (bot7W / pixelSpread) * (bot7H / pixelSpread) ); //average red
  //g10 = g10 / ( (bot7W / pixelSpread) * (bot7H / pixelSpread) ); //average green
  //b10 = b10 / ( (bot7W / pixelSpread) * (bot7H / pixelSpread) ); //average blue
  r10 = r10/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g10 = g10/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b10 = b10/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);

  port.write(0xff); //sync
  port.write((byte)(r10)); //red
  port.write((byte)(g10)); //green
  port.write((byte)(b10)); //blue

  color bot10 = color(r10, g10, b10);
  fill(bot10);
  //rect(borderLeft*8 + bot7W*7, borderTop*4 + bmid1H*2 + bot7H, bot7W, bot7H);
  rect(7*width/8,3*height/4,width/8,height/4);

  //Calculate seventh bottom rectangle
  for (int i = 6*displayWidth/8; i<7*displayWidth/8; i = i+2) {
    for (int j = 3*displayHeight/4; j<displayHeight; j = j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r11 = r11+(int)(maxRed&(pixel>>16)); //add up reds
      g11 = g11+(int)(maxGreen&(pixel>>8)); //add up greens
      b11 = b11+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r11 = r11 / ( (bot6W / pixelSpread) * (bot6H / pixelSpread) ); //average red
  //g11 = g11 / ( (bot6W / pixelSpread) * (bot6H / pixelSpread) ); //average green
  //b11 = b11 / ( (bot6W / pixelSpread) * (bot6H / pixelSpread) ); //average blue
  r11 = r11/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g11 = g11/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b11 = b11/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r11)); //red
  port.write((byte)(g11)); //green
  port.write((byte)(b11)); // blue

  color bot11 = color(r11, g11, b11);
  fill(bot11);
  //rect(borderLeft*7 + bot6W*6, borderTop*4 + bmid1H*2 + bot6H, bot6W, bot6H);
  rect(6*width/8,3*height/4,width/8,height/4);

  //Calculate sixth bottom rectangle
  for (int i = 5*displayWidth/8;i<6*displayWidth/8; i = i+2) {
    for (int j = 3*displayHeight/4; j<displayHeight; j = j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r12 = r12+(int)(maxRed&(pixel>>16)); //add up reds
      g12 = g12+(int)(maxGreen&(pixel>>8)); //add up greens
      b12 = b12+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r12 = r12 / ( (bot5W / pixelSpread) * (bot5H / pixelSpread) ); //average red
  //g12 = g12 / ( (bot5W / pixelSpread) * (bot5H / pixelSpread) ); //average green
  //b12 = b12 / ( (bot5W / pixelSpread) * (bot5H / pixelSpread) ); //average blue
  r12 = r12/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g12 = g12/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b12 = b12/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r12)); //red
  port.write((byte)(g12)); //green
  port.write((byte)(b12)); // blue

  color bot12 = color(r12, g12, b12);
  fill(bot12);
  //rect(borderLeft*6 + bot5W*5, borderTop*4 + bmid1H*2 + bot5H, bot5W, bot5H);
  rect(5*width/8,3*height/4,width/8,height/4);

  //Calculate fifth bottom rectangle
  for (int i = 4*displayWidth/8; i<5*displayWidth/8; i = i+2) {
    for (int j = 3*displayHeight/4; j<displayHeight; j = j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r13 = r13+(int)(maxRed&(pixel>>16)); //add up reds
      g13 = g13+(int)(maxGreen&(pixel>>8)); //add up greens
      b13 = b13+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r13 = r13 / ( (bot4W / pixelSpread) * (bot4H / pixelSpread) ); //average red
  //g13 = g13 / ( (bot4W / pixelSpread) * (bot4H / pixelSpread) ); //average green
  //b13 = b13 / ( (bot4W / pixelSpread) * (bot4H / pixelSpread) ); //average blue
  r13 = r13/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g13 = g13/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b13 = b13/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r13)); //red
  port.write((byte)(g13)); //green
  port.write((byte)(b13)); // blue

  color bot13 = color(r13, g13, b13);
  fill(bot13);
  //rect(borderLeft*5 + bot4W*4, borderTop*4 + bmid1H*2 + bot4H, bot4W, bot4H);
  rect(4*width/8,3*height/4,width/8,height/4);

  //Calculate fourth bottom rectangle
  for (int i = 3*displayWidth/8; i<4*displayWidth/8; i = i+2) {
    for (int j = 3*displayHeight/4; j<displayHeight; j = j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r14 = r14+(int)(maxRed&(pixel>>16)); //add up reds
      g14 = g14+(int)(maxGreen&(pixel>>8)); //add up greens
      b14 = b14+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r14 = r14 / ( (bot3W / pixelSpread) * (bot3H / pixelSpread) ); //average red
  //g14 = g14 / ( (bot3W / pixelSpread) * (bot3H / pixelSpread) ); //average green
  //b14 = b14 / ( (bot3W / pixelSpread) * (bot3H / pixelSpread) ); //average blue
  r14 = r14/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g14 = g14/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b14 = b14/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r14)); //red
  port.write((byte)(g14)); //green
  port.write((byte)(b14)); // blue

  color bot14 = color(r14, g14, b14);
  fill(bot14);
  //rect(borderLeft*4 + bot4W*3, borderTop*4 + bmid1H*2 + bot3H, bot3W, bot3H);
  rect(3*width/8,3*height/4,width/8,height/4);

  //Calculate third bottom rectangle
  for (int i = 2*displayWidth/8; i<3*displayWidth/8; i = i+2) {
    for (int j = 3*displayHeight/4; j<displayHeight; j = j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r15 = r15+(int)(maxRed&(pixel>>16)); //add up reds
      g15 = g15+(int)(maxGreen&(pixel>>8)); //add up greens
      b15 = b15+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r15 = r15 / ( (bot2W / pixelSpread) * (bot2H / pixelSpread) ); //average red
  //g15 = g15 / ( (bot2W / pixelSpread) * (bot2H / pixelSpread) ); //average green
  //b15 = b15 / ( (bot2W / pixelSpread) * (bot2H / pixelSpread) ); //average blue
  r15 = r15/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g15 = g15/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b15 = b15/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r15)); //red
  port.write((byte)(g15)); //green
  port.write((byte)(b15)); // blue

  color bot15 = color(r15, g15, b15);
  fill(bot15);
  //rect(borderLeft*3 + bot2W*2, borderTop*4 + bmid1H*2 + bot2H, bot2W, bot2H);
  rect(2*width/8,3*height/4,width/8,height/4);

  //Calculate second bottom rectangle
  for (int i = displayWidth/8; i<2*displayWidth/8; i = i+2) {
    for (int j = 3*displayHeight/4; j<displayHeight; j = j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r16 = r16+(int)(maxRed&(pixel>>16)); //add up reds
      g16 = g16+(int)(maxGreen&(pixel>>8)); //add up greens
      b16 = b16+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r16 = r16 / ( (bot1W / pixelSpread) * (bot1H / pixelSpread) ); //average red
  //g16 = g16 / ( (bot1W / pixelSpread) * (bot1H / pixelSpread) ); //average green
  //b16 = b16 / ( (bot1W / pixelSpread) * (bot1H / pixelSpread) ); //average blue
  r16 = r16/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g16 = g16/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b16 = b16/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r16)); //red
  port.write((byte)(g16)); //green
  port.write((byte)(b16)); // blue

  color bot16 = color(r16, g16, b16);
  fill(bot16);
  rect(width/8,3*height/4,width/8,height/4);

  //Calculate first bottom rectangle
  for (int i = 0; i<displayWidth/8; i = i+2) {
    for (int j = 3*displayHeight/4; j<displayHeight; j = j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r17 = r17+(int)(maxRed&(pixel>>16)); //add up reds
      g17 = g17+(int)(maxGreen&(pixel>>8)); //add up greens
      b17 = b17+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r17 = r17 / ( (bot0W / pixelSpread) * (bot0H / pixelSpread) ); //average red
  //g17 = g17 / ( (bot0W / pixelSpread) * (bot0H / pixelSpread) ); //average green
  //b17 = b17 / ( (bot0W / pixelSpread) * (bot0H / pixelSpread) ); //average blue
  r17 = r17/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g17 = g17/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b17 = b17/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r17)); //red
  port.write((byte)(g17)); //green
  port.write((byte)(b17)); // blue

  color bot17 = color(r17, g17, b17);
  fill(bot17);
  //rect(borderLeft, borderTop*4 + bmid1H*2 + bot0H, bot0W, bot0H);
  rect(0,3*height/4,width/8,height/4);
  
  //Calculate left bottom middle rectangle
  for (int i = 0; i<displayWidth/8; i = i+2) {
    for (int j = 2*displayHeight/4; j<3*displayHeight/4; j=j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r18 = r18+(int)(maxRed&(pixel>>16)); //add up reds
      g18 = g18+(int)(maxGreen&(pixel>>8)); //add up greens
      b18 = b18+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r18 = r18 / ( (bmid0W / pixelSpread) * (bmid0H / pixelSpread) ); //average red
  //g18 = g18 / ( (bmid0W / pixelSpread) * (bmid0H / pixelSpread) ); //average green
  //b18 = b18 / ( (bmid0W / pixelSpread) * (bmid0H / pixelSpread) ); //average blue
  r18 = r18/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g18 = g18/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b18 = b18/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r18)); //red
  port.write((byte)(g18)); //green
  port.write((byte)(b18)); // blue

  color bmid18 = color(r18, g18, b18);
  fill(bmid18);
  //rect(borderLeft, (borderTop*3) + (bmid0H) + (top0H), bmid0W, bmid0H);
  rect(0,2*height/4,width/8,height/4);

  //Calculate left top middle rectangle
  for (int i = 0; i<displayWidth/8; i = i+2) {
    for (int j = displayHeight/4; j<2*displayHeight/4; j=j+2) {
      pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
      r19 = r19+(int)(maxRed&(pixel>>16)); //add up reds
      g19 = g19+(int)(maxGreen&(pixel>>8)); //add up greens
      b19 = b19+(int)(maxBlue&(pixel)); //add up blues
    }
  }
  //r19 = r19 / ( (tmid0W / pixelSpread) * (tmid0H / pixelSpread) ); //average red
  //g19 = g19 / ( (tmid0W / pixelSpread) * (tmid0H / pixelSpread) ); //average green
  //b19 = b19 / ( (tmid0W / pixelSpread) * (tmid0H / pixelSpread) ); //average blue
  r19 = r19/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  g19 = g19/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  b19 = b19/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
  
  port.write(0xff); //sync
  port.write((byte)(r19)); //red
  port.write((byte)(g19)); //green
  port.write((byte)(b19)); // blue

  color bmid19 = color(r19, g19, b19);
  fill(bmid19);
  //rect(borderLeft, (borderTop*2) + (top0H), tmid0W, tmid0H);
  rect(0,height/4,width/8,height/4);
}

