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

//Initialize a font object that will be used to load the custom font
PFont alata;

//Initialize an object that will take care of processing the map file
MapFileProcessor mapProcessor;

//Will run once at the start of the program's life
public void setup()
{
    //This makes sure that the window can be resized, both in 2D and 3D
    surface.setResizable(true);

    //Initialize a 3D window for text and graphics to be displayed
    

    selectInput("Select a .map file to process", "fileSelected");

    mapProcessor = new MapFileProcessor();
}

//Will update once per frame, place your drawing routines here
public void draw()
{
    cls();
    fontSetup();

    //Only run the following code if a file has been loaded
    if (mapProcessor.fileLoaded)
    {
        //Only run the following code if the file has been validated to be a Trenchbroom Quake map file
        if (mapProcessor.fileValidated)
        {
            textAlign(CENTER);
            text("FILE VALIDATED!", width/8, height/8, width-width/5, height-height/5);
        }

        else
        {
            textAlign(CENTER);
            text("FILE NOT VALIDATED!", width/8, height/8, width-width/5, height-height/5);
        }
    }

    else
    {
        textAlign(CENTER);
        text("NO MAP FILE LOADED!", width/8, height/8, width-width/5, height-height/5);
    }
}

//This method will be run once the file selection dialog is closed
public void fileSelected(File selection) 
{
    //No selection made
    if (selection == null) 
    {
        println("Window was closed or the user hit cancel.");

        //Close the program
        exit();
    } 

    //File was selected
    else 
    {
        println("User selected " + selection.getAbsolutePath());

        //Load the map file into the processor object
        mapProcessor.loadFile(selection.getAbsolutePath());
    }
}
class MapFileProcessor
{
    String mapFilePath;
    String mapFileLines[];

    boolean fileLoaded;
    boolean fileValidated;

    //Empty constructor
    MapFileProcessor() {}

    //Prints the path of the map file
    public String mapPath()
    {
        return mapFilePath;
    }

    //Takes care of loading the file, calling a validating helper method, and writing the array of lines
    public void loadFile(String path)
    {
        mapFilePath = path;
        fileLoaded = true;
        mapFileLines = loadStrings(mapFilePath);

        validateFile();
    }

    //Make sure that the input file is a valid map file
    public void validateFile()
    {
        //Check that the file path shows the correct file extension
        if (mapFilePath.substring(mapFilePath.length() - 4).equals(".map"))
        {
            //Check that the map file actually comes from a Trenchbroom Quake map file
            if (mapFileLines[0].equals("// Game: Quake"))
            {
                fileValidated = true;
            }
        }
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
