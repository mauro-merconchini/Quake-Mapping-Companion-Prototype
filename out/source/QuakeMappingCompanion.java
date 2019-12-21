import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Scanner; 
import java.util.Stack; 
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

    rectMode(CENTER);

    //Initialize a window for text and graphics to be displayed
    

    selectInput("Select a .map file to process", "fileSelected");

    mapProcessor = new MapFileProcessor();

    stroke(255);
}

//Will update once per frame, place your drawing routines here
public void draw()
{
    cls();
    fontSetup(12);

    // println(pootis());

    //Only run the following code if a file has been loaded
    if (mapProcessor.fileLoaded)
    {
        //Only run the following code if the file has been validated to be a Trenchbroom Quake map file
        //MAIN PROGRAM DRAW CODE GOES HERE
        if (mapProcessor.fileValidated)
        {
            fontSetup(24);
            
            textAlign(CENTER);
            text(mapProcessor.mapFileName, width/2, height/10, width, height/7);

            textAlign(CENTER);
            text("ENTITIES", width/4, height/8, width/2, height/15);
            text("BRUSHES", (width/4 + width/2), height/8, width/2, height/15);

            //These lines are the division segments in the program window
            line (0, height/6.5f, width, height/6.5f);
            line(width/2, height/6.5f, width/2, height);

            //********************E N T I T I E S*************************************************
            
            //These text methods set up the drawing of names of the entity groups
            textAlign(LEFT);
            text("Enemies", width/8, height/5, width/4.8f, height/15);
            text("Doors", width/8, ((height/5 + (height/15 + height/40) * 1)), width/4.8f, height/15);
            text("Lights", width/8, ((height/5 + (height/15 + height/40) * 2)), width/4.8f, height/15);
            text("Items", width/8, ((height/5 + (height/15 + height/40) * 3)), width/4.8f, height/15);
            text("Details", width/8, ((height/5 + (height/15 + height/40) * 4)), width/4.8f, height/15);
            text("Groups", width/8, ((height/5 + (height/15 + height/40) * 5)), width/4.8f, height/15);
            text("Triggers", width/8, ((height/5 + (height/15 + height/40) * 6)), width/4.8f, height/15);
            text("Teleports", width/8, ((height/5 + (height/15 + height/40) * 7)), width/4.8f, height/15);
            text("Total", width/8, ((height/5 + (height/15 + height/40) * 8)), width/4.8f, height/15);

            //These text methods set up the drawing of entity numeric data
            textAlign(RIGHT);
            text("" + mapProcessor.enemies, (width/8 + width/4.2f), height/5, width/4.2f, height/15);
            text("" + mapProcessor.doors, (width/8 + width/4.2f), ((height/5 + (height/15 + height/40) * 1)), width/4.2f, height/15);
            text("" + mapProcessor.lights, (width/8 + width/4.2f), ((height/5 + (height/15 + height/40) * 2)), width/4.2f, height/15);
            text("" + mapProcessor.items, (width/8 + width/4.2f), ((height/5 + (height/15 + height/40) * 3)), width/4.2f, height/15);
            text("" + mapProcessor.details, (width/8 + width/4.2f), ((height/5 + (height/15 + height/40) * 4)), width/4.2f, height/15);
            text("" + mapProcessor.groups, (width/8 + width/4.2f), ((height/5 + (height/15 + height/40) * 5)), width/4.2f, height/15);
            text("" + mapProcessor.triggers, (width/8 + width/4.2f), ((height/5 + (height/15 + height/40) * 6)), width/4.2f, height/15);
            text("" + mapProcessor.teleports, (width/8 + width/4.2f), ((height/5 + (height/15 + height/40) * 7)), width/4.2f, height/15);
            text("" + mapProcessor.entities, (width/8 + width/4.2f), ((height/5 + (height/15 + height/40) * 8)), width/4.2f, height/15);
            
            //********************B R U S H E S*************************************************

            //These text methods set up the drawing of names of brush types
            textAlign(LEFT);
            text("World", (width/8 + width/2), height/5, width/4.8f, height/15);
            text("Doors", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 1)), width/4.8f, height/15);
            text("Details", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 2)), width/4.8f, height/15);
            text("Groups", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 3)), width/4.8f, height/15);
            text("Triggers", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 4)), width/4.8f, height/15);
            text("Teleports", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 5)), width/4.8f, height/15);
            text("", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 6)), width/4.8f, height/15);
            text("", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 7)), width/4.8f, height/15);
            text("Total", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 8)), width/4.8f, height/15);
            
            //These text methods set up the drawing of brush numeric data
            textAlign(RIGHT);
            text("" + mapProcessor.worldspawnBrushes, ((width/8 + width/4.2f) + width/2), height/5, width/4.2f, height/15);
            text("" + mapProcessor.doorBrushes, ((width/8 + width/4.2f) + width/2), ((height/5 + (height/15 + height/40) * 1)), width/4.2f, height/15);
            text("" + mapProcessor.detailBrushes, ((width/8 + width/4.2f) + width/2), ((height/5 + (height/15 + height/40) * 2)), width/4.2f, height/15);
            text("" + mapProcessor.groupBrushes, ((width/8 + width/4.2f) + width/2), ((height/5 + (height/15 + height/40) * 3)), width/4.2f, height/15);
            text("" + mapProcessor.triggerBrushes, ((width/8 + width/4.2f) + width/2), ((height/5 + (height/15 + height/40) * 4)), width/4.2f, height/15);
            text("" + mapProcessor.teleportBrushes, ((width/8 + width/4.2f) + width/2), ((height/5 + (height/15 + height/40) * 5)), width/4.2f, height/15);
            text("", ((width/8 + width/4.2f) + width/2), ((height/5 + (height/15 + height/40) * 6)), width/4.2f, height/15);
            text("", ((width/8 + width/4.2f) + width/2), ((height/5 + (height/15 + height/40) * 7)), width/4.2f, height/15);
            text("" + mapProcessor.brushes, ((width/8 + width/4.2f) + width/2), ((height/5 + (height/15 + height/40) * 8)), width/4.2f, height/15);

            //Create a new thread to re-scan the file and refresh data every ~0.75 seconds
            if (frameCount % 45 == 0)
            {
                // Kick off a run of the processing thread every ~1.5 seconds
                Thread processThread = new Thread(mapProcessor);
                processThread.start();
            }
        }

        //The file must have loaded, but failed the verification
        else
        {
            textAlign(CENTER);
            text("FILE NOT VALIDATED!", width/2, height/2);
        }
    }

    //No file has been loaded, or the file loaded was not a map file
    else
    {
        textAlign(CENTER);       
        text("NO MAP FILE LOADED!", width/2, height/2);
    }
}

//This method will be run once the file selection dialog is closed
public void fileSelected(File selection) 
{
    //No selection made
    if (selection == null)
    {
        println("Window was closed or the user hit cancel.");

        //Close the program;
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



class Entity
{
    //These integers will define where the scanning process in the mapFileLines array begins and ends
    int start, end;
    
    //This will be a carbon copy of the mapFileLines array that is used by the MapFileProcessor class, but it will be limited with a range of lines that it can scan
    String mapFileLines[];

    String entityClass;

    StringList textureList;

    int entityBrushCount;

    Entity(String[] mapLines, int startLine, int endLine)
    {
        mapFileLines = mapLines;
        start = startLine;
        end = endLine;

        textureList = new StringList();
    }

    //This method calls helper methods to perform all the operations of processing an entity
    public void processEntity()
    {
        setClass();
        brushProcess();
    }

    //This method uses a scanner to set the classname of the entity object
    public void setClass()
    {
        for (int i = start; i < end; i++)
        {
            if (mapFileLines[i].contains("classname"))
            {
                Scanner classScanner = new Scanner(mapFileLines[i]);

                //This gets rid of "classname" which is always going to be the first token of the line
                classScanner.next();

                //This makes sure that you get rid of the quotation marks in the classname
                String tempString = classScanner.next();
                entityClass = tempString.substring(1, (tempString.length() - 1));
            }
        }
    }

    public void brushProcess()
    {
        for (int i = start; i < end; i++)
        {
            //This is how you determine the start of a brush block
            if (mapFileLines[i].equals("{") && mapFileLines[i - 1].contains("// brush"))
            {
                //Increment the counter of how many brushes this entity is made of
                entityBrushCount++;

                //Increment i by 1 which skips the { and puts the for-loop at the first line of the brush block
                i++;             

                //Code block inside this loop will run for the entire brush block
                while (!mapFileLines[i + 1].equals("}"))
                {
                    Scanner textureScanner = new Scanner(mapFileLines[i]);
                    String textureName = "";

                    //Gets the exact String token of the texture name, should replace this with a more elegant solution
                    for (int j = 0; j < 16; j++)
                    {
                        textureName = textureScanner.next();
                    }

                    //Add that texture token to the StringList
                    textureList.append(textureName);

                    i++;
                }
            }
        }
    }

    public String className()
    {
        return entityClass;
    }

    public int brushCount()
    {
        return entityBrushCount;
    }
}


class MapFileProcessor implements Runnable
{
    String mapFilePath, mapFileName, mapFileMessage;
    String mapFileLines[];

    boolean fileLoaded, fileValidated;

    ArrayList<Entity> entityList;

    int triggers, triggerBrushes, enemies, teleports, teleportBrushes, details, detailBrushes, 
    groups, groupBrushes, lights, doors, doorBrushes, items, entities, brushes, worldspawnBrushes;

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

                mapFileName = setMapName();
            }
        }
    }

    public String setMapName()
    {
        if (mapFilePath.contains("\\"))
        {
            String[] tokenizedPath = split(mapFilePath, '\\');

            return tokenizedPath[tokenizedPath.length - 1];
        }

        else return mapFilePath;
    }
    
    //Scans the file for entities, creates the entity objects, and adds them to the list
    public void entityProcess()
    {
        //Intitalize two integers that will determine the start and end of an entity block
        int entityStart = 0;
        int entityEnd = 0;

        //Initialize a stack that will be used to determine when an entity ends
        Stack entityCurlyStack = new Stack();

        //Prepare the Entity ArrayList
        entityList = new ArrayList<Entity>();

        //This loop scans through all the lines of the map file top to bottom
        for (int i = 0; i < mapFileLines.length; i++)
        {
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
                    entityEnd = i;

                    Entity mapEntity = new Entity(mapFileLines, entityStart, entityEnd);
                    mapEntity.processEntity();
                    entityList.add(mapEntity);
                }
            }
        }
    }

    public void entityCount()
    {
        int foundTriggers = 0, foundTriggerBrushes = 0, foundEnemies = 0, foundTeleports = 0, 
            foundTeleportBrushes = 0, foundDetails = 0, foundDetailBrushes = 0, foundGroups = 0, 
            foundGroupBrushes = 0, foundLights = 0, foundDoors = 0, foundDoorBrushes = 0, 
            foundEntities = 0, foundBrushes = 0, foundItems = 0, foundWorldspawnBrushes = 0;

        //Checks for the different entity names and increments the corresponding counter
        for (int i = 0; i < entityList.size(); i++)
        {
            String className = entityList.get(i).className();

            if (className.contains("func_door"))
            {
                foundDoors++;
                foundDoorBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("worldspawn"))
            {
                foundWorldspawnBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("func_detail"))
            {
                foundDetails++;
                foundDetailBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("trigger_teleport"))
            {
                foundTeleports++;
                foundTriggers++;

                foundTriggerBrushes += entityList.get(i).brushCount();
                foundTeleportBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("trigger_"))
            {
                foundTriggers++;
                foundTriggerBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("group"))
            {
                foundGroups++;
                foundGroupBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("monster_"))
            {
                foundEnemies++;
            }

            else if (className.contains("light"))
            {
                foundLights++;
            }

            else if (className.contains("item_"))
            {
                foundItems++;
            }

            foundEntities++;
            foundBrushes += entityList.get(i).brushCount();
        }

        //Pass on the values of the local variables to the global ones, the local will be reset to 0
        entities = foundEntities;
        brushes = foundBrushes;
        lights = foundLights;
        enemies = foundEnemies;
        doors = foundDoors;
        doorBrushes = foundDoorBrushes;
        triggers = foundTriggers;
        triggerBrushes = foundTriggerBrushes;
        teleports = foundTeleports;
        teleportBrushes = foundTeleportBrushes;
        details = foundDetails;
        detailBrushes = foundDetailBrushes;
        groups = foundGroups;
        groupBrushes = foundGroupBrushes;
        items = foundItems;
        worldspawnBrushes = foundWorldspawnBrushes;
    }

    public void run()
    {
        mapFileLines = loadStrings(mapFilePath);
        entityProcess();
        entityCount();
    }
}
//A simple method to clear the screen on each frame, avoid ghosting
public void cls()
{
    background(0);
}

//This sets up the font that will be used for displaying text
public void fontSetup(int dividend)
{
    //Load the font used for writing text
    alata = createFont("data/Alata-Regular.ttf", height/dividend);
    textFont(alata);
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
