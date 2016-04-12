/*
    Purpose: This class serves as visualization for the functions somewhere in the call tree.
*/

public class GridVisualization extends PApplet {

  // Our control panel
  ControlP5 widgets;
  
  //    Build the GUI for the Details Pane  
  void initGUI(){
      widgets = new ControlP5(this);

      // create a new button with name 'buttonA'
      widgets.addButton("SampleButton")
         .setValue(0)
         .setPosition(0,0)
         .setSize(200,19)
         ;
  }
  
  public GridVisualization() {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);    
    // Setup the GUI
    initGUI();
  }

  public void settings() {
    size(400, 300, P3D);
  }
  
  // Setup function
  public void setup() { 
    smooth();
    println("setup Grid Visualization");
    surface.setTitle("Call Grid");
    surface.setLocation(800, 40);
    frameRate(60);
  }

  // Main draw function
  public void draw() {
    if(widgets!=null){
      background(145,160,176);
      // If our hilbert Curve has been loaded, then render some nodes
      if(hC != null){
          drawGrid();
      }
    }
  }
  
  // Draws the grid
  public void drawGrid(){
        float rectangleSize = 8;
        float xPosition = 0;
        float yPosition = 3;
        // Draw all of the cells in the visualization
        for(int i =0; i < hC.LinearCallTree.size(); ++i){
          
          // Set the different nodes highlighted to appropriate diff colors
          if (hC.LinearCallTree.get(i).highlighted==0){
            stroke(0); fill(255);
          }else if(hC.LinearCallTree.get(i).highlighted==1){
            stroke(0); fill(255,255,0);
          }else if(hC.LinearCallTree.get(i).highlighted==2){
            stroke(0); fill(0,255,0);
          }else if(hC.LinearCallTree.get(i).highlighted==3){
            stroke(0); fill(255,0,0);
          }
          
          // Highlight selected node green
          // and update the details pane
          if(mouseX > xPosition*rectangleSize && mouseX < (xPosition+1)*rectangleSize && mouseY > yPosition*rectangleSize && mouseY < (yPosition+1)*rectangleSize){
            stroke(0); fill(0,255,0);
            dp.dataString.setText(hC.LinearCallTree.get(i).printNode());
          }
          
          rect(xPosition*rectangleSize,yPosition*rectangleSize,rectangleSize,rectangleSize);
          
          xPosition++;
          if(xPosition*rectangleSize > width){
            xPosition = 0;
            yPosition++;
          }
        } 
  }
  
  void SampleButton(){
    println("SampleButton Pressed");
  }
    
}