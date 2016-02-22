/*
  
    Purpose: Single place to inherit data from

*/

class DataLayer{
 
   ArrayList<Cell> cells;
  
   public DataLayer(){
      cells = new ArrayList<Cell>();
   }
  
   void addcell(Cell c){
     cells.add(c);
   }
   
   ArrayList<Cell> getCells(){
     return cells;
   }
  
   void setCells(ArrayList<Cell> newCells){
     // Remove our old list of cells
     cells.clear();
     
     // Set our new list
     for(int i=0; i < newCells.size();++i){
         cells.add(newCells.get(i));
     }
   }
   
   // Traverses all of the cells and their children
   // Performs a breadth-first search
   void traverseCells(){
       
   }
   
}