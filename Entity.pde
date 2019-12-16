import java.util.Scanner;
import java.util.Stack;

class Entity
{
    //These integers will define where the scanning process in the mapFileLines array begins and ends
    int start, end;
    
    //This will be a carbomn copy of the mapFileLines array that is used by the MapFileProcessor class, but it will be limited with a range of lines that it can scan
    String mapFileLines[];

    String entityClass;

    ArrayList<Brush> brushList;

    Entity(String[] mapLines, int startLine, int endLine)
    {
        mapFileLines = mapLines;
        start = startLine;
        end = endLine;

        brushList = new ArrayList<Brush>();
    }

    //This method calls helper methods to perform all the operations of processing an entity
    void processEntity()
    {
        setClass();
        brushScan();
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

    void brushScan()
    {
        int brushStart = 0;
        int brushEnd = 0;

         //Initialize a stack that will be used to determine when a brush block ends
        Stack brushCurlyStack = new Stack();

        for (int i = start; i < end; i++)
        {
            //This is how you determine the start of a brush block
            if (mapFileLines[i].equals("{") && mapFileLines[i - 1].contains("// brush"))
            {
                //Record the start of the brush block
                brushStart = i + 1;

                brushCurlyStack.push(i);
            }

            //Any curly closes need to cause a stack pop
            else if (mapFileLines[i].equals("}"))
            {
                brushCurlyStack.pop();

                //Check if the pop made the stack empty, which means you reached the end of an entity block
                if (brushCurlyStack.empty())
                {
                    //Record the end of the brush block
                    brushEnd = i;

                    Brush entityBrush = new Brush(mapFileLines, brushStart, brushEnd);
                    brushList.add(entityBrush);
                }
            }
        }
    }
}