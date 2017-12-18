class Peasant {

  //data
  int hp;
  int x, y, radius;
  boolean isSelected;


  //  
  Peasant(int _x, int _y) {
    x = _x;
    y = _y;
    radius = 10;
  }



  //spawns the peasant
  void spawn() {
    if (isSelected) {
      fill(255); 
      println("selected");
    }
    rect(x, y, radius, radius);
  }

  void checkIfSelected() {
    if  (mouseIsOnButton()) {
      isSelected =! isSelected;
    }
  }

  void move() {
    int toX, toY;

    //teleports to the next point (from point 1 - point 2)
    if (isSelected && mouseButton == RIGHT) {
      toX = mouseX;
      toY = mouseY;

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
}