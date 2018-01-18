class Buildings {

  //data
  int x, y, theWidth, theHeight;
  int health;
  boolean isSelected;
  int r, g, b;

  //constructor
  Buildings(int _x, int _y, int _theWidth, int _theHeight, int _health, int _r, int _g, int _b) {
    x = _x;
    y = _y;
    r = _r;
    g = _g;
    b = _b;
    theWidth = _theWidth;
    theHeight =  _theHeight;
    health =  _health;
    isSelected = false;
    
  }


  void build() {
   
  fill(r, g, b);
    
    rect(x, y, theWidth, theHeight); 

    //println("house");
  }



  void checkIfSelected() {
    if  (mouseIsOnButton()) {
      isSelected =! isSelected;
    }
  }

  //asks if the mouse is on top of the house 
  boolean mouseIsOnButton() {
    return ((mouseX > x) &&
      (mouseX < x+theWidth) &&
      (mouseY > y) &&
      (mouseY < y+theHeight));
  }

   boolean isInside(Peasant thisPeasant) {
    return (thisPeasant.x + thisPeasant.theWidht > x && 
      thisPeasant.x < (x + theWidth) &&
      thisPeasant.y + thisPeasant.theHeight > y && 
      thisPeasant.y < y +theHeight);
  }
}