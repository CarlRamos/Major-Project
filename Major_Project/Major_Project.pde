


//globals
MapGenerator theMap;
ArrayList<House> house = new ArrayList<House>();
ArrayList<Peasant> peasant = new ArrayList<Peasant>();
ArrayList<Selector> rectSelector = new ArrayList<Selector>();
ArrayList<Timer> peasantSpawnTimer = new ArrayList<Timer>();

int [] toX, toY;

int [] resources = new int[4];
int counter;



int water;
int wood;
int food;
int rock;

Timer clock;

color fillbox;



void setup() {

  // Screen size
  size(800, 800);
  counter = 1;

  toX = new int[99999];
  toY = new int[99999];

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
      thisPeasantTimer.setWaitTime(30000);

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

  int theX, theY;
  theX =  toX[counter];
  theY =  toY[counter];

  println("count" +counter);

  for (int i= 0; i < peasant.size(); i++) {
    Peasant thisPeasant = peasant.get(i);
    if (thisPeasant.isSelected) {
      thisPeasant.move(theX, theY );
    } else if (thisPeasant.isSelected==false) {
      thisPeasant.move(thisPeasant.x, thisPeasant.y);
    }
  }
}
void mousePressed() {
  rectSelector.add(new Selector());

  if (mouseButton == RIGHT) {
    counter +=1;
    toX[counter]=mouseX;
    toY[counter]=mouseY;
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

        if (((x*theMap.cellWidth) + theMap.cellWidth >= thisPeasant.x()) &&  
          ((x*theMap.cellWidth)   <= thisPeasant.x + thisPeasant.Width()) &&  
          ((y*theMap.cellHeight) + theMap.cellHeight >= thisPeasant.y()) &&    
          ((y*theMap.cellHeight) <= thisPeasant.y + thisPeasant.Height()) && (theMap.board[x][y] ==1)) {    
          if (frameCount % 120 == 0) {
            thisPeasant.carryRock =+ 10;
          }
        }

        //
        if (((x*theMap.cellWidth) + theMap.cellWidth >= thisPeasant.x()) &&  
          ((x*theMap.cellWidth)   <= thisPeasant.x + thisPeasant.Width()) &&  
          ((y*theMap.cellHeight) + theMap.cellHeight >= thisPeasant.y()) &&    
          ((y*theMap.cellHeight) <= thisPeasant.y + thisPeasant.Height()) && (theMap.board[x][y] ==2)) {    
          if (frameCount % 120 == 0) {
            water += 10;
          }
        }
        //
        if (((x*theMap.cellWidth) + theMap.cellWidth >= thisPeasant.x()) &&  
          ((x*theMap.cellWidth)   <= thisPeasant.x + thisPeasant.Width()) &&  
          ((y*theMap.cellHeight) + theMap.cellHeight >= thisPeasant.y()) &&    
          ((y*theMap.cellHeight) <= thisPeasant.y + thisPeasant.Height()) && (theMap.board[x][y] ==3)) {    
          if (frameCount % 120 == 0) {
            wood += 10;
          }
        }

        //
        if (((x*theMap.cellWidth) + theMap.cellWidth >= thisPeasant.x()) &&  
          ((x*theMap.cellWidth)   <= thisPeasant.x + thisPeasant.Width()) &&  
          ((y*theMap.cellHeight) + theMap.cellHeight >= thisPeasant.y()) &&    
          ((y*theMap.cellHeight) <= thisPeasant.y + thisPeasant.Height()) && (theMap.board[x][y] ==3)) {    
          if (frameCount % 120 == 0) {
            food += 10;
          }
        }
      }
    }
  }

  for (int i=0; i<peasant.size(); i++) {
    for (int j=0; j<peasant.size(); j++) {

      Peasant currentPeasant = peasant.get(i);
      Peasant otherPeasant = peasant.get(j);
      
      if ((currentPeasant.x +  currentPeasant.theWidht > otherPeasant.x)&&

        (currentPeasant.x   < otherPeasant.x + otherPeasant.Width()) &&

        (currentPeasant.y  < otherPeasant.y + otherPeasant.Height()) &&

        (currentPeasant.y + currentPeasant.theHeight > otherPeasant.y()) &&  i != j) {
        println(" OverLapping");
      }  
      if ((currentPeasant.x +  currentPeasant.theWidht == otherPeasant.x)&&

        (currentPeasant.x   == otherPeasant.x + otherPeasant.Width()) &&

        (currentPeasant.y  == otherPeasant.y + otherPeasant.Height()) &&

        (currentPeasant.y + currentPeasant.theHeight == otherPeasant.y())) {
        println("not OverLapping");
      }
    }
  }
}