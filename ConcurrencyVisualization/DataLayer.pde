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
  
}