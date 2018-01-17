class Peasant {

  //data
  int hp;
  int x, y, theWidht, theHeight;
  boolean isSelected;
  int carryRock, carryWood, carryFood, carryWater;
  //int goX, goY;
  boolean isHarvesting;
  int carryWeight;
  int speed;
  //  
  Peasant(int _x, int _y) {
    x = _x;
    y = _y;
    theWidht = 10;
    theHeight = 10;
    carryRock= 0;
    carryWood= 0;
    carryFood= 0;
    carryWater= 0;
    isHarvesting = false;
    speed = 1;
  }



  //spawns the peasant
  void spawn() {
    if (isSelected) {
      fill(255); 
      //println("selected");
    }
    rect(x, y, theWidht, theHeight);
  }

  void checkIfSelected() {
    if  (mouseIsOnButton()) {
      isSelected =! isSelected;
    }
  }

  void move(int  goX, int goY) {



    //teleports to the next point (from point 1 - point 2)
    


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
      }
      else 

      println("moving");
    
  }


  boolean mouseIsOnButton() {
    return ((mouseX > x) &&
      (mouseX < x+10) &&
      (mouseY > y) &&
      (mouseY < y+10));
  }

  void Harvest(){
   if( carryRock == carryWeight || carryWood == carryWeight || carryWood == carryWater || carryFood == carryWeight ){
     
     
     
   }
    
    
  }






  int x() {
    return x;
  }

  int y() {
    return y;
  }

  int Width() {
    return theWidht ;
  }

  int Height() {
    return theHeight;
  }

  //void dontOverLap(Peasant otherPeasant) {
  //  if (x +  theWidht >= otherPeasant.x) {
  //    print("colliding L");
  //  } else if  (x   <= otherPeasant.x + otherPeasant.Width()) {
  //    print("colliding R");
      
  //  } else if (y + theHeight <= otherPeasant.y()) {
  //    print("colliding N");
      
  //  } else if (y  >= otherPeasant.y + otherPeasant.Height()) {
  //    print("colliding S");
      
  //  }
  //  else{
  //   println("not OverLapping"); 
  //  }
    
  //}
}