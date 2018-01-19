class Peasant extends Units {

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
    
    //this is to prevent that if a peasant walks over a barracks or archery but not intended to train it to another unit 
    training = false;
  }


  //special function to help in harvest function
  boolean isPeasantInResource(int cellX, int cellY, int cellWidth, int cellHeight) {

    return ((cellX + cellWidth >=   x) &&  
      (cellX   <=   x +   theWidht) &&  
      (cellY + cellHeight >=   y) &&    
      (cellY <=   y +   theHeight));
  }
}