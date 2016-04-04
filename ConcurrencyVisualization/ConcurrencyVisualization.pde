/**
  Concurrency Visualization
 */
 
import controlP5.*;

ControlP5 cp5;

float n,n1;



/*
  Configuration options for the visualizaiton
*/
color myColor;

float xCam=40.0,yCam=560.0,zCam=20;
float cameraSpeed = 20 ;


squareLayout sl;
hilbertCurve hC;
DetailsPane dp;
ControlsPanel cp;

void initGUI(){
  cp5 = new ControlP5(this);
}

void settings(){
  size(600,600,P3D);
}


// Setup the Processing Sketch
void setup() {
  surface.setTitle("Main View");
  surface.setLocation(0, 0);
  noStroke();
  // Initialize the GUI
  initGUI();
  
  myColor = color(192,192,192,192);
  
  sl = new squareLayout();
  hC = new hilbertCurve();
  dp = new DetailsPane();
  cp = new ControlsPanel();
  
  for(int i =0; i < 10;++i){
     Cell temp = new Cell("test");
     temp.setRGB(random(255),random(255),random(255));
     temp.setWHD(8,random(100),8);
     // Add a random number of children to the temp node
     int rand = (int)(random(0,5));
     for(int j =0; j < rand; ++j){
       Cell temps_child = new Cell("a child");
       temp.addChildCell(temps_child);
     }
     sl.addcell(temp);
  }
  
  sl.traverseCells();
}

void draw() {
  background(myColor);
  
  /*
  pushMatrix();
    translate(xCam,yCam,zCam);
    sl.render();
    translate(0,-yCam,0);
  popMatrix();
  */
  
  hC.render();
  
  
}

void keyPressed() {
  /*
  int keyIndex = -1;
  if (key >= 'A' && key <= 'Z') {
    keyIndex = key - 'A';
  }
  */
  if(keyCode==LEFT){
    xCam+=cameraSpeed;
  }
  if(keyCode==RIGHT){
    xCam-=cameraSpeed;
  }
  if(keyCode==UP){
    zCam+=cameraSpeed;
  }
  if(keyCode==DOWN){
    zCam-=cameraSpeed;
  }
}

public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
  n = 0;
}

// function colorA will receive changes from 
// controller with name colorA
public void colorA(int theValue) {
  println("a button event from colorA: "+theValue);
}