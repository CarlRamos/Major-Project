class House {

  //data
  int x, y, theWidth, theHeight;
  int health;
  boolean isSelected;

  //constructor
  House(int _x, int _y) {
    x = _x;
    y = _y;
    theWidth = 20;
    theHeight = 20;
    health = 100;
    isSelected = false;
  }


  void build() {
    if (isSelected) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    //rectMode(CENTER);

    rect(x, y, theWidth, theHeight); 

    //println("house");
  }



  void checkIfSelected() {
    if  (mouseIsOnButton()) {
      isSelected =! isSelected;
    }
  }

  boolean mouseIsOnButton() {
    return ((mouseX > x) &&
      (mouseX < x+theWidth) &&
      (mouseY > y) &&
      (mouseY < y+theHeight));
  }

  int x() {
    return x;
  }

  int y() {
    return y;
  }
}