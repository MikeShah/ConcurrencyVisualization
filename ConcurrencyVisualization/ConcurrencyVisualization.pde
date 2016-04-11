/**
  Concurrency Visualization
 */
 
import controlP5.*;

/*
  Configuration options for the visualizaiton
*/
color myColor;

float xCam=40.0,yCam=560.0,zCam=20;
float cameraSpeed = 20 ;

ControlsPanel cp;
DetailsPane dp;
hilbertCurve hC;
FunctionsPanel fp;

void settings(){
  size(600,600,P3D);
}


// Setup the Processing Sketch
void setup() {
  
  surface.setTitle("Main View");
  surface.setLocation(0, 0);
  noStroke();
  myColor = color(192,192,192,192);
  
  cp = new ControlsPanel();
  dp = new DetailsPane();
  hC = new hilbertCurve();
  fp = new FunctionsPanel();
  
  ArrayList<String> methodList = hC.myCallTree.getLinearTree();
  for(int i =0; i < methodList.size();++i){
    fp.addListItem(methodList.get(i));
  }
  
  frameRate(60);
}

void draw() {
  background(myColor);
  
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