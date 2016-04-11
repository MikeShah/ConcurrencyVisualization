/*
    Purpose: This class serves as a window to display widgets.
*/


public class ControlsPanel extends PApplet {
  

  // Our control panel
  ControlP5 widgets;

  public int HilbertCurveValue = 4;
  
  //    Build the GUI for the Details Pane
  
  void initGUI(){
      widgets = new ControlP5(this);

      // create a new button with name 'buttonA'
      widgets.addButton("buttonA")
         .setValue(0)
         .setPosition(0,0)
         .setSize(200,19)
         ;
         
      // add a horizontal sliders, the value of this slider will be linked
      // to variable 'sliderValue' 
      widgets.addSlider("HilbertCurveValue")
         .setPosition(5,20)
         .setRange(1,11)
         .setValue(4)
         .setNumberOfTickMarks(10)
         ;
  }
  
  public ControlsPanel() {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);    
    // Setup the GUI
    initGUI();
  }

  public void settings() {
    size(200, 320, P3D);
  }
  public void setup() { 
    smooth();
    println("setup Controls Panel");
    surface.setTitle("Controls Panel");
    surface.setLocation(800, 0);
    frameRate(60);
  }

  public void draw() {
    if(widgets!=null){
      background(145,160,176);
    }
  }
  
  void buttonA(){
    println("test");
  }
    
}