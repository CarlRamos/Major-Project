class Peasant extends Units{

  //data
 
  int carryRock, carryWood, carryFood, carryWater;
  //int goX, goY;
  boolean isHarvesting;
  boolean training;
  int carryWeight;
 

  //  
  Peasant(int _x, int _y) {
   super(_x, _y, 255, 255, 155);
    
    carryRock= 0;
    carryWood= 0;
    carryFood= 0;
    carryWater= 0;
    isHarvesting = false;
    training = false;
    //didCollide = false;
  }



  

  void Harvest() {
    if ( carryRock == carryWeight || carryWood == carryWeight || carryWood == carryWater || carryFood == carryWeight ) {
    }
  }
}