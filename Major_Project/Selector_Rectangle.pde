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

      pointX = -1 *(x - mouseX);
      pointY = -1 *(y - mouseY);
      fill(0, 0, 255, 100);
      rect(x, y, pointX, pointY);
      println(pointX, pointY);
    }
   
  }

  int x() {
    return x;
  }
  
  int y() {
    return y;
  }
  
  int Width() {
    return pointX;
  }
 
  int Height() {
    return pointY;
  }
}