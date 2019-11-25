import java.util.Stack;

class MapFileProcessor
{
    String mapFilePath;
    String mapFileLines[];

    boolean fileLoaded;
    boolean fileValidated;

    ArrayList<Brush> brushList;

    //Empty constructor
    MapFileProcessor() { brushList = new ArrayList<Brush>(); }

    //Prints the path of the map file
    String mapPath()
    {
        return mapFilePath;
    }

    //Takes care of loading the file, calling a validating helper method, and writing the array of lines
    void loadFile(String path)
    {
        mapFilePath = path;
        fileLoaded = true;
        mapFileLines = loadStrings(mapFilePath);

        validateFile();
    }

    //Make sure that the input file is a valid map file
    void validateFile()
    {
        //Check that the file path shows the correct file extension
        if (mapFilePath.substring(mapFilePath.length() - 4).equals(".map"))
        {
            //Check that the map file actually comes from a Trenchbroom Quake map file
            if (mapFileLines[0].equals("// Game: Quake"))
            {
                fileValidated = true;
            }
        }
    }
    
    void processMapFile()
    {
        println(mapFileLines[3]);

        //rawScan();
    }

    void rawScan()
    {
        int curlyStart = 0;
        int curlyEnd = 0;

        Stack curlyStack = new Stack();

        int entityCount = 0;

        for (int i = 0; i < mapFileLines.length; i++)
        {
            System.out.printf("i = %d\n", i);

            if (mapFileLines[i].equals("{") && mapFileLines[i - 1].contains("// entity"))
            {
                System.out.printf("i - 1 = %d\n", i);
                curlyStart = i;
                System.out.printf("pushed at %d\n", i);
                curlyStack.push(i);
            }

            else if (mapFileLines[i].equals("{"))
            {
                System.out.printf("pushed at %d\n", i);
                curlyStack.push(i);
            }

            else if (mapFileLines[i].equals("}"))
            {
                System.out.printf("popped at %d\n", i);
                curlyStack.pop();

                if (curlyStack.empty())
                {
                    System.out.printf("stack now empty at %d\n", i);
                    curlyEnd = i;

                    println("Entity start:\t\t" + curlyStart + "\t\tEntity end:\t\t" + curlyEnd);

                    entityCount++;
                }
            }

            if (entityCount != 0)
            {
                break;
            }
        }

        println(curlyStack);
        println("\nTotal Entities: " + entityCount);
    }
}