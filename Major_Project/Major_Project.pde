//Carl Lawrence Ramos
//
//In my major Project I attempted on doing an rts games 
//
//red = warrior
//blue = archer
//light color yellow = peasant
//
//Instructions:
//
//**if you press the following numbers that type of building will be built where your current mouse coords is
//
//1 = house
//2 = walls
//3 = Barracks
//4 = Archery
//5= farmland
//
//right click to move selected units
//left click to select one units or drag left click to form a selector rectangle
//
//if you build a House a peasant will naturally spawn there, the first peasant will spawn at around 5 sec after build and the following peasant that will be spawned there will be 30 sec apart
//If you want to train a Warrior you have to build a Barracks and with Archer you would have to build an Archery
//if you want to get a certain resource make your peasant stantd inside that resource
//You can't have two units moving at different location at the same time you would have to wait for your first unit to finish his movement before making the other unit move - since my goTo variable is global it re writes the coords of where the units is supposed to go
//
////////////////////////////////////////////////////////////////////////////////////////////KOWN BUGS
//
//can build overlapping each building and Units can move through buildings - can't figure out how to fix this one as every time i try to fix it i break my code
//if a certain is selected they would go to the last point instead of stay still - the problem is that my goTo variable is a global variable 
//
//
//



//globals
MapGenerator theMap;

//all array list 
ArrayList<Walls> walls = new ArrayList<Walls>();
ArrayList<Barracks> barracks = new ArrayList<Barracks>();
ArrayList<House> house = new ArrayList<House>();
ArrayList<Peasant> peasant = new ArrayList<Peasant>();
ArrayList<Selector> rectSelector = new ArrayList<Selector>();
ArrayList<Timer> peasantSpawnTimer = new ArrayList<Timer>();
ArrayList<Warrior> warrior = new ArrayList<Warrior>();
ArrayList<Archer> archer = new ArrayList<Archer>();
ArrayList<Archery> archery = new ArrayList<Archery>();
ArrayList<Farm> farm = new ArrayList<Farm>();

int  toX, toY;

//resource
int water;
int wood;
int food;
int rock;


Timer clock;





void setup() {



  // Screen size
  size(800, 800);



  theMap = new MapGenerator();


  //calls function for setup

  resourcesSetup();

  //initialize values for the map and generates
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
  harvest();



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





//movements settings
void keyPressed() {

  // key to build all the buildings and it would check if you have the enough resource to build the following buildings
  if (key == '1' && wood >= 10) { 
    //timer for spawn
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
  if (key == '5' && wood >10 && rock > 10&& water > 15) {

    farm.add(new Farm(mouseX, mouseY));
    //resource that would be taken away if built
    wood -= 10;
    rock -= 10;
    water -= 15;
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

  for (Farm thisFarm : farm) {
    thisFarm.build();
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

    //Natural Timer for peasant to spawn
    Timer  thisPeasantTimer = peasantSpawnTimer.get(i);

    if (thisPeasantTimer.isFinished()) {


      peasant.add(new Peasant(thisHouse.x, thisHouse.y));
      //start timer for the next spawn
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
      if (thisBarracks.mouseIsOnBuilding() && thisPeasant.isSelected) {
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
      if (thisArhcery.mouseIsOnBuilding() && thisPeasant.isSelected) {
       
        thisPeasant.training = true;
      
    } else {
        thisPeasant.training = false;
      }

      // if Peasant is being intended to be a archer once it touched the barracks it will be removed and a warrior will spawn
      if (thisArhcery.isInside(thisPeasant)&& 
        thisPeasant.training == true) {

        peasant.remove(j);
        archer.add(new Archer(thisArhcery.x, thisArhcery.y));
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

  //warrior calls moves if they are selected
  for (Warrior thisWarrior : warrior) {

    if (thisWarrior.isSelected) {
      thisWarrior.move(toX, toY);
    }
  }

  //makes every archer move if they are selected

  for (Archer thisArcher : archer) {

    if (thisArcher.isSelected) {
      thisArcher.move(toX, toY);
    }
  }



  //makes every Peasant move if they are selected
  for (int j=0; j<peasant.size(); j++) {
    Peasant thisPeasant = peasant.get(j);

    if (thisPeasant.isSelected) {
      thisPeasant.move( toX, toY);
    }
  }
}


void mousePressed() {
  rectSelector.add(new Selector());

  //sets the points where the selected units will go, if you disselect a unit they will stoop moving,
  if (mouseButton == RIGHT) {

    toX = mouseX;
    toY = mouseY;
  }
  if (mouseButton == LEFT) {


    //checks if the peasant is selected or not by a click of mouse, and if you click into nothing with left mousebutton all you currently clicked will be disselected
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

  //for Warrior
  for (int i = 0; i<warrior.size(); i++) {

    Selector tempSelector = rectSelector.get(0);
    Warrior thisWarrior = warrior.get(i);

    if (tempSelector.checkIfInside(thisWarrior.x, thisWarrior.y)) {

      thisWarrior.isSelected =!  thisWarrior.isSelected;
    }
  }

  //For archer
  for (int i = 0; i<archer.size(); i++) {

    Selector tempSelector = rectSelector.get(0);
    Archer thisArcher = archer.get(i);

    if (tempSelector.checkIfInside(thisArcher.x, thisArcher.y)) {

      thisArcher.isSelected =!  thisArcher.isSelected;
    }
  }




  rectSelector.remove(0);
  //tempSelector.delete();
}



void harvest() {
  // checks if any peasant is inside a resource tile and if so add a resource corresponding on which resource tile the peasant is standing

  for (Peasant thisPeasant : peasant) { 

    for (int x = 0; x < theMap.cols; x++) {
      for (int y = 10; y <theMap.rows; y++) {

        int   cellX = int((x*theMap.cellWidth));
        int   cellY = int((y*theMap.cellHeight));


        if (thisPeasant.isPeasantInResource(cellX, cellY, int (theMap.cellWidth), int (theMap.cellHeight)) && (theMap.board[x][y] ==1)) {    
          //time between each harvest
          if (frameCount % 120 == 0) {
            rock += 10;
          }
        }

        //
        if (thisPeasant.isPeasantInResource(cellX, cellY, int (theMap.cellWidth), int (theMap.cellHeight)) && (theMap.board[x][y] ==2)) {    
          //time between each harvest
          if (frameCount % 120 == 0) {
            water += 10;
          }
        }
        //

        if (thisPeasant.isPeasantInResource(cellX, cellY, int (theMap.cellWidth), int (theMap.cellHeight)) && (theMap.board[x][y] ==3)) {    
          //time between each harvest
          if (frameCount % 120 == 0) {
            wood += 10;
          }
        }
      }
    }
// since farm is not a natural resource it is not in a 2d array and have a different way of detecting to harvest
    for (Farm thisFarm : farm) {

      if (thisFarm.isInside(thisPeasant)) {    
        //time between each harvest
        if (frameCount % 120 == 0) {
          food += 10;
        }
      }
    }
  }
}