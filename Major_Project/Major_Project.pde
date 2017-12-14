


//globals
MapGenerator theMap;
ArrayList<House> house = new ArrayList<House>();

float peopleX, peopleY, peopleWidth, peopleHeight;
float enemyX, enemyY, enemyWidth, enemyHeight;


int peopleSpeed; 
int [] resources = new int[4];

int water;
int wood;
int food;
int rock;


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
  house.add   (new House(mouseX,mouseY)); 
  wood -= 10;
  
}
}

void displayBuildings(){
  for(House thisHouse:house){
    thisHouse.build();  
  }
  
  
}

void anyHouseSelected(){
 for(int i = 0; i < house.size(); i++){
   House thisHouse;
   thisHouse = house.get(i);
   if (thisHouse.isSelected) {
    println("house is Selected");
  }
   
 }
  
  
}



void mouseClicked() {
  for (House thisHouse:house) {
    thisHouse.checkIfSelected();
  }
}