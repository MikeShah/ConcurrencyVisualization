/*
    This class serves as the details window to display other information.
*/


public class DetailsPane extends PApplet {
  
  // Purpose:
  
  //   A special mutable version of a java string.
  //   It exists within DetailsPane in order to transfer text around.   
  
  class DataString{
    String text;
    
    DataString(){
      text = new String("empty");
    }
    
    void setText(String s){
      text = new String(s);
    }
    
    String getString(){
      if(text!=null){
        return text;
      }else{
        return "";
      }
    }
    
  }
  

  
  // Used to pass and send data
  DataString dataString;
  
  // Our control panel
  ControlP5 detailsPanel;

  
  //    Build the GUI for the Details Pane
  
  void initGUI(){
      detailsPanel = new ControlP5(this);
  }
  
  public DetailsPane() {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    // Initialize a string of data that we can use to pass
    // between our different windows.
    dataString = new DataString();
    dataString.setText("Data");
    
    // Setup the GUI
    initGUI();
  }

  public void settings() {
    size(800, 320, P3D);
    smooth();
  }
  public void setup() { 
    println("setup DetailsPane");
    surface.setTitle("Details View");
    surface.setLocation(0, 400);
    frameRate(60);
  }

  public void draw() {
    background(145,160,176);
    text(dataString.getString(),10,10);
  }
  

    
}