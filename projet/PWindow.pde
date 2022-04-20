/**
 * Projet Creation Numérique
 * Arga Théo & Alisa Hasanli
 * (c) 2022
 *
 * [description projet]
 *
 **/

/**
 * Class used for drawing a secondary window
 */
class PWindow extends PApplet
{   

  /**
   * Option Class used to draw and choose options
   */
  Options opt;

  /**
   * Creates the window and runs its settings, setup and draw functions
   */
  public PWindow() 
  {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

//================================================================
// PROGRAM SETTINGS AND SETUP
//================================================================

  void settings() {
    size(350, 350, P2D);
  }


  void setup() {
    background(#330F5A);
    surface.setLocation(20, 20);
    surface.setTitle("Options");
    setDefaultClosePolicy(this, true);
    frameRate(20);

    opt = new Options(this, this);
    opt.optionsSetup();
  }

  //Prevents the window from closing when the red cross is pressed
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

  void draw() {
    background(#330F5A);
  }

  public void closeOptions() {
    exit();
  }

  void keyPressed() {
    if (key == ESC) {
      key = 0;  // Prevents from using escape key for closing
    }
  }



  
}
