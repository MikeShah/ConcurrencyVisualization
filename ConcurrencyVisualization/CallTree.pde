/*

  Purpose: CallTreeNode stores information about a method 
  
*/

class CallTreeNode{
    String m_method;
    String m_totalTime;
    int Invocations;
    // Child nodes
    ArrayList<CallTreeNode> children;

    public CallTreeNode(){
      children = new ArrayList<CallTreeNode>();
    }
    
}

/*

    Purpose: The CallTree Node class loads in a call tree, and stores
             an internal tree structure.
             
             The Call Tree is a directed acyclic graph, hench the name. 
             It does not make sense for it to have cycles.
*/

class CallTree{
   
   CallTreeNode root;
   
   public CallTree(){
     root = new CallTreeNode();
   }
   
   // Loads a call tree file
   // Parses a Call tree, that stores nodes based on indentation
   public void load(String fileName){
     String lines[] = loadStrings(fileName);
     for (int i = 0 ; i < lines.length; i++) {
        println(lines[i]);
     }
   }
   
   // Print call Tree
   public void printTree(){
     
   }
   
}