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

    int x, y;
    x = (int) Math.floor(random(0, img.width - 3) + topLeft.x);
    y = (int) Math.floor(random(0, img.height - 3) + topLeft.y);

    color tl, tr, bl, br;

    tl = img.get(x, y);
    tr = img.get(x + 2, y);
    bl = img.get(x, y + 2);
    br = img.get(x + 2, y + 2);

    PVector center = new PVector(x + 1.5, y + 1.5);

    float lengthD, widthD;
    lengthD = random(1 - rectLengthDeviation, 1 + rectLengthDeviation);
    widthD = random(1 - rectWidthDeviation, 1 + rectWidthDeviation);

    PVector topLeft = new PVector(center.x - (rectWidth + rectWidth * widthD) / 2, center.y - (rectLength + rectLength * lengthD) / 2);
    PVector topRight = new PVector(center.x + (rectWidth + rectWidth * widthD) / 2, center.y - (rectLength + rectLength * lengthD) / 2);
    PVector botLeft = new PVector(center.x - (rectWidth + rectWidth * widthD) / 2, center.y + (rectLength + rectLength * lengthD) / 2);
    PVector botRight = new PVector(center.x + (rectWidth + rectWidth * widthD) / 2, center.y + (rectLength + rectLength * lengthD) / 2);

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
    vertex(botLeft.x, botLeft.y, 0);
    endShape(CLOSE);
  }

  private PVector rotateRectVertex(PVector pos, PVector ctr, float angle)
  {

    double angleRad = angle * (PI / 180f);

    PVector npos = new PVector(0.0, 0.0);

    double x1 = pos.x -  ctr.x;
    double y1 = pos.y - ctr.y;
    npos.x = (float)(x1 * Math.cos(angleRad) - y1 * Math.sin(angleRad));
    npos.y = (float)(x1 * Math.sin(angleRad) + y1 * Math.cos(angleRad));
    npos.x += ctr.x;
    npos.y += ctr.y;

    return npos;
  }
}
