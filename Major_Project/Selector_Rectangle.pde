class Selector {

  int y, x, theWidth, theHeight;




  //constructor

  Selector() {

    if (mouseButton == LEFT) {
      pointX = mouseX;
      pointY = mouseY;
      println("w" + pointX, pointY);
      println("q" + mouseY, mouseX);
    }
  }
}



void drawRectangle() {

  if (mouseButton == LEFT) {

    point1X = -1 *(pointX - mouseX);
    point1Y = -1 *(pointY - mouseY);
    fill(0, 0, 0, 0);
    rect(pointX, pointY, point1X, point1Y);
  }