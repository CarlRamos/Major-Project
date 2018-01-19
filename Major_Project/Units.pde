class Units {

  //data
  int hp;
  int r, g, b;
  float x, y, theWidht, theHeight;
  boolean isSelected;
  int speed;

  // takes x,y and the color
  Units(int _x, int _y, int _r, int _g, int _b) {
    x = _x;
    y = _y;
    r = _r;
    g = _g;
    b = _b;
    theWidht = 10;
    theHeight = 10;


    speed = 2;
    //didCollide = false;
  }



  //spawns the units
  void spawn() {

    fill(r, g, b);   

    rect(x, y, theWidht, theHeight);
  }

//check if selected
  void checkIfSelected() {
    if  (mouseIsOnUnit()) {
      isSelected =! isSelected;
    }
  }

//move functions
  void move(int  goX, int goY) {
//can only move if selected
    if  (isSelected ==true) {

      if (x < goX) {
        x += speed;
      }

      if (x > goX) {
        x -= speed;
      }

      if (y < goY) {
        y +=speed;
      }

      if (y > goY) {
        y -= speed;
      } else 

      println("moving");
    }
  }

//check if unit is out of boundary
  void outOfBoundary() {
    if (x > width) {
      x -= 5;
    }

    if (y < width) {
      x += 5;
    }

    if (y > height) {
      x -= 5;
    }

    if (x < height) {
      x += 5;
    }
  }

//if mouse is on unit
  boolean mouseIsOnUnit() {
    return ((mouseX > x) &&
      (mouseX < x+10) &&
      (mouseY > y) &&
      (mouseY < y+10));
  }
}