class Selector {

  int y, x, theWidth, theHeight;


  int pointX, pointY;

  //constructor

  Selector() {

    if (mouseButton == LEFT) {
      x = mouseX;
      y = mouseY;
      println("w" + pointX, pointY);
      println("q" + mouseY, mouseX);
    }
  }




  void drawRectangle() {

    if (mouseButton == LEFT) {
  // calculates the dist between x and mouseX since mouseX is the current Width same with the mouseY and multiply it by -1 since if it is not multiplied by -1 it wil be inverted
      pointX = -1 *(x - mouseX);
      pointY = -1 *(y - mouseY);
      fill(0, 0, 255, 100);
      rect(x, y, pointX, pointY);
      println(pointX, pointY);
    }
  }
  
  boolean checkIfInside(float theX, float theY) {
    // checks if any units is inside to select it
    return(theX <= x &&
      theX>=x + pointX&&
      theY>=y+ pointY&&
      theY<= y) ||

      (theX >= x &&
      theX<= x + pointX&&
      theY<= y+  pointY&&
      theY>= y) ||

      (theX >= x &&
      theX<= x +  pointX&&
      theY>= y+   pointY&&
      theY<= y) ||

      (theX <= x &&
      theX>= x + pointX&&
      theY<= y+ pointY&&
      theY>= y);
  }
}