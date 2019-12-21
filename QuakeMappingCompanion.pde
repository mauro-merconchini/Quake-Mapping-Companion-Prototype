//Initialize a font object that will be used to load the custom font
PFont alata;

//Initialize an object that will take care of processing the map file
MapFileProcessor mapProcessor;

//Will run once at the start of the program's life
void setup()
{
    //This makes sure that the window can be resized, both in 2D and 3D
    surface.setResizable(true);

    rectMode(CENTER);

    //Initialize a window for text and graphics to be displayed
    size(800, 600);

    selectInput("Select a .map file to process", "fileSelected");

    mapProcessor = new MapFileProcessor();

    stroke(255);
}

//Will update once per frame, place your drawing routines here
void draw()
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
            line (0, height/6.5, width, height/6.5);
            line(width/2, height/6.5, width/2, height);

            //********************E N T I T I E S*************************************************
            
            //These text methods set up the drawing of names of the entity groups
            textAlign(LEFT);
            text("Enemies", width/8, height/5, width/4.8, height/15);
            text("Doors", width/8, ((height/5 + (height/15 + height/40) * 1)), width/4.8, height/15);
            text("Lights", width/8, ((height/5 + (height/15 + height/40) * 2)), width/4.8, height/15);
            text("Items", width/8, ((height/5 + (height/15 + height/40) * 3)), width/4.8, height/15);
            text("Details", width/8, ((height/5 + (height/15 + height/40) * 4)), width/4.8, height/15);
            text("Groups", width/8, ((height/5 + (height/15 + height/40) * 5)), width/4.8, height/15);
            text("Triggers", width/8, ((height/5 + (height/15 + height/40) * 6)), width/4.8, height/15);
            text("Teleports", width/8, ((height/5 + (height/15 + height/40) * 7)), width/4.8, height/15);
            text("Total", width/8, ((height/5 + (height/15 + height/40) * 8)), width/4.8, height/15);

            //These text methods set up the drawing of entity numeric data
            textAlign(RIGHT);
            text("" + mapProcessor.enemies, (width/8 + width/4.2), height/5, width/4.2, height/15);
            text("" + mapProcessor.doors, (width/8 + width/4.2), ((height/5 + (height/15 + height/40) * 1)), width/4.2, height/15);
            text("" + mapProcessor.lights, (width/8 + width/4.2), ((height/5 + (height/15 + height/40) * 2)), width/4.2, height/15);
            text("" + mapProcessor.items, (width/8 + width/4.2), ((height/5 + (height/15 + height/40) * 3)), width/4.2, height/15);
            text("" + mapProcessor.details, (width/8 + width/4.2), ((height/5 + (height/15 + height/40) * 4)), width/4.2, height/15);
            text("" + mapProcessor.groups, (width/8 + width/4.2), ((height/5 + (height/15 + height/40) * 5)), width/4.2, height/15);
            text("" + mapProcessor.triggers, (width/8 + width/4.2), ((height/5 + (height/15 + height/40) * 6)), width/4.2, height/15);
            text("" + mapProcessor.teleports, (width/8 + width/4.2), ((height/5 + (height/15 + height/40) * 7)), width/4.2, height/15);
            text("" + mapProcessor.entities, (width/8 + width/4.2), ((height/5 + (height/15 + height/40) * 8)), width/4.2, height/15);
            
            //********************B R U S H E S*************************************************

            //These text methods set up the drawing of names of brush types
            textAlign(LEFT);
            text("World", (width/8 + width/2), height/5, width/4.8, height/15);
            text("Doors", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 1)), width/4.8, height/15);
            text("Details", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 2)), width/4.8, height/15);
            text("Groups", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 3)), width/4.8, height/15);
            text("Triggers", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 4)), width/4.8, height/15);
            text("Teleports", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 5)), width/4.8, height/15);
            text("", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 6)), width/4.8, height/15);
            text("", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 7)), width/4.8, height/15);
            text("Total", (width/8 + width/2), ((height/5 + (height/15 + height/40) * 8)), width/4.8, height/15);
            
            //These text methods set up the drawing of brush numeric data
            textAlign(RIGHT);
            text("" + mapProcessor.worldspawnBrushes, ((width/8 + width/4.2) + width/2), height/5, width/4.2, height/15);
            text("" + mapProcessor.doorBrushes, ((width/8 + width/4.2) + width/2), ((height/5 + (height/15 + height/40) * 1)), width/4.2, height/15);
            text("" + mapProcessor.detailBrushes, ((width/8 + width/4.2) + width/2), ((height/5 + (height/15 + height/40) * 2)), width/4.2, height/15);
            text("" + mapProcessor.groupBrushes, ((width/8 + width/4.2) + width/2), ((height/5 + (height/15 + height/40) * 3)), width/4.2, height/15);
            text("" + mapProcessor.triggerBrushes, ((width/8 + width/4.2) + width/2), ((height/5 + (height/15 + height/40) * 4)), width/4.2, height/15);
            text("" + mapProcessor.teleportBrushes, ((width/8 + width/4.2) + width/2), ((height/5 + (height/15 + height/40) * 5)), width/4.2, height/15);
            text("", ((width/8 + width/4.2) + width/2), ((height/5 + (height/15 + height/40) * 6)), width/4.2, height/15);
            text("", ((width/8 + width/4.2) + width/2), ((height/5 + (height/15 + height/40) * 7)), width/4.2, height/15);
            text("" + mapProcessor.brushes, ((width/8 + width/4.2) + width/2), ((height/5 + (height/15 + height/40) * 8)), width/4.2, height/15);

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
void fileSelected(File selection) 
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