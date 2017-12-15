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




  void spawn() {
    if (isSelected){
     fill(255); 
    }
    ellipse(x, y, radius, radius);
  }

  void checkIfSelected() {
    if  (mouseIsOnButton()) {
      isSelected =! isSelected;
    }
  }

  void move(int toX, int toY) {
    if (isSelected) {
      x = toX;
      y = toY;
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