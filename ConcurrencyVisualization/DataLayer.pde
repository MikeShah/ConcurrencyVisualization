/*
  
    Purpose: Single place to inherit data from

*/
import java.util.*;

class DataLayer{
 
   
   ArrayList<Cell> cells;
  
   public DataLayer(){
      cells = new ArrayList<Cell>();
   }
  
   void addcell(Cell c){
     cells.add(c);
   }
   
   // Get the list of cells and transform them
   ArrayList<Cell> getCells(){
     return cells;
   }
  
   // Get all of the cells, and set them to a new set
   // This is one way to copy all the cells from one visualization to another
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
       Queue<Cell> bfs = new LinkedList<Cell>();
       
       // Populate our Queue with the roots
       for(int i =0; i < cells.size();++i){
         bfs.add(cells.get(i));
       }
       
       while(!bfs.isEmpty()){
          Cell current = bfs.remove();
          for(int i =0; i < current.metaData.children.size(); ++i){
             bfs.add(current.metaData.children.get(i));
          }
          println(current.metaData.name);
       }
       
   }
   
}