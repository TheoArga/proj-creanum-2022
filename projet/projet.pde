/**
* Projet Creation Numérique
* Arga Théo & Alisa Hasanli
* (c) 2022
*
* [description projet]
*
**/

PImage photo;

//Settings :
float rectLength = 25;
float rectWidth = 10;
float rectOrientation = 0; // °
float angleDeviation = 5; // °
float rectLengthDeviation = 0.20; // %
float rectWidthDeviation = 0.20;// %


class Sticks
{
    private PImage img;
    private PVector topLeft;
    
    public sticks(PImage im, PVector topLeftCorner)
    {
        img = im;
        topLeft = topLeftCorner;
    }
    
    public drawStick()
    {
        int x,y;
        x = math.floor(random(0 , img.width - 3) + topLeft.x);
        y = math.floor(random(0 , img.width - 3) + topLeft.y);
        color cTL, cTR , cBL, cBR;
        
        PVector center = new PVector(x + 1.5 ,y + 1.5);
        
        
    }
    
}

class Options
{
    float new_rectLength;
    float new_rectWidth;
    float new_rectOrientation;
    float new_angleDeviation; 
    float new_rectLengthDeviation; 
    float new_rectWidthDeviation;
    
    
    
    public applyOptions()
    {
        rectLength = new_rectLength;
        rectWidth = new_rectWidth;
        rectOrientation = new_rectOrientation;
        angleDeviation = new_angleDeviation;
        rectLengthDeviation = new_rectLengthDeviation; 
        rectWidthDeviation = new_rectWidthDeviation;
        
    }
}

void settings() 
{
    photo = loadImage("img2.png");
    int h,w;
    float r = photo.width / (float)photo.height;
    h = (int)(min(displayHeight,displayWidth) * 0.8);
    w = java.lang.Math.round(h * r);
    size(w,h,P2D);
    
    print("h :" + h + " w :" + w + " r :" + r);
    
}


void setup() 
{
    background(0);
    colorMode(HSB,100);
    
}

void draw() {
    photo.resize(width,height);
    image(photo,0,0);
}
