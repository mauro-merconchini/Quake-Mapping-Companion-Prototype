
//Initialize an array of strings that will hold the map file line by line
String mapFileLines[];
PFont alata;

void setup()
{
    //This makes sure that the window can be resized, both in 2D and 3D
    surface.setResizable(true);

    //Initialize a 3D window for text and graphics to be displayed
    size(800, 600, P3D);

    //Populate the array of strings with the lines of the map file
    mapFileLines = loadStrings("data/endofsolace.map");
}

void draw()
{
    cls();
    fontSetup();
    
    textAlign(CENTER);
    text("Hello World!", width/2, height/2);
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