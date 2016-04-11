/*
    Purpose: This class serves as a window to display Functions.
*/


public class FunctionsPanel extends PApplet {
  

  // Our control panel
  ControlP5 widgets;
  ListBox myListBox;
  
  //    Build the GUI for the Functions Pane
  void initGUI(){
      widgets = new ControlP5(this);
      

      myListBox = widgets.addListBox("Functions Called")
         .setPosition(0 ,0)
         .setSize(200, height)
         .setItemHeight(15)
         .setBarHeight(15)
         .setColorBackground(color(255, 128))
         .setColorActive(color(0))
         .setColorForeground(color(255, 100,0))
         ;
         
  }
  
  void addListItem(String itemName){
        myListBox.addItem(itemName, 0);
        myListBox.getItem(itemName).put("color", new CColor().setBackground(0xffff0000).setBackground(0xffff8800));
  }
  
  public FunctionsPanel() {
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
    println("setup Functions Panel");
    surface.setTitle("Functions Panel");
    surface.setLocation(1000, 0);
    frameRate(60);
  }

  public void draw() {
    background(145,160,176);
  }
  
  // Detect events
  void controlEvent(ControlEvent theEvent) {
      // ListBox is if type ControlGroup.
      // 1 controlEvent will be executed, where the event
      // originates from a ControlGroup. therefore
      // you need to check the Event with
      // if (theEvent.isGroup())
      // to avoid an error message from controlP5.
    
      if (theEvent.isGroup()) {
        // an event from a group e.g. scrollList
        println(theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
      }
      
      if(theEvent.isGroup() && theEvent.getName().equals("Functions Called")){
        int test = (int)theEvent.getGroup().getValue();
        println("test "+test);
      }
  }
}