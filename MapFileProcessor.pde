import java.util.Stack;

class MapFileProcessor implements Runnable
{
    String mapFilePath, mapFileName, mapFileMessage;
    String mapFileLines[];

    boolean fileLoaded, fileValidated;

    ArrayList<Entity> entityList;

    int triggers, triggerBrushes, enemies, teleports, teleportBrushes, details, detailBrushes, 
    groups, groupBrushes, lights, doors, doorBrushes, items, entities, brushes, worldspawnBrushes;

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

                mapFileName = setMapName();
            }
        }
    }

    String setMapName()
    {
        if (mapFilePath.contains("\\"))
        {
            String[] tokenizedPath = split(mapFilePath, '\\');

            return tokenizedPath[tokenizedPath.length - 1];
        }

        else return mapFilePath;
    }
    
    //Scans the file for entities, creates the entity objects, and adds them to the list
    void entityProcess()
    {
        //Intitalize two integers that will determine the start and end of an entity block
        int entityStart = 0;
        int entityEnd = 0;

        //Initialize a stack that will be used to determine when an entity ends
        Stack entityCurlyStack = new Stack();

        //Prepare the Entity ArrayList
        entityList = new ArrayList<Entity>();

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

    void entityCount()
    {
        int foundTriggers = 0, foundTriggerBrushes = 0, foundEnemies = 0, foundTeleports = 0, 
            foundTeleportBrushes = 0, foundDetails = 0, foundDetailBrushes = 0, foundGroups = 0, 
            foundGroupBrushes = 0, foundLights = 0, foundDoors = 0, foundDoorBrushes = 0, 
            foundEntities = 0, foundBrushes = 0, foundItems = 0, foundWorldspawnBrushes = 0;

        //Checks for the different entity names and increments the corresponding counter
        for (int i = 0; i < entityList.size(); i++)
        {
            String className = entityList.get(i).className();

            if (className.contains("func_door"))
            {
                foundDoors++;
                foundDoorBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("worldspawn"))
            {
                foundWorldspawnBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("func_detail"))
            {
                foundDetails++;
                foundDetailBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("trigger_teleport"))
            {
                foundTeleports++;
                foundTriggers++;

                foundTriggerBrushes += entityList.get(i).brushCount();
                foundTeleportBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("trigger_"))
            {
                foundTriggers++;
                foundTriggerBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("group"))
            {
                foundGroups++;
                foundGroupBrushes += entityList.get(i).brushCount();
            }

            else if (className.contains("monster_"))
            {
                foundEnemies++;
            }

            else if (className.contains("light"))
            {
                foundLights++;
            }

            else if (className.contains("item_"))
            {
                foundItems++;
            }

            foundEntities++;
            foundBrushes += entityList.get(i).brushCount();
        }

        //Pass on the values of the local variables to the global ones, the local will be reset to 0
        entities = foundEntities;
        brushes = foundBrushes;
        lights = foundLights;
        enemies = foundEnemies;
        doors = foundDoors;
        doorBrushes = foundDoorBrushes;
        triggers = foundTriggers;
        triggerBrushes = foundTriggerBrushes;
        teleports = foundTeleports;
        teleportBrushes = foundTeleportBrushes;
        details = foundDetails;
        detailBrushes = foundDetailBrushes;
        groups = foundGroups;
        groupBrushes = foundGroupBrushes;
        items = foundItems;
        worldspawnBrushes = foundWorldspawnBrushes;
    }

    void run()
    {
        mapFileLines = loadStrings(mapFilePath);
        entityProcess();
        entityCount();
    }
}
