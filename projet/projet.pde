/**
* Projet Creation Numérique
* Arga Théo & Alisa Hasanli
* (c) 2022
*
* [description projet]
*
**/
import java.lang.Math;


PImage photo;
Sticks stcks;
boolean draw = true;

//Settings :
float rectLength = 45;
float rectWidth = 7;
float rectOrientation = 0; // °
float angleDeviation = 90; // °
float rectLengthDeviation = 0.20; // %
float rectWidthDeviation = 0.20;// %

class Sticks
{
    private PImage img;
    private PVector topLeft;
    
    public Sticks(PImage im, PVector topLeftCorner)
    {
        img = im;
        topLeft = topLeftCorner;
    }
    
    public void drawStick()
    {
        
        
        int x,y;
        x = (int) Math.floor(random(0 , img.width - 3) + topLeft.x);
        y = (int) Math.floor(random(0 , img.width - 3) + topLeft.y);
        
        
        color tl, tr, bl, br;
        
        tl = photo.get(x,y);
        tr = photo.get(x + 2,y);
        bl = photo.get(x,y + 2);
        br = photo.get(x + 2,y + 2);
        
        
        
        
        PVector center = new PVector(x + 1.5 ,y + 1.5);
        
        PVector topLeft = new PVector(center.x - rectWidth / 2, center.y - rectLength / 2);
        PVector topRight = new PVector(center.x + rectWidth / 2, center.y - rectLength / 2);
        PVector botLeft = new PVector(center.x - rectWidth / 2, center.y + rectLength / 2);
        PVector botRight = new PVector(center.x + rectWidth / 2, center.y + rectLength / 2);
        
        float angleStick = rectOrientation + random( -angleDeviation, angleDeviation);
        
        topLeft = rotateRectVertex(topLeft, center, angleStick);
        topRight = rotateRectVertex(topRight, center, angleStick);
        botLeft = rotateRectVertex(botLeft, center, angleStick);
        botRight = rotateRectVertex(botRight, center, angleStick);
        
        
        
        beginShape();
        fill(tl);
        vertex(topLeft.x, topLeft.y);
        fill(tr);
        vertex(topRight.x, topRight.y);
        fill(br);
        vertex(botRight.x, botRight.y);
        fill(bl);
        vertex(botLeft.x,botLeft.y);
        endShape(CLOSE);
        
    }
    
    private PVector rotateRectVertex(PVector pos, PVector ctr, float angle)
        {
        
        double angleRad = angle * (PI / 180f);
        
        PVector npos = new PVector(0.0,0.0);
        
        double x1 = pos.x -  ctr.x;
        double y1 = pos.y - ctr.y;
        npos.x = (float)(x1 * Math.cos(angleRad) - y1 * Math.sin(angleRad));
        npos.y = (float)(x1 * Math.sin(angleRad) + y1 * Math.cos(angleRad));
        npos.x += ctr.x;
        npos.y += ctr.y;
        
        return npos;
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
    
    
    
    public void applyOptions()
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
    size(w,h,P3D);
    
    print("h :" + h + " w :" + w + " r :" + r);
    
}


void setup() 
{
    background(0);
    colorMode(HSB,100);
    photo.loadPixels();
    photo.resize(width,height);
    //image(photo,0,0);
    stcks = new Sticks(photo, new PVector(0,0));
    noStroke();
    frameRate(1000);
    
    
}

void keyPressed() {
    if (key == 'a') {
        if (draw) {
            draw = false;
        } else {
            draw = true;
        }
    }
}



void draw() {
    if (draw) {
        //long framestart = System.nanoTime();
        
        
        
        stcks.drawStick();
        
        
        /*
        longframeend = System.nanoTime();
        float frametime = (frameend - framestart) / 100000.0f;
        
        if ((int)frameCount % (int)frameRate == 0) {
        
        print("frametime : " + frametime + " ms, fps : " + frameRate + " \n Max theoretical framerate = " + (1000f / frametime)  + "\n");
    }
        
        */
        
    }
}
