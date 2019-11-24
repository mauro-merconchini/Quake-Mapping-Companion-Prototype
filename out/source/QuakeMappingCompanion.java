import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import drop.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class QuakeMappingCompanion extends PApplet {

//Library responsible for the file drag-n-drop functionality


//String mapFileLocation;

//Initialize an array of strings that will hold the map file line by line
String mapFileLines[];

//Initialize a font object that will be used to load the custom font
PFont alata;

//Initialize an object that will handle drag-n-drop
SDrop drop;

public void setup()
{
    //This makes sure that the window can be resized, both in 2D and 3D
    surface.setResizable(true);

    //Initialize a 3D window for text and graphics to be displayed
    

    drop = new SDrop(this);

    //Populate the array of strings with the lines of the map file
    //mapFileLines = loadStrings("data/endofsolace.map");
}

public void draw()
{
    cls();
    fontSetup();

    //awaitFile();
    
    textAlign(CENTER);
    text("drag and drop your map file!", width/8, height/8, width-width/5, height-height/5);

    noLoop();
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

public void dropEvent(DropEvent theDropEvent) 
{
    mapFileLines = loadStrings(theDropEvent.file());
    writeFile();

    AnotherWindow test = (theDropEvent.file().toString());

    test.draw();
}

public void writeFile()
{
    println(mapFileLines);
}
class AnotherWindow
{
    String mapFilePath;

    AnotherWindow(String path)
    {
        mapFilePath = path;
    }

    public void setup()
    {
        background(125);
        size(100, 200, P3D);
    }

    public void draw()
    {
        ellipse(width/2, height/2, width/2, height/2);
    }
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "QuakeMappingCompanion" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
