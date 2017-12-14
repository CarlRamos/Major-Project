class House{
  
 //data
 int x, y, theWidth, theHeight;
 int health;
 boolean isSelected;
 
 //constructor
 House(int _x, int _y){
   x = _x;
   y = _y;
   theWidth = 10;
   theHeight = 10;
   health = 100;
   isSelected = false;
   
 }
  
  
  void build(){
   else {fill(255, 0,0); 
   }rect(x, y, 10, 10); 
   
   //println("house");
    
    
  }
  
  
  
  void checkIfSelected(){
    if  (mouseIsOnButton()){
     isSelected =! isSelected; 
    }
    
  }
  
  boolean mouseIsOnButton(){
    return ((mouseX > x) &&
      (mouseX < x+theWidth) &&
      (mouseY > y) &&
      (mouseY < y+theHeight));
    
    
    
  }
  
  
  
}