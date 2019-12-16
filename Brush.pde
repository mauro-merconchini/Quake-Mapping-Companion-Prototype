class Brush
{
    String mapFileLines[];
    int start, end;

    String texture;
    boolean isWorldSpawn;
    boolean isDoor;
    boolean isTrigger;
    boolean isDetail;
    boolean isGroup;

    Brush(String[] mapLines, int brushStart, int brushEnd)
    {
        mapFileLines = mapLines;
        start = brushStart;
        end = brushEnd;
    }
}