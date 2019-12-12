class Entity
{
    int start, end;
    String mapFile[];

    Entity(String mapFileLines[], int startLine, int endLine)
    {
        mapFile = mapFileLines;
        start = startLine;
        end = endLine;
    }

    void wasteTime()
    {
        for (int i = start; i < end + 1; i++)
        {
            println("a");
        }
    }
}