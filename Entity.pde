import java.util.Scanner;
import java.util.Stack;

class Entity
{
    //These integers will define where the scanning process in the mapFileLines array begins and ends
    int start, end;
    
    //This will be a carbomn copy of the mapFileLines array that is used by the MapFileProcessor class, but it will be limited with a range of lines that it can scan
    String mapFileLines[];

    String entityClass;

    StringList textureList;

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
        if (mapFileLines[start].contains("classname"))
        {
            Scanner classScanner = new Scanner(mapFileLines[start]);

            //This gets rid of "classname" which is always going to be the first token of the line
            classScanner.next();

            //This makes sure that you get rid of the quotation marks in the classname
            String tempString = classScanner.next();
            entityClass = tempString.substring(1, (tempString.length() - 1));
        }
    }

    void brushProcess()
    {
        for (int i = start; i < end; i++)
        {
            //This is how you determine the start of a brush block
            if (mapFileLines[i].equals("{") && mapFileLines[i - 1].contains("// brush"))
            {
                //Increment i by 1 which skips the { and puts the for loop at the first line of the brush block
                i++;             

                //Code block inside this loop will run for the entire brush block
                while (!mapFileLines[i + 1].equals("}"))
                {
                    Scanner textureScanner = new Scanner(mapFileLines[i]);
                    String textureName = "";

                    for (int j = 0; j < 16; j++)
                    {
                        textureName = textureScanner.next();
                    }

                    textureList.append(textureName);

                    i++;
                }
            }
        }
    }
}