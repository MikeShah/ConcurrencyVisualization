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
treeMap tm;

void initGUI(){
  cp5 = new ControlP5(this);
  
  // create a new button with name 'buttonA'
  cp5.addButton("colorA")
     .setValue(0)
     .setPosition(100,20)
     .setSize(200,19)
     ;
}


// Setup the Processing Sketch
void setup() {
  size(600,600,P3D);
  noStroke();
  // Initialize the GUI
  initGUI();
  
  myColor = color(192,192,192,192);
  
  sl = new squareLayout();
  
  
  for(int i =0; i < 10000;++i){
     Cell temp = new Cell("test");
     temp.setRGB(random(255),random(255),random(255));
     temp.setWHD(8,random(100),8);
     sl.addcell(temp);
  }
  
  tm = new treeMap();
  tm.setCells(sl.getCells());
}

void draw() {
  background(myColor);
  
  pushMatrix();
    translate(xCam,yCam,zCam);
    sl.render();
    translate(0,-yCam,0);
  popMatrix();
  
  tm.render();
  
  
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