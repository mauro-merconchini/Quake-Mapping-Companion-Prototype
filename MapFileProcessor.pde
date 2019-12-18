import java.util.Stack;

class MapFileProcessor implements Runnable
{
    String mapFilePath;
    String mapFileLines[];

    boolean fileLoaded, fileValidated;

    ArrayList<Entity> entityList;

    int totalTriggers, totalEnemies, totalTeleports, totalDetails, 
    totalGroups, totalLights, totalDoors, totalEntities, totalBrushes;

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
    
    //Scans the file for entities, creates the entity objects, and adds them to the list
    void entityProcess()
    {
        //Intitalize two integers that will determine the start and end of an entity block
        int entityStart = 0;
        int entityEnd = 0;

        //Initialize a stack that will be used to determine when an entity ends
        Stack entityCurlyStack = new Stack();

        //This loop scans through all the lines of the map file top to bottom
        for (int i = 0; i < mapFileLines.length; i++)
        {
            //This is how you determine the start of an entity block
            if (mapFileLines[i].equals("{") && mapFileLines[i - 1].contains("// entity"))
            {
                //Record the line in which the entity starts
                entityStart = i + 1;

                //Push a curly to the stack
                entityCurlyStack.push(i);
            }

            //Any curly openings need to be pushed to the stack
            else if (mapFileLines[i].equals("{"))
            {
                entityCurlyStack.push(i);
            }

            //Any curly closes need to cause a stack pop
            else if (mapFileLines[i].equals("}"))
            {
                entityCurlyStack.pop();

                //Check if the pop made the stack empty, which means you reached the end of an entity block
                if (entityCurlyStack.empty())
                {
                    entityEnd = i;

                    Entity mapEntity = new Entity(mapFileLines, entityStart, entityEnd);
                    mapEntity.processEntity();
                    entityList.add(mapEntity);
                }
            }
        }
    }


    // THIS NEEDS FIXING, ITS THROWING NULL POINTER EXCEPTIONS
    void entityCount()
    {
        for (int i = 0; i < entityList.size(); i++)
        {
            //String className = entityList.get(i).className();

            // println(entityList.get(i).className());

            // if (entityList.get(i).className().contains("func_door"))
            // {
            //     println("found a door");
            //     totalDoors++;
            // }

            // if (className.contains("func_door"))
            // {
            //     println("found a door");
            //     totalDoors++;
            // }

            // else if (className.contains("func_detail"))
            // {
            //     println("\nFOUND A MAP DETAIL\n");
            //     totalDetails++;
            // }

            // else if (className.contains("trigger_teleport"))
            // {
            //     totalTeleports++;
            //     totalTriggers++;
            // }

            // else if (className.contains("trigger_"))
            // {
            //     totalTriggers++;
            // }

            totalEntities++;
            totalBrushes += entityList.get(i).brushCount();
        }
    }

    int doors()
    {
        return totalDoors;
    }

    int entities()
    {
        return totalEntities;
    }

    int brushes()
    {
        return totalBrushes;
    }

    void run()
    {
        long start = millis();
        
        entityProcess();

        entityCount();

        println("Thread Process Time: " + (millis() - start));
    }
}
