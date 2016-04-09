/*
    Consider making this an ordered treemap?
*/

public class hilbertCurve extends DataLayer{
 
    float renderHeight = 0;
    float renderWidth = 0;
    
    CallTree myCallTree;
    
    Vector c[]; 
    int curveAnimation = 0; 

    
    public hilbertCurve(){
        renderHeight = height - 200;
        renderWidth = width;

        // Load a call tree into our hilbert curve
        myCallTree = new CallTree();
        myCallTree.load("/Users/michaelshah/Desktop/Snapshots/JVisualVM.csv");
        myCallTree.printTree();

        c = hilbert(  new Vector(renderWidth, renderHeight, 0) , 300.0,    cp.HilbertCurveValue,      0, 1, 2, 3); // hilbert(center, side-length, recursion depth, start-indices)

    }
    
    // Main render function
    void render(){
        fill(192);
        stroke(192);
        HilbertPoints=0;

      noStroke(); fill(255, 10);
      rect(0,0, renderWidth, renderHeight);
      for(int i = 0; i < c.length-1; i++){
        // Draw the lines of the actual hilbert curve
        stroke(255); line(c[i].x, c[i].y, c[i+1].x, c[i+1].y);
        // Plot points along the curve
        int rectSize = 3; // How big are the points
        // Compute and figure out where points can be plotted
        float lineLength = max(abs(c[i].x - c[i+1].x),abs(c[i].y - c[i+1].y));
        println(lineLength);
        for(int j=0; j < lineLength/rectSize; ++j){
          stroke(255,0,0);
          rect(c[i].x+j*lineLength,c[i].y+j*lineLength,rectSize,rectSize);
        }
      }
        
        if(curveAnimation < c.length-1){
          stroke(0,255,0);
          rect(c[curveAnimation].x,c[curveAnimation].y,5,5);
          curveAnimation++;
        }else{
          curveAnimation = 0;
        }
              
        //println(HilbertPoints);
        // Render the grid of functions
        renderGrid(0,renderHeight);
        // Render only the cells
        drawCells();
        // Detect mouse interaction
        mouseOver();
    }
    
    // Only draw the cells as they have been positioned in the hilbert curve
    void drawCells(){
      for(int i =0; i < cells.size(); ++i){
            fill(cells.get(i).getRGB());
            stroke(0);
            rect(cells.get(i).x, 
                 cells.get(i).y,
                 cells.get(i).w,
                 cells.get(i).h);
        }
    }
    
    // Grid of all of the possible cells in the simulation
    void renderGrid(float xOffset, float yOffset){
        // Pick cell width
        float cellWidth = 8;
        float cellHeight = 8;
        // Make the grid
        float cellsPerRow = width / cellWidth;
        float pixelsInRow = 0;
        float rowOffset = 0;      
      
        for(int i =0; i < cells.size(); ++i){
            fill(200);
            stroke(255);
            rect(xOffset+pixelsInRow, 
                 yOffset+rowOffset,
                 cells.get(i).w,
                 cells.get(i).h);
                 
            pixelsInRow += cellWidth;
            if(pixelsInRow > cellsPerRow*cellWidth){
              pixelsInRow = 0;
              rowOffset += cellHeight;
            }
        }
    }
 
   // Detect if we moused over a cell.
   void mouseOver(){
      for(int i =0; i < cells.size();i++){
        
        float yTextOffset = 20; // Need to subtract text from y
        
        if(dist(mouseX,mouseY,cells.get(i).x,cells.get(i).y) < 8){
              stroke(0,0,128,128);
              fill(0,0,128,128);
              rect(cells.get(i).x,cells.get(i).y,cells.get(i).metaData.name.length()*8,20);
              stroke(255);
              fill(255);
              text(cells.get(i).metaData.name,cells.get(i).x,cells.get(i).y+yTextOffset);
              dp.dataString.setText(cells.get(i).metaData.name);
              // Action to take place on mouse-click | Toggle selection
              if(mousePressed==true){
                cells.get(i).selected = !cells.get(i).selected;
              }
        }
        
        // If the cell is selected, then show a pop up
        if(cells.get(i).selected==true){
              stroke(0,0,128,128);
              fill(0,0,128,128);
              rect(cells.get(i).x,cells.get(i).y,cells.get(i).metaData.name.length()*8,20);
              stroke(255);
              fill(255);
              text(cells.get(i).metaData.name,cells.get(i).x,cells.get(i).y+yTextOffset);
          }
        }
   }
 
    float x1,y1,x2=0,y2=0;
    boolean firstRun = true;
    
    int HilbertPoints = 0;
    

// Used to store the points in a Hilbert curve
// and make a vector
class Vector{
  float x, y, z;
  Vector( float x, float y, float  z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
}
 
int counter= 0;
 
Vector[] hilbert( Vector c_,  float side,   int iterations,      int index_a, int index_b, int index_c, int index_d ){
  Vector c[] = new Vector[4];
  c[index_a] = new Vector(  c_.x - side/2,   c_.y - side/2, 0  );
  c[index_b] = new Vector(  c_.x + side/2,   c_.y - side/2, 0  );
  c[index_c] = new Vector(  c_.x + side/2,   c_.y + side/2, 0  );
  c[index_d] = new Vector(  c_.x - side/2,   c_.y + side/2, 0  );
 
  if( --iterations >= 0) {
    Vector tmp[] = new Vector[0];
    
    tmp = (Vector[]) concat(tmp, hilbert ( c[0],  side/2,   iterations,    index_a, index_d, index_c, index_b  ));
    tmp = (Vector[]) concat(tmp, hilbert ( c[1],  side/2,   iterations,    index_a, index_b, index_c, index_d  ));
    tmp = (Vector[]) concat(tmp, hilbert ( c[2],  side/2,   iterations,    index_a, index_b, index_c, index_d  ));
    tmp = (Vector[]) concat(tmp, hilbert ( c[3],  side/2,   iterations,    index_c, index_b, index_a, index_d  ));
    return tmp;
  }
  
  HilbertPoints++;
   Cell _cell = new Cell("Cell#: "+HilbertPoints);
   _cell.setXYZ(x1,y1,0);
   _cell.setWHD(8,8,8);
  //             c.setRGB(random(255),random(255),random(255));
   _cell.setRGB(255,0,0);
   addcell(_cell);
             
  return c;
}

    
}