


//globals
MapGenerator theMap;
ArrayList<House> house = new ArrayList<House>();
ArrayList<Peasant> peasant = new ArrayList<Peasant>();
ArrayList<Selector> rectSelector = new ArrayList<Selector>();
ArrayList<Timer> peasantSpawnTimer = new ArrayList<Timer>();

int [] resources = new int[4];

int water;
int wood;
int food;
int rock;

Timer clock;

color fillbox;

int toX, toY;

void setup() {

  // Screen size
  size(800, 800);


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

  println(peasantSpawnTimer.size());




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
  rock = 0;
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

  if (key == '1' && wood >= 10) { 
    house.add   (new House(mouseX, mouseY)); 
    peasantSpawnTimer.add(new Timer(3000));
    Timer thisPeasantTimer = peasantSpawnTimer.get(peasantSpawnTimer.size()-1);
    thisPeasantTimer.begin();

    wood -= 10;
  }
}


void displayBuildings() {
  // displaying/building all house that are suppose to be there
  for (House thisHouse : house) {
    thisHouse.build();
  }
}


void keyReleased() {
  //for spawning a peasant on which current house is selected
}

//function that will spawn every unit in game
void spawn() {
  //spawns peasant


  for (int i =0; i < house.size(); i++) {
    House thisHouse =  house.get(i);

    Timer  thisPeasantTimer = peasantSpawnTimer.get(i);

    if (thisPeasantTimer.isFinished()) {
      int thisHouseX, thisHouseY;
      thisHouseX = thisHouse.x;
      thisHouseY = thisHouse.y;
      println("Hell Yeah!");
      peasant.add(new Peasant(thisHouseX, thisHouseY));
      thisPeasantTimer.setWaitTime(3000);

      thisPeasantTimer.begin();
    }
  }

  for (Peasant thisPeasant : peasant) {
    thisPeasant.spawn();
  }
}

//function that will make every unit move
void move() {

  //peasant calls moves if they are selected
  for (Peasant thisPeasant : peasant) {
    thisPeasant.move(toX, toY );
  }
} 

void mousePressed() {
  rectSelector.add(new Selector());

  if (mouseButton == RIGHT) {


    //check if the house is selected or not
    for (House thisHouse : house) {
      thisHouse.checkIfSelected();
    }

    //checks if the peasant is selected or not
    for (Peasant thisPeasant : peasant) {
      thisPeasant.checkIfSelected();
    }
  }
}

void mouseReleased() {

  for (int i = 0; i<peasant.size(); i++) {
    Selector tempSelector = rectSelector.get(0);
    Peasant thisPeasant = peasant.get(i);
    if ((thisPeasant.x ()<=tempSelector.x &&
      thisPeasant.x>=tempSelector.x + tempSelector.Width()&&
      thisPeasant.y>=tempSelector.y+  tempSelector.Height()&&
      thisPeasant.y<=tempSelector.y) ||

      (thisPeasant.x ()>=tempSelector.x &&
      thisPeasant.x<=tempSelector.x + tempSelector.Width()&&
      thisPeasant.y<=tempSelector.y+  tempSelector.Height()&&
      thisPeasant.y>=tempSelector.y)) {
      Peasant tempPeasant = peasant.get(i);
      tempPeasant.isSelected =!  tempPeasant.isSelected;
    }
  }


  rectSelector.remove(0);
  //tempSelector.delete();
}



void mouseClicked() {
  toX= mouseX;
  toY= mouseY;
}