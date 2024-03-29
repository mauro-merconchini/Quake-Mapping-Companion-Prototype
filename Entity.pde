import java.util.Scanner;
import java.util.Stack;

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
    void processEntity()
    {
        setClass();
        brushProcess();
    }

    //This method uses a scanner to set the classname of the entity object
    void setClass()
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

    void brushProcess()
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

    String className()
    {
        return entityClass;
    }

    int brushCount()
    {
        return entityBrushCount;
    }
}