class Options
{
  public ControlP5 cp5;


  //Settings :
  private boolean new_USE_OPTIMIZER;
  private String new_imageName;
  private float new_rectLength;
  private float new_rectWidth;
  private float new_rectOrientation;
  private float new_angleDeviation; 
  private float new_rectLengthDeviation; 
  private float new_rectWidthDeviation;


  public Options(final PApplet theParent)
  {
    cp5 = new ControlP5(theParent);
  }

  private void applyOptions()
  {
    USE_OPTIMIZER = new_USE_OPTIMIZER;
    rectLength = new_rectLength;
    rectWidth = new_rectWidth;
    rectOrientation = new_rectOrientation;
    angleDeviation = new_angleDeviation;
    rectLengthDeviation = new_rectLengthDeviation; 
    rectWidthDeviation = new_rectWidthDeviation;

    restartImage();
  }



  public void optionsSetup() {

    List images = Arrays.asList("img2.png", "img3.jpg", "img4.png", "img5.jpg");


    cp5.addButton("Apply Settings")
      .setValue(0)
      .setPosition(25, 10)
      .setSize(300, 10);


    cp5.addScrollableList("Image Selection")
      .setPosition(25, 110)
      .setSize(300, 100)
      .setBarHeight(20)
      .setItemHeight(20)
      .addItems(images)
      .setType(ScrollableList.DROPDOWN);
  }


}
