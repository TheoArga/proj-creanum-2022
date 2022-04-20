class Options
{
    float new_rectLength;
    float new_rectWidth;
    float new_rectOrientation;
    float new_angleDeviation; 
    float new_rectLengthDeviation; 
    float new_rectWidthDeviation;
    
    public void applyOptions()
    {
        rectLength = new_rectLength;
        rectWidth = new_rectWidth;
        rectOrientation = new_rectOrientation;
        angleDeviation = new_angleDeviation;
        rectLengthDeviation = new_rectLengthDeviation; 
        rectWidthDeviation = new_rectWidthDeviation;
        frameCount = 0;
    }
}
