//A simple method to clear the screen on each frame, avoid ghosting
void cls()
{
    background(0);
}

//This sets up the font that will be used for displaying text
void fontSetup(int dividend)
{
    //Load the font used for writing text
    alata = createFont("data/Alata-Regular.ttf", height/dividend);
    textFont(alata);
}