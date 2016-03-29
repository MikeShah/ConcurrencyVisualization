/*
    Consider making this an ordered treemap?
*/

public class hilbertCurve extends DataLayer{
 
    float renderHeight = 0;
    float renderWidth = 0;
    
    public hilbertCurve(){
        renderHeight = height - 200;
        renderWidth = width;
    }
    
    void render(){
        fill(192);
        stroke(192);
        HilbertPoints=0;
        hilbert(0, 0, renderWidth, 0, 0, renderHeight, 3);
        println(HilbertPoints);
        // Detect mouse interaction
        mouseOver();
        
        renderGrid(0,renderHeight);
    }
    
    // 
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
            rect(pixelsInRow, 
                 yOffset+rowOffset,
                 cells.get(i).w,
                 cells.get(i).h);
                 
            pixelsInRow += cellWidth;
            if(pixelsInRow > cellsPerRow*cellWidth){
              pixelsInRow = 0;
              rowOffset+= cellHeight;
            }
        }
    }
 
   // Detect if we moused over a cell.
   void mouseOver(){
      for(int i =0; i < cells.size();i++){
        if(dist(mouseX,mouseY,cells.get(i).x,cells.get(i).y) < 8){
            fill(192);
            stroke(192);
            rect(cells.get(i).x,cells.get(i).y,cells.get(i).w,cells.get(i).h);
        }
      }
   }
 
    float x1,y1,x2=0,y2=0;
    boolean firstRun = true;
    
    int HilbertPoints = 0;
    
    void hilbert(float x, float y, float xi, float xj, float yi, float yj, int  n) {
    // x0 and y0 are the coordinates of the bottom left corner
    // xis & xjs are the i & j components of the unit x vector this frame
    // similarly yis and yjs
    if (n <= 0){
       // LineTo(x + (xi + yi)/2, y + (xj + yj)/2);
       // line(x1,y1,x2,y2);
       if(firstRun){
         x1 = x + (xi + yi)/2;
         y1 = y + (xj + yj)/2;
         x2 = x + (xi + yi)/2;
         y2 = y + (xj + yj)/2;     
         firstRun = false;
       }
       else{
         x1 = x2;
         y1 = y2;
         x2 = x + (xi + yi)/2;
         y2 = y + (xj + yj)/2;
       }
    
       stroke(0,255,0);
       fill(0,255,0);
       line(x1,y1,x2,y2);
       stroke(255,0,0);
       fill(255,0,0);
       rect(x1,y1,4,4);
       rect(x2,y2,4,4);
       HilbertPoints++;
       Cell c = new Cell("Cell#: "+HilbertPoints);
       c.setXYZ(x1,y1,0);
       c.setWHD(8,8,8);
       addcell(c);
    }
    else{
       hilbert(x,           y,           yi/2, yj/2,  xi/2,  xj/2, n-1);
       hilbert(x+xi/2,      y+xj/2 ,     xi/2, xj/2,  yi/2,  yj/2, n-1);
       hilbert(x+xi/2+yi/2, y+xj/2+yj/2, xi/2, xj/2,  yi/2,  yj/2, n-1);
       hilbert(x+xi/2+yi,   y+xj/2+yj,  -yi/2,-yj/2, -xi/2, -xj/2, n-1);
       }
    }
    
}