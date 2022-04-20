class Button {

  String name;
  color defaultColor, rectColor, overColor;
  float xpos, ypos, rectWidth, rectHeight, roundedCornerSize;
  PFont buttonFont;
  color c2;
  PApplet parent;

  Button(String _name, float _xpos, float _ypos, float _rectWidth, float _rectHeight, PApplet parent) {
    this.parent = parent;
    this.name = _name;
    this.xpos = _xpos;
    this.ypos = _ypos;
    this.rectWidth = _rectWidth;
    this.rectHeight = _rectHeight;
    this.roundedCornerSize = 5;
    this.buttonFont = createFont("Calibri", 15);
  }

  // Display the button
  void display() {   
    parent.rectMode(CENTER); //Draw the rectangle representing the button
    if (over()) {
      c2=color(0,0,99);
    } else {
      c2=color(0,0,1);
    }

    parent.noStroke();               
    parent.fill(c2); 
    parent.rect(xpos, ypos, rectWidth, rectHeight, roundedCornerSize);

    // Place the name of the button 
    parent.fill(0);
    parent.textFont(buttonFont);
    parent.textAlign(CENTER, CENTER);
    parent.text(this.name, this.xpos, this.ypos-2);
  }  

  // Function to determine if mouser is over the button
  boolean over() {
    return (parent.mouseX >= xpos-rectWidth/2 && parent.mouseX <= xpos+rectWidth/2 && 
      parent.mouseY >= ypos-rectHeight/2 && parent.mouseY <= ypos+rectHeight/2) ;
  }
}
