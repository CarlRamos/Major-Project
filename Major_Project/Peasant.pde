class Peasant {

  //data
  int hp;
  int x, y, theWidht, theHeight;
  boolean isSelected;


  //  
  Peasant(int _x, int _y) {
    x = _x;
    y = _y;
    theWidht = 10;
    theHeight = 10;
  }



  //spawns the peasant
  void spawn() {
    if (isSelected) {
      fill(255); 
      println("selected");
    }
    rect(x, y, theWidht, theHeight);
  }

  void checkIfSelected() {
    if  (mouseIsOnButton()) {
      isSelected =! isSelected;
    }
  }

  void move( ) {
    int toX, toY;  //
    if (mousePressed == true){
    toX = mouseX;
    toY = mouseY;
    }
    
    //teleports to the next point (from point 1 - point 2)
    if (isSelected && mouseButton == LEFT) {


      if (x < toX) {
        x += 5;
      }

      if (x > toX) {
        x -= 5;
      }

      if (y < toY) {
        y += 5;
      }

      if (y > toY) {
        y -= 5;
      }

      println("moving");
    }
  }


  boolean mouseIsOnButton() {
    return ((mouseX > x) &&
      (mouseX < x+10) &&
      (mouseY > y) &&
      (mouseY < y+10));
  }
 
  int x() {
    return x;
  }

  int y() {
    return y;
  }

  int Width() {
    return theWidht ;
  }

  int Height() {
    return theHeight;
    
  }
}