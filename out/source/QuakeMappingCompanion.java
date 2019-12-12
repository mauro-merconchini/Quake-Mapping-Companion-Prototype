import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Stack; 

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
            //println(frameRate);

            noLoop();
        }

        //The file must have loaded, but failed the verification
        else
        {
            textAlign(CENTER);
            text("FILE NOT VALIDATED!", width/8, height/8, width-width/5, height-height/5);
        }
    }

    //No file has been loaded, or the file loaded was not a map file
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
        
        int start = millis();
        mapProcessor.processMapFile();
        int end = millis();

        //This is here just to observe how long it takes the program to process a map file
        println("Map File Processing Time: " + (end - start) + " ms");
    }
}
class Brush
{
    PVector verts[];
    String texture;

    boolean isWorldSpawn;
    boolean isEntity;

    
}
class Entity
{
    int start, end;
    String mapFile[];

    Entity(String mapFileLines[], int startLine, int endLine)
    {
        mapFile = mapFileLines;
        start = startLine;
        end = endLine;
    }

    public void wasteTime()
    {
        for (int i = start; i < end + 1; i++)
        {
            //println("a");
        }
    }
}


class MapFileProcessor
{
    String mapFilePath;
    String mapFileLines[];

    boolean fileLoaded, fileValidated;

    ArrayList<Entity> entityList;

    //Empty constructor
    MapFileProcessor() { entityList = new ArrayList<Entity>(); }

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
    
    //Will call helper methods to scan the file and collect information
    public void processMapFile()
    {
        entityScan();
    }

    //Scans the file for entities, creates the entity objects, and adds them to the list
    public void entityScan()
    {
        //Intitalize two integers that will determine the start and end of an entity block
        int entityStart = 0;
        int entityEnd = 0;

        //Initialize a stack that will be used to determine when an entity ends
        Stack entityCurlyStack = new Stack();

        //This loop scans through all the lines of the map file top to bottom
        for (int i = 0; i < mapFileLines.length; i++)
        {
            Entity tempEntity;

            //This is how you determine the start of an entity block
            if (mapFileLines[i].equals("{") && mapFileLines[i - 1].contains("// entity"))
            {
                //Record the line in which the entity starts
                entityStart = i + 1;
                //Push a curly to the stack
                entityCurlyStack.push(i);
            }

            //Any curly openings need to be pushed to the stack
            else if (mapFileLines[i].equals("{"))
            {
                entityCurlyStack.push(i);
            }

            //Any curly closes need to cause a stack pop
            else if (mapFileLines[i].equals("}"))
            {
                entityCurlyStack.pop();

                //Check if the pop made the stack empty, which means you reached the end of an entity block
                if (entityCurlyStack.empty())
                {
                    //Record the line in which the entity ends
                    entityEnd = i;

                    // String entityLines[] = new String[entityBlockLength];

                    //int copyLocation = entityStart;

                    // for (int j = 0; j < entityLines.length; j++)
                    // {
                    //     entityLines[j] = mapFileLines[copyLocation];
                    //     copyLocation++;
                    // }

                    //tempEntity = new Entity(entityLines);
                    //entityList.add(tempEntity);

                    tempEntity = new Entity(mapFileLines, entityStart, entityEnd);
                    tempEntity.wasteTime();
                }
            }
        }
        
        //entityList.get(1).printLines();
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
