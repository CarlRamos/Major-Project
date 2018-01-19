class Buildings {

  //data
  int x, y, theWidth, theHeight;
  int health;
  boolean isSelected;
  int r, g, b;

  //constructor (takes x and y and the Width and Height and the color also the health
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

// draws the building/ display
  void build() {
   
  fill(r, g, b);
    
    rect(x, y, theWidth, theHeight); 

    //println("house");
  }


//checks if selected
  void checkIfSelected() {
    if  (mouseIsOnBuilding()) {
      isSelected =! isSelected;
    }
  }

  //asks if the mouse is on top of the house 
  boolean mouseIsOnBuilding() {
    return ((mouseX > x) &&
      (mouseX < x+theWidth) &&
      (mouseY > y) &&
      (mouseY < y+theHeight));
  }

//a boolean question to see if a current Peasant is inside a certain building, used for Barracks, and Archery to train a unit, and farm
   boolean isInside(Peasant thisPeasant) {
    
     return (thisPeasant.x + thisPeasant.theWidht > x && 
      thisPeasant.x < (x + theWidth) &&
      thisPeasant.y + thisPeasant.theHeight > y && 
      thisPeasant.y < y +theHeight);
  }
}