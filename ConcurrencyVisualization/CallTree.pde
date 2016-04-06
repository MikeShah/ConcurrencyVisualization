/*

  Purpose: CallTreeNode stores information about a method 
  
*/

class CallTreeNode{
    String m_method;
    String m_totalTime;
    int Invocations;
    
    int level; // Level the node is at in the tree, such that we can pretty print it
    
    // Child nodes
    ArrayList<CallTreeNode> children;

    public void init(){
            children = new ArrayList<CallTreeNode>();
            
            level = 0;
    }
    
    public CallTreeNode(){
        init();
    }
    
    public CallTreeNode(String method_name){
        init();
        m_method = method_name;
    }
    
    // Adds a child node to children
    public void addChild(CallTreeNode c){
       children.add(c);
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
     root = new CallTreeNode("root");
   }
   
   /*
        "Call Tree - Method","Total Time [%]","Total Time","Invocations",
        " All threads","0.0","0","0"
        "  AWT-EventQueue-0","100.0","1344","1"
        "   javax.swing.Timer$DoPostEvent.run()","98.065475","1318","31"
        "    Self time","76.41369","1027","31"
        "    processing.app.ui.EditorConsole$1.actionPerformed(java.awt.event.ActionEvent)","21.577381","290","31"
        "     Self time","15.401786","207","31"
        "     processing.app.ui.EditorConsole.flush()","6.1755953","83","31"
        "   processing.app.ui.EditorConsole.flush()","2.0089285","27","1"
   */
   
   // Returns the number of leading spaces in a string
   // Paramter: Start, tells where to start looking in the substring
   public int indendation(String s){
     int spaces = 0;
     for(spaces = 0; spaces < s.length(); ++spaces){
        if(s.charAt(spaces) != ' '){
          break;
        }
     }
     return spaces;
   }
   
   // Loads a call tree file
   // Parses a Call tree, that stores nodes based on indentation
   //
   // Algorithm:
   // (1) Read in each line 
   // (2) For each node, see how many times it's indented
   //     (a) If the number is greater than the last one, then add it as a child.
   //     (b) If it is equal, then push it onto the stack
   //     (c) If it is less, then push everything as a child until the indentation is equal or stack is empty
   public void load(String fileName){
     String lines[] = loadStrings(fileName);
     
     // Walks a call tree file and then 
     Stack<CallTreeNode> walker = new Stack<CallTreeNode>();
     // By default, put our root node on top
     walker.push(root);
     
     int indentedLineLength = -1;
     int top_of_stack_indentation = -1;
     
     
     for (int i = 0 ; i < lines.length; i++) {
        // (1) Print out the line that we read in from the file 
        //     We also create a node for it.
        String  line = lines[i].substring(1);
        println(line);
        
        CallTreeNode c = new CallTreeNode(lines[i].substring(1));

        // (2) If walker is empty, then simply add in the first node read.
        //     If the stack is not empty, then we can see if the node is a child, and start building our tree structure
        if(walker.isEmpty()){
                walker.push(c);
        }else{
                // Temp add everything as a child
                if(indendation(line) > indendation(walker.peek().m_method)){
                  walker.peek().addChild(c);

                  walker.push(c);
                }
                else{// if(indendation(line) >= indendation(walker.peek().m_method)){
                }
        }

        
/*
        // Add as a child to the current node at the top of the stack.
        if(indentedLineLength > top_of_stack_indentation){
          walker.push(c);
        }
        //}else if(indentedLineLength == top_of_stack_indentation){
          // Add to the top of stack as well
          //walker.peek().addChild(c);
        //}
        else{ //if (indentation(lines[i].length < last_indentation){ // Just adding in comment to show that this is the 'less than' case
           
           //while indendation of top guy is less than current node
           //      then pop top of stack and make a child of the new top
           //      if indentation of top is equal to the last one, then push onto stack
           
           while(indendation(walker.peek().m_method.substring(1)) > indentedLineLength){
             CallTreeNode topNode = walker.pop();
             walker.peek().addChild(topNode);
           }
          
           
           
           walker.push(c);
        }
        
*/        
     }
  
     printTree();
     
   }
   
   // Print call Tree
   // Bread-first traversal to recreate the call tree
   public void printTree(){
       Queue<CallTreeNode> bfs = new LinkedList<CallTreeNode>();
       bfs.add(root);
       while(!bfs.isEmpty()){
         // Remove the first node of our queue
         CallTreeNode top = bfs.remove();
         // Print out the node we removed
         println(top.level+":"+top.m_method);
         // Add all of the children
         for(int i=0; i < top.children.size();++i){
           top.children.get(i).level = top.level+1;  // All child nodes are located one below from their parent
           bfs.add(top.children.get(i));
         }
       }
   }
   
}