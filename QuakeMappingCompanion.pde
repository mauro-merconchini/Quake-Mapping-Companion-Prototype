//Library responsible for the file drag-n-drop functionality
import drop.*;

//String mapFileLocation;

//Initialize an array of strings that will hold the map file line by line
String mapFileLines[];

//Initialize a font object that will be used to load the custom font
PFont alata;

//Initialize an object that will handle drag-n-drop
SDrop drop;

void setup()
{
    //This makes sure that the window can be resized, both in 2D and 3D
    surface.setResizable(true);

    //Initialize a 3D window for text and graphics to be displayed
    size(800, 600);

    drop = new SDrop(this);

    //Populate the array of strings with the lines of the map file
    //mapFileLines = loadStrings("data/endofsolace.map");
}

void draw()
{
    cls();
    fontSetup();
    
    textAlign(CENTER);
    text("drag and drop your map file!", width/8, height/8, width-width/5, height-height/5);

    noLoop();
}

//A simple method to clear the screen on each frame, avoid ghosting
void cls()
{
    background(0);
}

void fontSetup()
{
    //Load the font used for writing text
    alata = createFont("Alata-Regular.ttf", width/10);
    textFont(alata);
}

void dropEvent(DropEvent theDropEvent) 
{
    mapFileLines = loadStrings(theDropEvent.file());
    writeFile();
}

void writeFile()
{
    println(mapFileLines);
}