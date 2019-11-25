//Initialize a font object that will be used to load the custom font
PFont alata;

//Initialize an object that will take care of processing the map file
MapFileProcessor mapProcessor;

//Will run once at the start of the program's life
void setup()
{
    //This makes sure that the window can be resized, both in 2D and 3D
    surface.setResizable(true);

    //Initialize a 3D window for text and graphics to be displayed
    size(800, 600, P3D);

    selectInput("Select a .map file to process", "fileSelected");

    mapProcessor = new MapFileProcessor();
}

//Will update once per frame, place your drawing routines here
void draw()
{
    cls();
    fontSetup();

    //Only run the following code if a file has been loaded
    if (mapProcessor.fileLoaded)
    {
        //Only run the following code if the file has been validated to be a Trenchbroom Quake map file
        if (mapProcessor.fileValidated)
        {
            
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
void fileSelected(File selection) 
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

        mapProcessor.processFile();
    }
}