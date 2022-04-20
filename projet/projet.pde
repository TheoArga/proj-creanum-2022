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

//Global Variables
PImage photo;
Sticks stcks;
PWindow SecondWindow;
boolean draw = true, fps = false;
long framestart,frameend;
float frametime;
int sticksPerFrame = 1;

//Settings :
boolean USE_OPTIMIZER = true;

float rectLength = 7;
float rectWidth = 1;
float rectOrientation = 45; // °
float angleDeviation = 5; // °
float rectLengthDeviation = 0.9; // %
float rectWidthDeviation = 0.1;// %

//================================================================
// PROGRAM SETTINGS AND SETUP
//================================================================

void settings() 
{
    photo = loadImage("img2.png");
    int h,w;
    float r = photo.width / (float)photo.height;
    h = (int)(min(displayHeight,displayWidth) * 0.8);
    w = java.lang.Math.round(h * r);
    size(w,h,P3D);
    
}


void setup() 
{   
    frameRate(1000);
    background(0);
    colorMode(HSB,100);
    
    
    photo.resize(width,height);
    stcks = new Sticks(photo, new PVector(0,0));
    SecondWindow = new PWindow();       
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
        for (int i = 0; i < sticksPerFrame;i++) {
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
        if ((frameRate < Math.round(1000f / frametime)) && draw)
            sticksPerFrame++; 
    }
    
    //Performance Mesuring
    if (fps) {
        if (frameCount % Math.ceil((float)frameRate / 60.0f) == 0)
        {  
            fill(0,0,0);
            rect(0,0,270,40);
            fill(0,0,100);
            textSize(11);
            textAlign(LEFT, TOP);
            text("frametime : " + Math.round(frametime * 100) / 100f + " ms, fps : " + Math.round(frameRate) + ", Sticks/draw = " + sticksPerFrame + " \n Max theoretical framerate = " + Math.round(1000f / frametime) + ", SpS =" + Math.floor(frameRate * sticksPerFrame) + "\n" ,0,0); 
        }
    }
}
