/*
    Purpose: Lays out the cells on a visual layout for some basic attributes

*/

class squareLayout extends DataLayer{
  
   ArrayList<Cell> cells;
  
   public squareLayout(){
     cells = new ArrayList<Cell>();
   }
   
   
   public void setLayout(){
     
   }
   
   void addcell(Cell c){
     cells.add(c);
   }
   
   public void render(){
     
     float x = 0;
     float y = 0;
     float z = 0;
      
     float xBounds = 1000;
     float zBounds = 1000;

     float xStep = 8;
     float zStep = 8;

     for(int i=0; i < cells.size();++i){
        cells.get(i).setXYZ(x,0,z);
        cells.get(i).setWHD(xStep,cells.get(i).h,zStep);
        cells.get(i).render();
        x+=xStep;
        if(x > xBounds){
          x=0;
          z+=zStep;
        }
     }
   }
  
}