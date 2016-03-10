public class nodeMetaData{
 
    // Name
    String name;
    // Size
    // A size encoding
    float size;
    // Children
    ArrayList<Cell> children;
  
    public nodeMetaData(){
      children = new ArrayList<Cell>();
    }
    
    public nodeMetaData(String name, float size){
      this.name = name;
      this.size = size;
       children = new ArrayList<Cell>();
    }
    
    public void addChild(Cell c){
      children.add(c);
    }
    
    public ArrayList<Cell> getChildren(){
      return children;
    }
  
}