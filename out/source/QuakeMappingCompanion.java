import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class QuakeMappingCompanion extends PApplet {

PShape myShape;

float rotation = 0;

public void setup()
{
    
    myShape = loadShape("teapot.obj");

    surface.setResizable(true);
    background(75);

    stroke(255);
}

public void draw()
{
    ambientLight(102, 102, 102);
    background(75);
    // translate(width/2, height/2);
    // shape(myShape, 0, 0);
    // box(75);

    float orbitRadius= mouseX/2+50;
    float ypos= mouseY/3;
    float xpos= cos(radians(rotation))*orbitRadius;
    float zpos= sin(radians(rotation))*orbitRadius;
    
    camera(xpos, ypos, zpos, 0, 0, 0, 0, -1, 0);

    shape(myShape, 0, 0);

    rotation+=0.5f;

    
}
  public void settings() {  size(1280, 720, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "QuakeMappingCompanion" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
