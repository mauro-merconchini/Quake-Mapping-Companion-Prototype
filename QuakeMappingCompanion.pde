//Initialize an array of strings that will hold the map file line by line
String mapFileLines[];

String mapFileLocation;

//Initialize a font object that will be used to load the custom font
PFont alata;

MapFileProcessor mapProcessor;

void setup()
{
    //This makes sure that the window can be resized, both in 2D and 3D
    surface.setResizable(true);

    //Initialize a 3D window for text and graphics to be displayed
    size(800, 600, P3D);

    selectInput("Select a .map file to process", "fileSelected");

    //Populate the array of strings with the lines of the map file
    //mapFileLines = loadStrings(mapFileLocation);
}

void draw()
{
    cls();
    fontSetup();

    textAlign(CENTER);
    text("MAIN WINDOW", width/8, height/8, width-width/5, height-height/5);
}

void fileSelected(File selection) 
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