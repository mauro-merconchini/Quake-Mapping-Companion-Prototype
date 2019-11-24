
//Initialize an array of strings that will hold the .map file line by line
String mapFileLines[];

void setup()
{
    //This makes sure that the window can be resized, both in 2D and 3D
    surface.setResizable(true);

    //Initialize a 3D window for text and graphics to be displayed
    size(800, 600, P3D);

    mapFileLines = loadStrings("endofsolace.map");
}

void draw()
{
    cls();
}

//A simple method to clear the screen on each frame, avoid ghosting
void cls()
{
    background(0);
}