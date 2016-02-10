/**
  Concurrency Visualization
 */
 
import controlP5.*;

ControlP5 cp5;

float n,n1;

color myColor;

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
  size(400,600);
  noStroke();
  // Initialize the GUI
  initGUI();
  
  myColor = color(192,192,192,192);

}

void draw() {
  background(myColor);
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