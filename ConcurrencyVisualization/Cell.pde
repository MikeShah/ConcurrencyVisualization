/*

    Purpose: Store the data of a single function


*/

class Cell{
    
    // 3D Location
    float x;
    float y;
    float z;
    // Size
    float w; // x-axis
    float h; // y-axis
    float d; // z-axis
    
    // Color
    float r,g,b;
    // Actual data
    nodeMetaData metaData;
  
    public Cell(String name){
        metaData = new nodeMetaData();
        this.metaData.name = name;
    }
    
    
    public void setRGB(float r, float g, float b){
      this.r = r;
      this.g = g;
      this.b = b;
    }
    
    public color getRGB(){
      return color(r,g,b);
    }
    
    public void setXYZ(float x, float y, float z){
      this.x = x;
      this.y = y;
      this.z = z;
    }
    
    // Set the width height and depth
    public void setWHD(float w, float h, float d){
      this.w = w;
      this.h = h;
      this.d = d;
    }
    
    // Adds a child in the nodeMetaData
    public void addChildCell(Cell child){
      metaData.addChild(child);      
    }
    
    // Draw a code city
    public void render(){
       //rect(x,y,w,h);
       pushMatrix();
       fill(r,g,b);
       translate(x, y-h/2, z); 
       box(w, h, d);
       popMatrix();
    }
  
}