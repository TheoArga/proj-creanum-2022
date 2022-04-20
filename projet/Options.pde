class Options
{
  List<String> images;
  PWindow parent;
  public ControlP5 cp5;
  ScrollableList imagesList;
  CheckBox optimizerCheck;
  Slider new_rectLength, new_rectWidth, new_rectLengthDeviation, new_rectWidthDeviation;
  Knob new_rectOrientation, new_angleDeviation;



  public Options(final PApplet theParent, final PWindow parentW)
  {
    cp5 = new ControlP5(theParent);
    parent = parentW;
  }

  private void applyOptions()
  {
    imageName = images.get((int)imagesList.getValue());
    USE_OPTIMIZER = (int)optimizerCheck.getArrayValue()[0] == 1 ? true : false;
    rectLength = new_rectLength.getValue();
    rectWidth = new_rectWidth.getValue();
    rectLengthDeviation = new_rectLengthDeviation.getValue() / 100;
    rectWidthDeviation = new_rectWidthDeviation.getValue() / 100;
    rectOrientation = new_rectOrientation.getValue();
    angleDeviation = new_angleDeviation.getValue() ; 


    restartImage();
  }


  public void optionsSetup() {

    images = Arrays.asList("img2.png", "img3.jpg", "img4.png", "img5.jpg");


    cp5.addButton("Apply Settings")
      .setValue(0)
      .setPosition(25, 5)
      .setSize(300, 20)
      .addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        if (event.getAction() == ControlP5.ACTION_RELEASED) {
          applyOptions();
        }
      }
    }
    );

    optimizerCheck = cp5.addCheckBox("Use Optimizer")
      .setPosition(25, 55)
      .setSize(20, 20)
      .setItemsPerRow(1)
      .setSpacingColumn(0)
      .setSpacingRow(0)
      .addItem("Use Optimizer ?", 0)
      .activateAll();

    new_rectLength = cp5.addSlider("Rectangle Length")
      .setPosition(25, 85)
      .setSize(185, 20)
      .setRange(0, 100)
      .setValue(rectLength);

    new_rectWidth = cp5.addSlider("Rectangle Width")
      .setPosition(25, 110)
      .setSize(185, 20)
      .setRange(0, 100)
      .setValue(rectWidth);

    new_rectLengthDeviation = cp5.addSlider("% Rectangle Length Deviation")
      .setPosition(25, 135)
      .setSize(185, 20)
      .setRange(0, 100)
      .setValue(rectLengthDeviation*100);

    new_rectWidthDeviation = cp5.addSlider("% Rectangle Width Deviation")
      .setPosition(25, 160)
      .setSize(185, 20)
      .setRange(0, 100)
      .setValue(rectWidthDeviation*100);

    new_rectOrientation = cp5.addKnob("° Rectangle Orientation")
      .setRange(0, 360)
      .setValue(rectOrientation)
      .setPosition(65, 195)
      .setRadius(50)
      .setNumberOfTickMarks(36)
      .setTickMarkLength(1)
      .snapToTickMarks(false)
      .setColorForeground(color(#CF9030))
      .setColorBackground(color(#9030CF))
      .setColorActive(color(#30CF90))
      .setDragDirection(Knob.HORIZONTAL)
      .setStartAngle(PI/2)
      .setAngleRange(TWO_PI);

    new_angleDeviation = cp5.addKnob("° Rectangle Deviation")
      .setRange(0, 360)
      .setValue(rectOrientation)
      .setPosition(185, 195)
      .setRadius(50)
      .setNumberOfTickMarks(36)
      .setTickMarkLength(1)
      .snapToTickMarks(false)
      .setColorForeground(color(#CF9030))
      .setColorBackground(color(#9030CF))
      .setColorActive(color(#30CF90))
      .setDragDirection(Knob.HORIZONTAL)
      .setStartAngle(PI/2)
      .setAngleRange(TWO_PI);


    cp5.addButton("QUIT")
      .setValue(0)
      .setColorBackground(color(#FF7500))
      .setColorActive(color(#FF000A))
      .setPosition(25, 310)
      .setSize(300, 35)
      .addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        if (event.getAction() == ControlP5.ACTION_RELEASED) {
          parent.closeOptions();
          closeImage();
        }
      }
    }
    );


    //DOIT etre ajouté en dernier pour etre dessiné AU DESSUS des autres options lorsque déroulé
    imagesList = cp5.addScrollableList("Image Selection")
      .setPosition(25, 30)
      .setSize(300, 100)
      .setBarHeight(20)
      .setItemHeight(20)
      .addItems(images)
      .setType(ScrollableList.DROPDOWN)
      .close();
  }
}
