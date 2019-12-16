class Entity
{
    //These integers will define where the scanning process in the mapFileLines array begins and ends
    int start, end;
    
    //This will be a carbomn copy of the mapFileLines array that is used by the MapFileProcessor class, but it will be limited with a range of lines that it can scan
    String mapFileLines[];

    Entity(String[] mapLines, int startLine, int endLine)
    {
        mapFileLines = mapLines;
        start = startLine;
        end = endLine;
    }

    void wasteTime()
    {
        println("you have called the wasteTime function");
        println("mapFileLines has a size of " + mapFileLines.length);


        println("start: " + start);
        println("end: " + end + "\n");
        for (int i = start; i < end; i++)
        {
            println(mapFileLines[i]);
        }
    }
}