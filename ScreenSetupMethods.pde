//A simple method to clear the screen on each frame, avoid ghosting
void cls()
{
    background(0);
}

//This sets up the font that will be used for displaying text
void fontSetup()
{
    //Load the font used for writing text
    alata = createFont("data/Alata-Regular.ttf", width/10);
    textFont(alata);
}