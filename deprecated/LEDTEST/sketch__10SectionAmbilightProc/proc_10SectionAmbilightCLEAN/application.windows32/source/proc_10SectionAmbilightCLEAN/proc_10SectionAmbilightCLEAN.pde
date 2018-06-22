 /************************************************
 *  _______      __    _______                   *
 * |   _   .----|  |--|   _   .---.-.----.-----. *
 * |___|   |   _|    <|.  1___|  _  |  __|  -__| *
 * |.  |   |__| |__|__|.  __) |___._|____|_____| *
 * |:  1   |          |:  |                      * 
 * |::.. . |          |::.|                      * 
 * `-------'          `---'                      *
 ************************************************/
 
import java.awt.Robot; //java library that lets us take screenshots
import java.awt.AWTException;
import java.awt.event.InputEvent;
import java.awt.image.BufferedImage;
import java.awt.Rectangle;
import java.awt.Dimension;
import processing.serial.*; //library for serial communication

Serial port; //creates object "port" of serial class
Robot robby; //creates object "robby" of robot class
BufferedImage screenshot;

//each section is 1/32 the size of the screen.
//1/8th horizontally
//1/4th vertically
//can brighten by raising alphaFactor
//or dim by lowering it.
int alphaFactor = 8;

//uncomment for specific w/h
//int screenW  =  1920;
//int screenH  =  1080;

//uncomment for dynamic w/h
int screenW = displayWidth;
int screenH = displayHeight;

//Color adjustments, use this to adjust the color values to match your LEDs
int MAX = 255;

//variable to hod color information
int pixel;

//How many pixels to skip while reading
int pixelSpread = 2;

//rgb var declarations
float r0, r1, g0, g1, b0, b1;

void setup()
{
  println(Serial.list());
  println(displayWidth + " x " + displayHeight);
  strokeWeight(2);
  stroke(255);

  port = new Serial(this, Serial.list()[1], 9600); //set baud rate
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

  //initialize
  r0=r1=g0=g1=b0=b1=pixel=0;

  screenshot = robby.createScreenCapture(new Rectangle(new Dimension(displayWidth, displayHeight)));
  calculateTop();
}

void calculateTop() {
  for (int k=0; k<10; k++) {
    for (int i=k*displayWidth/10; i<(k+1)*displayWidth/10; i=i+pixelSpread) {
      for (int j=0; j<displayHeight; j= j+pixelSpread) {
        pixel = screenshot.getRGB(i, j); //the ARGB integer has the colors of pixel (i,j)
        r0 = r0+(int)(MAX&(pixel>>16)); //add up reds
        g0 = g0+(int)(MAX&(pixel>>8)); //add up greens
        b0 = b0+(int)(MAX&(pixel)); //add up blues
      }
    }
    r0 = r0/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
    g0 = g0/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);
    b0 = b0/(((displayWidth/pixelSpread)*(displayHeight/pixelSpread))/alphaFactor);

    port.write(0xff);
    port.write((byte)(r0)); //red
    port.write((byte)(g0)); //green
    port.write((byte)(b0)); //blue

    color c = color(r0, g0, b0);
    fill(c);
    rect(k*width/10, 0, width/10, height);
  }
}

void mouseClicked() {
  port.write(0xff); //sync
  for (int i=0; i<20; i++) {
    port.write(0xff);
    port.write(0);
    port.write(0);
    port.write(0);
  }
  println("Sent.");
  exit();
}

