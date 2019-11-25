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

String mapFileLocation;

//Initialize a font object that will be used to load the custom font
PFont alata;

MapFileProcessor mapProcessor;

public void setup()
{
    //This makes sure that the window can be resized, both in 2D and 3D
    surface.setResizable(true);

    //Initialize a 3D window for text and graphics to be displayed
    

    selectInput("Select a .map file to process", "fileSelected");

    //Populate the array of strings with the lines of the map file
    //mapFileLines = loadStrings(mapFileLocation);
}

public void draw()
{
    cls();
    fontSetup();

    textAlign(CENTER);
    text("MAIN WINDOW", width/8, height/8, width-width/5, height-height/5);
}

public void fileSelected(File selection) 
{
    if (selection == null) 
    {
        println("Window was closed or the user hit cancel.");
    } 

    else 
    {
        println("User selected " + selection.getAbsolutePath());

        mapFileLocation = selection.getAbsolutePath();

        mapProcessor = new MapFileProcessor(selection.getAbsolutePath());

        println(mapProcessor.toString());
    }
}
class MapFileProcessor
{
    String mapFilePath;

    MapFileProcessor (String filePath)
    {
        mapFilePath = filePath;
    }

    public String toString()
    {
        return mapFilePath;
    }
}
//A simple method to clear the screen on each frame, avoid ghosting
public void cls()
{
    background(0);
}

//This sets up the font that will be used for displaying text
public void fontSetup()
{
    //Load the font used for writing text
    alata = createFont("data/Alata-Regular.ttf", width/10);
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
