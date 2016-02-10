/*
    Purpose: Lays out the cells on a visual layout for some basic attributes

*/

class squareLayout extends DataLayer{
  
   ArrayList<Cell> cells;
  
   public squareLayout(){
   
   }
   
   
   public void setLayout(){
     
   }
   
   void addcell(String name){
     Cell temp = new Cell(name);
     cells.add(temp);
   }
   
   public void render(){
     for(int i=0; i < cells.size();++i){
        cells.get(i).render(8,8); 
     }
   }
  
}