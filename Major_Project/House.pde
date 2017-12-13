class House{
  
 //data
 int x, y;
 int health;
 
 //constructor
 House(int _x, int _y){
   x = _x;
   y = _y;
   health = 100;
   
 }
  
  
  void build(){
   fill(255, 0,0); 
   rect(x, y, 10, 10); 
   println("house");
    
    
  }
  
  
  
  
  
  
  
  
  
}