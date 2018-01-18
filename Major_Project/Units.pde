class Units {

  //data
  int hp;
  int r, g, b;
  float x, y, theWidht, theHeight;
  boolean isSelected;
        int speed;

  //  
  Units(int _x, int _y, int _r, int _g,int _b) {
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



  //spawns the peasant
  void spawn() {
   
   fill(r, g, b);   
    
    rect(x, y, theWidht, theHeight);
  }

  void checkIfSelected() {
    if  (mouseIsOnButton()) {
      isSelected =! isSelected;
    }
  }

  void move(int  goX, int goY) {


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


  
  boolean mouseIsOnButton() {
    return ((mouseX > x) &&
      (mouseX < x+10) &&
      (mouseY > y) &&
      (mouseY < y+10));
  }


}