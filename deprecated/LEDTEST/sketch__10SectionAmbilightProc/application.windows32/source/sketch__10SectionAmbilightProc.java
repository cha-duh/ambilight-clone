import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.Robot; 
import java.awt.AWTException; 
import java.awt.event.InputEvent; 
import java.awt.image.BufferedImage; 
import java.awt.Rectangle; 
import java.awt.Dimension; 
import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch__10SectionAmbilightProc extends PApplet {

//Developed by Rajarshi Roy
 //java library that lets us take screenshots





 //library for serial communication


Serial port; //creates object "port" of serial class
Robot robby; //creates object "robby" of robot class

int alphaFactor = 12;

public void setup()
{
println(Serial.list());
println(displayWidth + " x " + displayHeight);
port = new Serial(this, Serial.list()[1],9600); //set baud rate
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

public void draw()
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

//get screenshot into object "screenshot" of class BufferedImage
BufferedImage screenshot = robby.createScreenCapture(new Rectangle(new Dimension(displayWidth,displayHeight)));
//1368*928 is the screen resolution


int i=0;
int j=0;
//I skip every alternate pixel making my program 4 times faster
for(i=0;i<displayWidth/10; i=i+2){
for(j=0; j<displayHeight;j=j+2){
pixel = screenshot.getRGB(i,j); //the ARGB integer has the colors of pixel (i,j)
r0 = r0+(int)(255&(pixel>>16)); //add up reds
g0 = g0+(int)(255&(pixel>>8)); //add up greens
b0 = b0+(int)(255&(pixel)); //add up blues
}
}

for(i=displayWidth/10;i<2*displayWidth/10; i=i+2){
for(j=0; j<displayHeight;j=j+2){
pixel = screenshot.getRGB(i,j); //the ARGB integer has the colors of pixel (i,j)
r1 = r1+(int)(255&(pixel>>16)); //add up reds
g1 = g1+(int)(255&(pixel>>8)); //add up greens
b1 = b1+(int)(255&(pixel)); //add up blues
}
}

for(i=2*displayWidth/10;i<3*displayWidth/10; i=i+2){
for(j=0; j<displayHeight;j=j+2){
pixel = screenshot.getRGB(i,j); //the ARGB integer has the colors of pixel (i,j)
r2 = r2+(int)(255&(pixel>>16)); //add up reds
g2 = g2+(int)(255&(pixel>>8)); //add up greens
b2 = b2+(int)(255&(pixel)); //add up blues
}
}

for(i=3*displayWidth/10;i<4*displayWidth/10; i=i+2){
for(j=0; j<displayHeight;j=j+2){
pixel = screenshot.getRGB(i,j); //the ARGB integer has the colors of pixel (i,j)
r3 = r3+(int)(255&(pixel>>16)); //add up reds
g3 = g3+(int)(255&(pixel>>8)); //add up greens
b3 = b3+(int)(255&(pixel)); //add up blues
}
}

for(i=4*displayWidth/10;i<5*displayWidth/10; i=i+2){
for(j=0;j<displayHeight;j=j+2){
pixel = screenshot.getRGB(i,j); //the ARGB integer has the colors of pixel (i,j)
r4 = r4+(int)(255&(pixel>>16)); //add up reds
g4 = g4+(int)(255&(pixel>>8)); //add up greens
b4 = b4+(int)(255&(pixel)); //add up blues
}
}

for(i=5*displayWidth/10;i<6*displayWidth/10; i=i+2){
for(j=0;j<displayHeight;j=j+2){
pixel = screenshot.getRGB(i,j); //the ARGB integer has the colors of pixel (i,j)
r5 = r5+(int)(255&(pixel>>16)); //add up reds
g5 = g5+(int)(255&(pixel>>8)); //add up greens
b5 = b5+(int)(255&(pixel)); //add up blues
}
}

for(i=6*displayWidth/10;i<7*displayWidth/10; i=i+2){
for(j=0;j<displayHeight;j=j+2){
pixel = screenshot.getRGB(i,j); //the ARGB integer has the colors of pixel (i,j)
r6 = r6+(int)(255&(pixel>>16)); //add up reds
g6 = g6+(int)(255&(pixel>>8)); //add up greens
b6 = b6+(int)(255&(pixel)); //add up blues
}
}

for(i=7*displayWidth/10;i<8*displayWidth/10; i=i+2){
for(j=0;j<displayHeight;j=j+2){
pixel = screenshot.getRGB(i,j); //the ARGB integer has the colors of pixel (i,j)
r7 = r7+(int)(255&(pixel>>16)); //add up reds
g7 = g7+(int)(255&(pixel>>8)); //add up greens
b7 = b7+(int)(255&(pixel)); //add up blues
}
}

for(i=8*displayWidth/10;i<9*displayWidth/10; i=i+2){
for(j=0;j<displayHeight;j=j+2){
pixel = screenshot.getRGB(i,j); //the ARGB integer has the colors of pixel (i,j)
r8 = r8+(int)(255&(pixel>>16)); //add up reds
g8 = g8+(int)(255&(pixel>>8)); //add up greens
b8 = b8+(int)(255&(pixel)); //add up blues
}
}

for(i=9*displayWidth/10;i<displayWidth; i=i+2){
for(j=0;j<displayHeight;j=j+2){
pixel = screenshot.getRGB(i,j); //the ARGB integer has the colors of pixel (i,j)
r9 = r9+(int)(255&(pixel>>16)); //add up reds
g9 = g9+(int)(255&(pixel>>8)); //add up greens
b9 = b9+(int)(255&(pixel)); //add up blues
}
}

//Average at 0
r0=r0/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average red (remember that I skipped ever alternate pixel)
g0=g0/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average green
b0=b0/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average blue

//Average at 1
r1=r1/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average red (remember that I skipped ever alternate pixel)
g1=g1/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average green
b1=b1/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average blue

//Average at 2
r2=r2/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average red (remember that I skipped ever alternate pixel)
g2=g2/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average green
b2=b2/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average blue

//Average at 3
r3=r3/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average red (remember that I skipped ever alternate pixel)
g3=g3/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average green
b3=b3/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average blue

//Average at 4
r4=r4/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average red (remember that I skipped ever alternate pixel)
g4=g4/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average green
b4=b4/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average blue

//Average at 5
r5=r5/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average red (remember that I skipped ever alternate pixel)
g5=g5/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average green
b5=b5/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average blue

//Average at 6
r6=r6/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average red (remember that I skipped ever alternate pixel)
g6=g6/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average green
b6=b6/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average blue

//Average at 7
r7=r7/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average red (remember that I skipped ever alternate pixel)
g7=g7/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average green
b7=b7/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average blue

//Average at 8
r8=r8/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average red (remember that I skipped ever alternate pixel)
g8=g8/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average green
b8=b8/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average blue

//Average at 9
r9=r9/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average red (remember that I skipped ever alternate pixel)
g9=g9/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average green
b9=b9/(((displayWidth/2)*(displayHeight/2))/alphaFactor); //average blue

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
port.write((byte)r0);
port.write((byte)g0);
port.write((byte)b0);
port.write(0xff);
port.write((byte)r1);
port.write((byte)g1);
port.write((byte)b1);
port.write(0xff);
port.write((byte)r2);
port.write((byte)g2);
port.write((byte)b2);
port.write(0xff);
port.write((byte)r3);
port.write((byte)g3);
port.write((byte)b3);
port.write(0xff);
port.write((byte)r4);
port.write((byte)g4);
port.write((byte)b4);
port.write(0xff);
port.write((byte)r5);
port.write((byte)g5);
port.write((byte)b5);
port.write(0xff);
port.write((byte)r6);
port.write((byte)g6);
port.write((byte)b6);
port.write(0xff);
port.write((byte)r7);
port.write((byte)g7);
port.write((byte)b7);
port.write(0xff);
port.write((byte)r8);
port.write((byte)g8);
port.write((byte)b8);
port.write(0xff);
port.write((byte)r9);
port.write((byte)g9);
port.write((byte)b9);
delay(10);
background(r4,g4,b4); //make window background average color
}  

public void cleanUp() {
  for (int i=0; i<10; i++) {
    port.write((byte)0xff);
    port.write((byte)0x00);
    port.write((byte)0x00);
    port.write((byte)0x00);
  }
}  

public void mouseClicked() {
  cleanUp();
  exit();
}
  
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch__10SectionAmbilightProc" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
