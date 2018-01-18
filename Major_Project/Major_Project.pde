


//globals
MapGenerator theMap;
ArrayList<Walls> walls = new ArrayList<Walls>();
ArrayList<Barracks> barracks = new ArrayList<Barracks>();
ArrayList<House> house = new ArrayList<House>();
ArrayList<Peasant> peasant = new ArrayList<Peasant>();
ArrayList<Selector> rectSelector = new ArrayList<Selector>();
ArrayList<Timer> peasantSpawnTimer = new ArrayList<Timer>();
ArrayList<Warrior> warrior = new ArrayList<Warrior>();
ArrayList<Archer> archer = new ArrayList<Archer>();
ArrayList<Archery> archery = new ArrayList<Archery>();

int  toX, toY;


int counter;



int water;
int wood;
int food;
int rock;

int forceFix =0;
Timer clock;

color fillbox;



void setup() {



  // Screen size
  size(800, 800);
  counter = 1;


  theMap = new MapGenerator();


  //calls function for setup

  resourcesSetup();

  theMap.initializeValues();
  theMap.generateMap();
}

void draw() {
  // calling out all the functions
  background(0);
  theMap.displayMap();
  displayResource();
  displayBuildings();
  spawn();
  move();
  colisionDetection();

  println(walls.size());


  if (mousePressed == true) {
    Selector tempSelector = rectSelector.get(0);
    tempSelector.drawRectangle();
  }
}


void resourcesSetup() {
  //resources setup and starting points
  water = 100;
  wood = 100;
  food = 100;
  rock = 100;
}






void displayResource() {
  //displays each resources in the top screen 
  text("Water:", 100, 50); 
  text(water, 150, 50); 
  //
  text("Wood:", 100, 70); 
  text(wood, 150, 70); 
  //
  text("Rock:", 100, 90); 
  text(rock, 150, 90); 
  //
  text("Food:", 100, 110); 
  text(food, 150, 110);
}


void forcedFix() {
  if (house.size()>=1) {
    walls.add(new Walls(-11, -11)); 
    forceFix += 1;
  }
}



//movements settings
void keyPressed() {

  if (key == '1' && wood >= 10) { 
    house.add   (new House(mouseX, mouseY)); 
    peasantSpawnTimer.add(new Timer(3000));
    Timer thisPeasantTimer = peasantSpawnTimer.get(peasantSpawnTimer.size()-1);
    thisPeasantTimer.begin();

    wood -= 10;
  }

  if (key == '2' && wood >= 15) { 
    walls.add   (new Walls(mouseX, mouseY)); 



    wood -= 15;
  }


  if (key == '3' && wood >20 && rock > 25) {
    barracks.add(new Barracks(mouseX, mouseY));
    wood -= 20;
    rock -= 25;
  }

  if (key == '4' && wood >25 && rock > 20) {
    archery.add(new Archery(mouseX, mouseY));
    wood -= 25;
    rock -= 20;
  }
}



void displayBuildings() {

  // displaying/building all house that are suppose to be there
  for (House thisHouse : house) {
    thisHouse.build();
  }

  for (Walls thisWall : walls) {
    thisWall.build();
  }

  for (Barracks thisBarracks : barracks) {
    thisBarracks.build();
  }

  for (Archery thisArchery : archery) {
    thisArchery.build();
  }
}



void keyReleased() {
  //for spawning a peasant on which current house is selected
}


//function that will spawn every unit in game
void spawn() {

  /////////////////spawns peasant\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  for (int i =0; i < house.size(); i++) {
    House thisHouse =  house.get(i);

    Timer  thisPeasantTimer = peasantSpawnTimer.get(i);

    if (thisPeasantTimer.isFinished()) {

      println("Hell Yeah!");
      peasant.add(new Peasant(thisHouse.x, thisHouse.y));
      thisPeasantTimer.setWaitTime(30000);

      thisPeasantTimer.begin();
    }
  }

  for (Peasant thisPeasant : peasant) {
    thisPeasant.spawn();
  }






  /////////////////spawns Warrior\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


  //Process
  for (int j=0; j<peasant.size(); j++) {
    for (int i = 0; i < barracks.size(); i++) {



      Barracks thisBarracks = barracks.get(i);
      Peasant thisPeasant = peasant.get(j);

      //so if the Peasant walkthrough it without being intended to be a warrior it wont be
      if (thisBarracks.mouseIsOnButton() && thisPeasant.isSelected) {
        thisPeasant.training = true;
      } else {
        thisPeasant.training = false;
      }

      // if Peasant is being intended to be a Warrior once it touched the barracks it will be removed and a warrior will spawn
      if (thisBarracks.isInside(thisPeasant)&& 
        thisPeasant.training == true) {
          
        peasant.remove(j);
        warrior.add(new Warrior(thisBarracks.x, thisBarracks.y));
      }
    }
  }

  //Displays Warrior
  for (Warrior thisWarrior : warrior) {
    thisWarrior.spawn();
  }

  //////////////Spawns Archer\\\\\\\\\\\\\\\\\\\\\\\\\\\

  //Process
  for (int j=0; j<peasant.size(); j++) {
    for (int i = 0; i < archery.size(); i++) {



      Archery thisArhcery = archery.get(i);
      Peasant thisPeasant = peasant.get(j);

      //so if the Peasant walkthrough it without being intended to be a archer it wont be
      if (thisArhcery.mouseIsOnButton() && thisPeasant.isSelected) {
        thisPeasant.training = true;
      } else {
        thisPeasant.training = false;
      }

      // if Peasant is being intended to be a archer once it touched the barracks it will be removed and a warrior will spawn
      if (thisArhcery.isInside(thisPeasant)&& 
        thisPeasant.training == true) {

        peasant.remove(j);
        warrior.add(new Warrior(thisArhcery.x, thisArhcery.y));
      }
    }
  }

  //Displays Archer
  for (Archer thisArcher : archer) {
    thisArcher.spawn();
  }
}

//function that will make every unit move
void move() {

  //peasant calls moves if they are selected
  for (Warrior thisWarrior : warrior) {
    if (thisWarrior.isSelected) {

      thisWarrior.move(toX, toY);
    }
  }
  for (Archer thisArcher : archer) {
    thisArcher.move(toX, toY);
  }




  for (int j=0; j<peasant.size(); j++) {
    Peasant thisPeasant = peasant.get(j);
    thisPeasant.move( toX, toY);
  }
}

void mousePressed() {
  rectSelector.add(new Selector());

  if (mouseButton == RIGHT) {
    counter +=1;
    toX = mouseX;
    toY = mouseY;
  }
  if (mouseButton == LEFT) {


    //check if the house is selected or not
    for (House thisHouse : house) {
      thisHouse.checkIfSelected();
    }

    //checks if the peasant is selected or not
    for (Peasant thisPeasant : peasant) {

      thisPeasant.isSelected = false;

      thisPeasant.checkIfSelected();
    }

    for (Warrior thisWarrior : warrior) {

      thisWarrior.isSelected = false;

      thisWarrior.checkIfSelected();
    }

    for (Archer thisArcher : archer) {

      thisArcher.isSelected = false;

      thisArcher.checkIfSelected();
    }
  }
}



void mouseReleased() {

  //checks if any unit is inside the Rectangle Selector
  //for peasants
  for (int i = 0; i<peasant.size(); i++) {

    Selector tempSelector = rectSelector.get(0);
    Peasant thisPeasant = peasant.get(i);

    if (tempSelector.checkIfInside(thisPeasant.x, thisPeasant.y)) {

      thisPeasant.isSelected =!  thisPeasant.isSelected;
    }
  }
  for (int i = 0; i<warrior.size(); i++) {

    Selector tempSelector = rectSelector.get(0);
    Warrior thisWarrior = warrior.get(i);

    if (tempSelector.checkIfInside(thisWarrior.x, thisWarrior.y)) {

      thisWarrior.isSelected =!  thisWarrior.isSelected;
    }
  }






  rectSelector.remove(0);
  //tempSelector.delete();
}



void colisionDetection() {

  for (Peasant thisPeasant : peasant) { 
    for (int x = 0; x < theMap.cols; x++) {
      for (int y = 10; y <theMap.rows; y++) {

        if (((x*theMap.cellWidth) + theMap.cellWidth >= mouseX) &&  
          ((x*theMap.cellWidth)   <= mouseX) &&  
          ((y*theMap.cellHeight) + theMap.cellHeight >= mouseY) &&    
          ((y*theMap.cellHeight) <= mouseY) && (theMap.board[x][y] >=1)&&(thisPeasant.isSelected)&&(mouseButton == LEFT )) {
          println("Yay");
        }
        //check if a 

        if (((x*theMap.cellWidth) + theMap.cellWidth >= thisPeasant.x) &&  
          ((x*theMap.cellWidth)   <= thisPeasant.x + thisPeasant.theWidht) &&  
          ((y*theMap.cellHeight) + theMap.cellHeight >= thisPeasant.y) &&    
          ((y*theMap.cellHeight) <= thisPeasant.y + thisPeasant.theHeight) && (theMap.board[x][y] ==1)) {    
          if (frameCount % 120 == 0) {
            thisPeasant.carryRock =+ 10;
          }
        }

        //
        if (((x*theMap.cellWidth) + theMap.cellWidth >= thisPeasant.x) &&  
          ((x*theMap.cellWidth)   <= thisPeasant.x + thisPeasant.theWidht) &&  
          ((y*theMap.cellHeight) + theMap.cellHeight >= thisPeasant.y) &&    
          ((y*theMap.cellHeight) <= thisPeasant.y + thisPeasant.theHeight) && (theMap.board[x][y] ==2)) {    
          if (frameCount % 120 == 0) {
            water += 10;
          }
        }
        //
        if (((x*theMap.cellWidth) + theMap.cellWidth >= thisPeasant.x) &&  
          ((x*theMap.cellWidth)   <= thisPeasant.x + thisPeasant.theWidht) &&  
          ((y*theMap.cellHeight) + theMap.cellHeight >= thisPeasant.y) &&    
          ((y*theMap.cellHeight) <= thisPeasant.y + thisPeasant.theHeight) && (theMap.board[x][y] ==3)) {    
          if (frameCount % 120 == 0) {
            wood += 10;
          }
        }

        //
        if (((x*theMap.cellWidth) + theMap.cellWidth >= thisPeasant.x) &&  
          ((x*theMap.cellWidth)   <= thisPeasant.x + thisPeasant.theWidht) &&  
          ((y*theMap.cellHeight) + theMap.cellHeight >= thisPeasant.y) &&    
          ((y*theMap.cellHeight) <= thisPeasant.y + thisPeasant.theHeight) && (theMap.board[x][y] ==3)) {    
          if (frameCount % 120 == 0) {
            food += 10;
          }
        }
      }
    }
  }


  for (int j=0; j<peasant.size(); j++) {
    for (int i = 0; i < walls.size(); i++) {
      Walls thisWall = walls.get(i);
      Peasant thisPeasant = peasant.get(j);
      if (thisPeasant.x + thisPeasant.theWidht > thisWall.x && 
        thisPeasant.x < (thisWall.x + thisWall.theWidth) &&
        thisPeasant.y + thisPeasant.theHeight > thisWall.y && 
        thisPeasant.y < thisWall.y +thisWall.theHeight) {
        thisPeasant.x -= 5;
      }
    }
  }
}