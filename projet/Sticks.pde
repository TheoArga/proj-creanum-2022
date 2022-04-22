/**
 * Projet Creation Numérique
 * Arga Théo & Alisa Hasanli
 * (c) 2022
 *
 * Ce projet a pour but de permettre de recréer une image à partir de bâtonnets, ce qui lui donne un effet artistique.
 *
 **/


/**
* Class used for creating an image and drawing the sticks
*/
class Sticks
{
  /**
  * The image to reproduce
  */
  private PImage img;

  /**
  * The top left corner of the image
  */
  private PVector topLeft;

  // Constructor
  public Sticks(PImage im, PVector topLeftCorner)
  {
    img = im;
    topLeft = topLeftCorner;
  }


  /**
  * The method used to draw the sticks
  */
  public void drawStick()
  {
    //Choses a random pixel in the image
    int x, y;
    x = (int) Math.floor(random(0, img.width - 3) + topLeft.x);
    y = (int) Math.floor(random(0, img.height - 3) + topLeft.y);

    //gets the color of the corner of a 3x3 pixel area (its topleft being the random pixel) to choose the gradient of the stick
    color tl, tr, bl, br;

    tl = img.get(x, y);
    tr = img.get(x + 2, y);
    bl = img.get(x, y + 2);
    br = img.get(x + 2, y + 2);

    //center of the rectanle to be drawn, selected to be the center of the 3x3 pixel square
    PVector center = new PVector(x + 1.5, y + 1.5);

    //Computes the size of the stick to be drawn, with random deviation.
    float lengthD, widthD;
    lengthD = random(1 - rectLengthDeviation, 1 + rectLengthDeviation);
    widthD = random(1 - rectWidthDeviation, 1 + rectWidthDeviation);

    //Creates the 4 vertices of the rectangle 
    PVector topLeft = new PVector(center.x - (rectWidth + rectWidth * widthD) / 2, center.y - (rectLength + rectLength * lengthD) / 2);
    PVector topRight = new PVector(center.x + (rectWidth + rectWidth * widthD) / 2, center.y - (rectLength + rectLength * lengthD) / 2);
    PVector botLeft = new PVector(center.x - (rectWidth + rectWidth * widthD) / 2, center.y + (rectLength + rectLength * lengthD) / 2);
    PVector botRight = new PVector(center.x + (rectWidth + rectWidth * widthD) / 2, center.y + (rectLength + rectLength * lengthD) / 2);

    //Computes the orientation of the stick to be drawn, with random deviation
    float angleStick = rectOrientation + random( -angleDeviation, angleDeviation);

    //Rotates the stick's vertices
    topLeft = rotateRectVertex(topLeft, center, angleStick);
    topRight = rotateRectVertex(topRight, center, angleStick);
    botLeft = rotateRectVertex(botLeft, center, angleStick);
    botRight = rotateRectVertex(botRight, center, angleStick);


    //Disables strokes for the stick
    noStroke();

    //Draws the shape
    beginShape();
    fill(tl);
    vertex(topLeft.x, topLeft.y, 0);
    fill(tr);
    vertex(topRight.x, topRight.y, 0);
    fill(br);
    vertex(botRight.x, botRight.y, 0);
    fill(bl);
    vertex(botLeft.x, botLeft.y, 0);
    endShape(CLOSE);
  }


  /**
  *Rotates a vertex around a specified center
  */
  private PVector rotateRectVertex(PVector pos, PVector ctr, float angle)
  {
    //angle is converted to radians
    double angleRad = angle * (PI / 180f);

    PVector npos = new PVector(0.0, 0.0);

    //Moves vertex position to origin
    double x1 = pos.x -  ctr.x;
    double y1 = pos.y - ctr.y;
    //Does the rotation
    npos.x = (float)(x1 * Math.cos(angleRad) - y1 * Math.sin(angleRad));
    npos.y = (float)(x1 * Math.sin(angleRad) + y1 * Math.cos(angleRad));
    //Moves vertex back to around its center
    npos.x += ctr.x;
    npos.y += ctr.y;

    return npos;
  }
}
