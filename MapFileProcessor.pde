import java.util.Stack;

class MapFileProcessor
{
    String mapFilePath;
    String mapFileLines[];

    boolean fileLoaded, fileValidated;

    ArrayList<Entity> entityList;

    //Empty constructor
    MapFileProcessor() { entityList = new ArrayList<Entity>(); }

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
    
    //Will call helper methods to scan the file and collect information
    void processMapFile()
    {
        entityScan();
    }

    //Scans the file for entities, creates the entity objects, and adds them to the list
    void entityScan()
    {
        int entityStart = 0;
        int entityEnd = 0;

        Stack entityCurlyStack = new Stack();

        for (int i = 0; i < mapFileLines.length; i++)
        {
            Entity tempEntity;

            if (mapFileLines[i].equals("{") && mapFileLines[i - 1].contains("// entity"))
            {
                entityStart = i + 1;
                entityCurlyStack.push(i);
            }

            else if (mapFileLines[i].equals("{"))
            {
                entityCurlyStack.push(i);
            }

            else if (mapFileLines[i].equals("}"))
            {
                entityCurlyStack.pop();

                if (entityCurlyStack.empty())
                {
                    int entityBlockLength = entityEnd - entityStart;
                    String entityLines[] = new String[entityBlockLength];

                    int copyLocation = entityStart;

                    for (int j = 0; j < entityLines.length; j++)
                    {
                        entityLines[i] = mapFileLines[copyLocation];
                        copyLocation++;
                    }

                    tempEntity = new Entity(entityLines);
                    entityList.add(tempEntity);
                }
            }
        }
        
        entityList.get(1).printLines();
    }
}