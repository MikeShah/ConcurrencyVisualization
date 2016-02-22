/*
    Consider making this an ordered treemap?
*/

public class treeMap extends DataLayer{
 
    public treeMap(){
      
    }
    
    void render(){
        for (int i =0; i < cells.size(); ++i){
          fill(cells.get(i).getRGB());
          rect(i,0,100,100);
        }
        
    }
  
}