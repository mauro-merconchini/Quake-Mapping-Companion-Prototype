class Entity
{
    int start, end;
    String mapFileLines[];

    MapFileProcessor mapProcc = new MapFileProcessor();



    Entity(String[] mapLines, int startLine, int endLine)
    {
        mapFileLines = mapLines;
        start = startLine;
        end = endLine;
    }

    void wasteTime()
    {
        for (int i = start; i < end; i ++)
        {
            println(mapFileLines[i]);
        }
    }
}