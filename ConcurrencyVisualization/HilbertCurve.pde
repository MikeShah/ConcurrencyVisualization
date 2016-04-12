/*
    Consider making this an ordered treemap?
*/

public class hilbertCurve extends DataLayer{
 
    float renderHeight = 0;
    float renderWidth = 0;
    
    CallTree myCallTree;                    // Actual tree representation 
    ArrayList<CallTreeNode> LinearCallTree; // A flattened tree that can be mapped to the Hilbert Curve (essentially bfs tree, then sorted by time)
    
    // Store the points in the hilbert curve    
    Vector c[]; 

    // Move a point along a line in the hilbert curve
    // one pixel at a time. Reset these values when destination is met.
    int[] curveAnimation;   int animationLength = 5;
    float[] xAnimationOffset;
    float[] yAnimationOffset;    
    
    int lineColorAnimation = 0; 
    
    // Which is the last cell that the user clicked on.
    int lastSelectedCell = 0;
    
    
    public hilbertCurve(){
        renderHeight = height;
        renderWidth = width;

        // Load a call tree into our hilbert curve
        myCallTree = new CallTree();
        myCallTree.load("/Users/michaelshah/Desktop/Snapshots/JVisualVM.csv");
        myCallTree.printTree();

        c = hilbert(new Vector(renderWidth/2, renderHeight/2, 0) , 300.0,    cp.HilbertCurveValue, 0, 1, 2, 3); // hilbert(center, side-length, recursion depth, start-indices)

        mapCellsToTree();

        curveAnimation = new int[animationLength];
        xAnimationOffset = new float[animationLength];
        yAnimationOffset = new float[animationLength];
    }
    
    // Resets the hilbert curve to a new value.
    // This clears all data and rebuilds the visualization from scratch
    void regenerate(){
        cells.clear(); // Clear cell information in the data layer.
        c = hilbert(new Vector(renderWidth/2, renderHeight/2, 0) , 300.0,    cp.HilbertCurveValue, 0, 1, 2, 3); // hilbert(center, side-length, recursion depth, start-indices)
    }

    // Main render function
    void render(){
        fill(192);
        stroke(192);

        noStroke(); fill(255, 10);
        rect(0,0, renderWidth, renderHeight);
        for(int i = 0; i < c.length-1; i++){
          // Draw the lines of the actual hilbert curve
          stroke(255); line(c[i].x, c[i].y, c[i+1].x, c[i+1].y);
          // Plot points along the curve
          int rectSize = 3; // How big are the points
          // Compute and figure out where points can be plotted
          float lineLength = max(abs(c[i].x - c[i+1].x),abs(c[i].y - c[i+1].y));
//          println("Line Length: "+lineLength);
          for(int j=0; j < lineLength/rectSize; ++j){
            stroke(255,0,0);
            //rect(c[i].x+j*lineLength,c[i].y+j*lineLength,rectSize,rectSize);
          }
        }
        
        // line animation()
        //lineAnimation();
        
        // For an animation
        //movePointOnCurve(1);

        //println(HilbertPoints);
        // Render the grid of functions
        renderGrid(0,renderHeight,8);
        // Render only the cells
        drawCells();
        // Highlight where we click
        highlight();
        // Detect mouse interaction
        mouseOver();
    }
    
    int colorFade = 120;
    
    // Simply 
    void lineAnimation(){
      if (lineColorAnimation < c.length-1){
        // Draw the lines of the actual hilbert curve
        stroke(0,colorFade,0); line(c[lineColorAnimation].x, c[lineColorAnimation].y, c[lineColorAnimation+1].x,c[lineColorAnimation+1].y);
      }else{
        lineColorAnimation=0;
      }
      
      colorFade++;
      if(colorFade>255){
        lineColorAnimation++;
        colorFade=120;
      }
    }
    
    // Highlights all of the hilbert curve up until the
    // line that we select
    void highlight(){
      
      float incrementColor = 255;
      if (lastSelectedCell >0){
        incrementColor = 255.0 / ((float)(lastSelectedCell*4));
      }

      for(int i =0; i < lastSelectedCell*4; ++i){
        if(i<c.length-1 && c != null){
          stroke(0,0,(float)i*incrementColor); line(c[i].x, c[i].y, c[i+1].x,c[i+1].y);
        }
      }
    }
    
    // Move a rectangle along a curve
    void movePointOnCurve(int speed){
          for(int i = 0; i < animationLength; ++i){
                // Move a rectangle along a curve
                if(curveAnimation[i] < c.length-1){
                      stroke(0,192,0);
                      fill(0,255,0);
                      ellipse(c[curveAnimation[i]].x+xAnimationOffset[i],c[curveAnimation[i]].y+yAnimationOffset[i],12,12);
                      
                      int start_x =  (int)c[curveAnimation[i]].x;
                      int start_y =  (int)c[curveAnimation[i]].y;
                      int target_x = (int)c[curveAnimation[i]+1].x;
                      int target_y = (int)c[curveAnimation[i]+1].y;

//                    println("("+start_x+","+start_y+")=>("+target_x+","+target_y+")");
                                      
                      // If the x's are the same, then we increment along the y
                      if(start_x==target_x){
                        if(start_y>target_y){
                          yAnimationOffset[i]-=speed;
                        }else{
                          yAnimationOffset[i]+=speed;
                        }
                      }
                      else{
                        if(start_x>target_x){
                          xAnimationOffset[i]-=speed;
                        }else{
                          xAnimationOffset[i]+=speed;
                        }
                      }
                      if(dist(start_x+xAnimationOffset[i],start_y+yAnimationOffset[i],target_x,target_y)<2){
                          curveAnimation[i]++; 
                          xAnimationOffset[i] = 0;
                          yAnimationOffset[i] = 0;
                      }
                      
                }else{
                      curveAnimation[i] = 0;
                }
          }
    }
    
    // Only draw the cells as they have been positioned in the hilbert curve
    void drawCells(){
      if(cells==null){
        return;
      }
      
      for(int i =0; i < cells.size(); ++i){
            fill(cells.get(i).getRGB());
            stroke(0);
            rect(cells.get(i).x, 
                 cells.get(i).y,
                 cells.get(i).w,
                 cells.get(i).h);
        }
    }
    
    // Important function that maps Cells to the tree
    // Each cell can have exactly one tree node.
    void mapCellsToTree(){
        
        // Get a linear tree
        LinearCallTree = myCallTree.getLinearTree();
      
        /*
        for(int i = 0; i < LinearCallTree.size(); ++i){
          if(i < LinearCallTree.size()){
            cells.get(i).myCallTreeIndex = LinearCallTree.get(i);
          }
        }
        */
    }
    
    // Grid of all of the possible cells in the simulation
    void renderGrid(float xOffset, float yOffset,float rectAngleSize){
        // Pick cell width
        float cellWidth = rectAngleSize;
        float cellHeight = rectAngleSize;
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
              
              if(i<LinearCallTree.size()){
                dp.dataString.setText(LinearCallTree.get(i).printNode());
              }
              
              
                // Highlight all other similar cells of the current cell that has been selected.
                for(int j =0; j < cells.size();++j){
                    if(j< LinearCallTree.size() && i < LinearCallTree.size()){
                        if (LinearCallTree.get(i).m_method.equals(LinearCallTree.get(j).m_method)){
                            ellipse(cells.get(j).x,cells.get(j).y,15,15);
                        }
                    }
                }
              
              
              
              // Action to take place on mouse-click | Toggle selection
              if(mousePressed==true){
                cells.get(i).selected = !cells.get(i).selected;
              }
              lastSelectedCell = i;
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
 
// Function that draws a hilbert curve by storing all of the points from which to draw lines to and from.
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
  
  // Everytime we plot a point on the hilbert curve, also draw a cell.
   counter++;
   Cell _cell = new Cell("Cell#: "+counter);
   _cell.setXYZ(c_.x - side/2,   c_.y - side/2, 0);
   _cell.setWHD(4,4,4);
  //             c.setRGB(random(255),random(255),random(255));
   _cell.setRGB(255,0,0);
   addcell(_cell);
             
  return c;
}

    
}