/**
 * Projet Creation Numérique
 * Arga Théo & Alisa Hasanli
 * (c) 2022
 *
 * [description projet]
 *
 **/
//Imports
import java.lang.Math;
import java.lang.Float;
import controlP5.*;
import java.util.*;

//Global Variables
PImage photo;
Sticks stcks;
PWindow SecondWindow;
boolean draw = true, fps = false;
long framestart, frameend;
float frametime;
int sticksPerFrame = 1;

//Settings :
boolean USE_OPTIMIZER = true;

int framerate = 1000;
String imageName = "img2.png";
float rectLength = 7;
float rectWidth = 1;
float rectOrientation = 0; // °
float angleDeviation = 0; // °
float rectLengthDeviation = 0.9; // %
float rectWidthDeviation = 0.1;// %

//================================================================
// PROGRAM SETTINGS AND SETUP
//================================================================

void settings() 
{
  photo = loadImage(imageName);
  int h, w;
  float r = photo.width / (float)photo.height;
  h = (int)(min(displayHeight, displayWidth) * 0.8);
  w = java.lang.Math.round(h * r);
  size(w, h, P3D);
}


void setup() 
{   
  surface.setTitle("Image");
  frameRate(framerate);
  background(0);
  colorMode(HSB, 100);
  setDefaultClosePolicy(this, true);


  photo.resize(width, height);
  stcks = new Sticks(photo, new PVector(0, 0));
  SecondWindow = new PWindow();
}


void restartImage()
{
  noLoop();
  sticksPerFrame = 1;
  photo = loadImage(imageName);
  int h, w;
  float r = photo.width / (float)photo.height;
  h = (int)(min(displayHeight, displayWidth) * 0.8);
  w = java.lang.Math.round(h * r);
  surface.setSize(w, h);
  surface.setLocation((displayWidth/2) - (width/2), (displayHeight/2) - (height/2) );
  background(0);
  photo.resize(width, height);
  stcks = new Sticks(photo, new PVector(0, 0));
  frameCount = 1;
  loop();
}

void closeImage() {
  exit();
}


final void setDefaultClosePolicy(PApplet pa, boolean keepOpen) {
  final Object surf = pa.getSurface().getNative();
  final PGraphics canvas = pa.getGraphics();

  if (canvas.isGL()) {
    final com.jogamp.newt.Window w = (com.jogamp.newt.Window) surf;

    for (com.jogamp.newt.event.WindowListener wl : w.getWindowListeners())
      if (wl.toString().startsWith("processing.opengl.PSurfaceJOGL"))
        w.removeWindowListener(wl); 

    w.setDefaultCloseOperation(keepOpen?
      com.jogamp.nativewindow.WindowClosingProtocol.WindowClosingMode
      .DO_NOTHING_ON_CLOSE :
      com.jogamp.nativewindow.WindowClosingProtocol.WindowClosingMode
      .DISPOSE_ON_CLOSE);
  } else if (canvas instanceof processing.awt.PGraphicsJava2D) {
    final javax.swing.JFrame f = (javax.swing.JFrame)
      ((processing.awt.PSurfaceAWT.SmoothCanvas) surf).getFrame(); 

    for (java.awt.event.WindowListener wl : f.getWindowListeners())
      if (wl.toString().startsWith("processing.awt.PSurfaceAWT"))
        f.removeWindowListener(wl);

    f.setDefaultCloseOperation(keepOpen?
      f.DO_NOTHING_ON_CLOSE : f.DISPOSE_ON_CLOSE);
  }
}

//================================================================
// DRAW LOOP & EVENTS
//================================================================

void keyPressed() { // For debug, not used in program by end user
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
  if (key == ESC) {
    key = 0;  // Empêche d'utiliser la touche ESC
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
    for (int i = 0; i < sticksPerFrame; i++) {
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
      fill(0, 0, 0);
      rect(0, 0, 270, 40);
      fill(0, 0, 100);
      textSize(11);
      textAlign(LEFT, TOP);
      text("frametime : " + Math.round(frametime * 100) / 100f + " ms, fps : " + Math.round(frameRate) + ", Sticks/draw = " + sticksPerFrame + " \n Max theoretical framerate = " + Math.round(1000f / frametime) + ", SpS =" + Math.floor(frameRate * sticksPerFrame) + "\n", 0, 0);
    }
  }
}
