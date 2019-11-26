class Entity
{
    //int startLine, endLine;
    String entityLines[];

    Entity(String lines[])
    {
        // startLine = start;
        // endLine = end;
        entityLines = lines;
    }

    String toString()
    {
        //return "Entity Start\t\t" + startLine + "\t\tEntityEnd\t\t" + endLine;
        return "testing";
    }

    void printLines()
    {
        for (int i = 0; i < entityLines.length; i++)
        {
            println(entityLines[i]);
        }
    }
}