/*
    Purpose: This class serves as a window to display widgets.
*/


public class ControlsPanel extends PApplet {
  

  // Our control panel
  ControlP5 widgets;

  
  //    Build the GUI for the Details Pane
  
  void initGUI(){
      widgets = new ControlP5(this);
      

      // create a new button with name 'buttonA'
      widgets.addButton("buttonA")
         .setValue(0)
         .setPosition(0,0)
         .setSize(200,19)
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
    smooth();
  }
  public void setup() { 
    println("setup Controls Panel");
    surface.setTitle("Controls Panel");
    surface.setLocation(600, 0);
    frameRate(60);
  }

  public void draw() {
    background(145,160,176);
  }
  
  void buttonA(){
    println("test");
  }
    
}