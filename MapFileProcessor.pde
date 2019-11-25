class MapFileProcessor
{
    String mapFilePath;
    String mapFileLines[];

    boolean fileLoaded;
    boolean fileValidated;

    //Empty constructor
    MapFileProcessor() {}

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
    
    void processFile()
    {
        processBrushes();
    }
    
    void processBrushes()
    {
        for (int i = 0; i < mapFileLines.length; i++)
        {
            if (mapFileLines[i].contains("brush"))
            {
                println("Brush at line " + i);
            }
        }
    }
}