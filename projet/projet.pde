/**
* Projet Creation Numérique
* Arga Théo & Alisa Hasanli
* (c) 2022
*
* [description projet]
*
**/
import java.lang.Math;
import java.lang.Float;


PImage photo;
Sticks stcks;


boolean draw = true, fps = false;
long framestart,frameend;
float frametime;

int nnn = 1;

//Settings :
boolean USE_OPTIMIZER = true;


float rectLength = 20;
float rectWidth = 3;
float rectOrientation = 125; // °
float angleDeviation = 15; // °
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
        y = (int) Math.floor(random(0 , img.height - 3) + topLeft.y);
        
        
        color tl, tr, bl, br;
        
        tl = img.get(x,y);
        tr = img.get(x + 2,y);
        bl = img.get(x,y + 2);
        br = img.get(x + 2,y + 2);
        
        
        
        
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
        
        
        
        noStroke();
        
        beginShape();
        fill(tl);
        vertex(topLeft.x, topLeft.y, 0);
        fill(tr);
        vertex(topRight.x, topRight.y, 0);
        fill(br);
        vertex(botRight.x, botRight.y, 0);
        fill(bl);
        vertex(botLeft.x,botLeft.y, 0);
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


//================================================================
// PROGRAM SETTINGS AND SETUP
//================================================================

void settings() 
{
    photo = loadImage("img5.jpg");
    int h,w;
    float r = photo.width / (float)photo.height;
    h = (int)(min(displayHeight,displayWidth) * 0.8);
    w = java.lang.Math.round(h * r);
    size(w,h,P3D);
    
    print("h :" + h + " w :" + w + " r :" + r);
    
}


void setup() 
{   
    frameRate(1000);
    background(0);
    colorMode(HSB,100);
    
    
    photo.resize(width,height);
    
    
    
    
    stcks = new Sticks(photo, new PVector(0,0));
    
    
    
    
}



//================================================================
// DRAW LOOP & EVENTS
//================================================================

void keyPressed() {
    if (key == 'a') {
        if (draw) {
            draw = false;
        } else {
            draw = true;
        }
    }
    if (key == 'f') {
        if (fps) {
            fps = false;
        } else {
            fps = true;
        }
    }
}



void draw() {
    
    //Performance optimization depending on machine and fps.
    if (frameCount < 5000 && !fps && USE_OPTIMIZER) {
        framestart = System.nanoTime();
        
    }
    
    //Performance mesuring
    if (fps)
        framestart = System.nanoTime();
    
    
    
    //Draw loop
    if (draw) {
        
        
        
        for (int i = 0; i < nnn;i++) {
            stcks.drawStick();
        }
        
        
    }
    
    
    //Frame end and time calculation
    
    
    if (fps || (frameCount < 5000 &&  USE_OPTIMIZER)) {
        frameend = System.nanoTime();
        frametime = (frameend - framestart) / 100000.0f;
    }
    
    
    //Performance optimization depending on machine and fps.
    if (frameCount < 5000 &&  USE_OPTIMIZER) {
        
        if ((frameRate + 10 < Math.round(1000f / frametime)) && draw && frametime <1.0)
            nnn++; 
    }
    
    //Performance Mesuring
    if (fps) {
        
        
        if (frameCount % 50 == 0)
        {  
            fill(0,0,0);
            rect(0,0,270,40);
            fill(0,0,100);
            textSize(11);
            textAlign(LEFT, TOP);
            text("frametime : " + Math.round(frametime * 100) / 100f + " ms, fps : " + Math.round(frameRate) + ", Sticks/draw = " + nnn + " \n Max theoretical framerate = " + Math.round(1000f / frametime) + "\n" ,0,0);
            
            
        }
    }
}
