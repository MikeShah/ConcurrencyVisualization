/*

    Purpose: Store the data of a single function


*/

class Cell{
 
    // Name
    String name;
    // 3D Location
    float x;
    float y;
    float z;
  
    public Cell(String name){
        this.name = name;
    }
    
    
    public void setXY(float x, float y, float z){
      this.x = x;
      this.y = y;
      this.z = z;
    }
    
    
    public void render(float w, float h){
       rect(x,y,w,h);
    }
  
}