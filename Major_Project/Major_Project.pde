
//globals
float peopleX, peopleY, peopleWidth, peopleHeight;
float enemyX, enemyY, enemyWidth, enemyHeight;

int[][] board;
int cols, rows;
float cellWidth, cellHeight;

int peopleSpeed; 
int [] resources = new int[4];

int water;
int wood;
int food;
int rock;


void setup() {
  // Screen size
  size(800, 800);

  //setup for the board/grid
  cols = 50;
  rows = 50;
//calls function for setup
  peopleSetup();
  resourcesSetup();
  
  initializeValues();
  mapgenerator();
}

void draw() {
  // calling out all the functions
  background(0);
  displayBoard();
  displayResource();
  spawnPeople();
  spawnEnemy();



}

void resourcesSetup() {
  //resources setup and starting points
  water = 100;
  wood = 100;
  food = 100;
  rock = 0;
}



void peopleSetup() {
  // settings for the player's character
  peopleX = 100;
  peopleY = 400;
  peopleWidth  = 10;
  peopleHeight  = 10;
  peopleSpeed = 1;
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

void colisionDetection() {
//to see if the player is currently in a certain tile that gives a resources, so if he is he gets that certain resources every 120 frames
  for (int x = 0; x < cols; x++) {
    for (int y = 10; y <rows; y++) {
      
  //checks if the player is in a tile with the rock resource on it
      if (((x*cellWidth) + cellWidth >= peopleX) &&  
        ((x*cellWidth)   <= peopleX + peopleWidth) &&  
        ((y*cellHeight) + cellHeight >= peopleY) &&    
        ((y*cellHeight) <= peopleY + peopleHeight) && (board[x][y] ==1)) {    
        if (frameCount % 120 == 0) {
          rock += 10;
        }
      }

      //checks if the player is in a tile with the water resource on it
      if (((x*cellWidth) + cellWidth >= peopleX) &&  
        ((x*cellWidth)   <= peopleX + peopleWidth) &&  
        ((y*cellHeight) + cellHeight >= peopleY) &&    
        ((y*cellHeight) <= peopleY + peopleHeight) && (board[x][y] ==2)) {    
        if (frameCount % 120 == 0) {
          water += 10;
        }
      }
      //checks if the player is in a tile with the wood resource on it
      if (((x*cellWidth) + cellWidth >= peopleX) &&  
        ((x*cellWidth)   <= peopleX + peopleWidth) &&  
        ((y*cellHeight) + cellHeight >= peopleY) &&    
        ((y*cellHeight) <= peopleY+ peopleHeight) && (board[x][y] ==3)) {    
        if (frameCount % 120 == 0) {
          wood += 10;
        }
      }

      //checks if the player is in a tile with the food resource on it
      if (((x*cellWidth) + cellWidth >= peopleX) &&  
        ((x*cellWidth)   <= peopleX + peopleWidth) &&  
        ((y*cellHeight) + cellHeight >= peopleY) &&    
        ((y*cellHeight) <= peopleY + peopleHeight) && (board[x][y] ==4)) {    
        if (frameCount % 120 == 0) {
          food += 10;
        }
      }
      //checks if the player is in a tile with a house  resource on it
       else {
        
    //filling a color for the player
        fill(0);
      }
    }
  }
}

//spawn's enemy and colors
void spawnEnemy() {
  fill(255, 0, 0);
  rect (enemyX, enemyY, enemyWidth, enemyHeight);
}

//spawning player's character
void spawnPeople() {
  // calling colisions detection to apply it
  colisionDetection(); 
  
  rect (peopleX, peopleY, peopleWidth, peopleHeight);
}

//displaying board and the resources that is set up for resources
void displayBoard() {
  for (int x=0; x<cols; x++) {
    for (int y=10; y<rows; y++) {
    
      // coloring the tile on a certain color for a certain resource tile
     if (board[x][y] == 1) {
        fill(135);  //rock resource
      
    } else if (board[x][y] == 2) {
        fill(0, 0, 250); //water resource
      
    } else if (board[x][y] == 3) {
        fill(0, 155, 0); //wood resource
      
    } else if (board[x][y] == 4) {
        fill(50, 155, 0); //food resource
      
    } else if (board[x][y] == 5) {
        fill(55, 25, 5); //house tile
      
    } else {
        board[x][y] = 0;
        fill(255); //default
     
    }
    //drawing the tiles
      //noStroke();
      rect(x*cellWidth, y*cellHeight, cellWidth, cellHeight);
    }
  }
}

//board tile settings
void initializeValues() {
  board = new int[cols][rows];
  cellWidth = width/cols;
  cellHeight = height/rows;
}

//generates the randomized position of the resources and how much of it is there
void mapgenerator() {
  for (int i = 1; i<resources.length; i++) {

    int patches = int (random(10, 20));
    for (int q = 0; q < patches; q++) {

      int x = int (random(4, cols-4));
      int y = int (random(14, rows-4));
      println(i, x, y);
      if (board[x][y] == 0) {
        board[x][y] = i;
      }
    }
  }
}  



//movements settings
void keyPressed() {

  // building settings
  int xCord = int(mouseX/cellWidth);
  int yCord = int(mouseY/cellHeight);

// building the house and deducting the right amount of resources
  if (key == '1' && wood >= 50) {
    if (board[xCord][yCord] == 0) {
      board[xCord][yCord] = 5;
      wood -= 50;
    }
  }
  
//resources needed for building the farm and deducting it 
  if (key == '2' && wood >= 20 && rock >= 20 && water >= 20) {
    if (board[xCord][yCord] == 0) {
      board[xCord][yCord] = 4;
      wood -= 20;
      rock -= 20;
      food -= 20;
    }
  }
}