import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class QuakeMappingCompanion extends PApplet {


//Initialize an array of strings that will hold the map file line by line
String mapFileLines[];
PFont alata;

public void setup()
{
    //This makes sure that the window can be resized, both in 2D and 3D
    surface.setResizable(true);

    //Initialize a 3D window for text and graphics to be displayed
    

    //Populate the array of strings with the lines of the map file
    mapFileLines = loadStrings("data/endofsolace.map");
}

public void draw()
{
    cls();
    fontSetup();
    
    textAlign(CENTER);
    text("Hello World!", width/2, height/2);
}

//A simple method to clear the screen on each frame, avoid ghosting
public void cls()
{
    background(0);
}

public void fontSetup()
{
    //Load the font used for writing text
    alata = createFont("Alata-Regular.ttf", width/10);
    textFont(alata);
}
  public void settings() {  size(800, 600, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "QuakeMappingCompanion" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
