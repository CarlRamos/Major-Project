class MapGenerator {

  //data
  int[][] board;
  int cols, rows;
  float cellWidth, cellHeight;

int [] resources = new int[4];

  //constructor
  MapGenerator() {
    cols = 50;
    rows = 50;
  }



  //behaviour
  void displayMap() {
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


  //initialize the value of the board
  void initializeValues() {
    board = new int[cols][rows];
    cellWidth = width/cols;
    cellHeight = height/rows;
  }

  //generates the randomized position of the resources and how much of it is there
  void generateMap() {
    for (int i = 1; i<resources.length; i++) {

      int patches = int (random(10, 50));
      for (int q = 0; q < patches; q++) {

        int x = int (random(4, cols-4));
        int y = int (random(14, rows-4));

        if (board[x][y] == 0) {
          board[x][y] = i;
        }
      }
    }
  }


int cols(){
 return cols; 
  
  
}

int row(){
 return rows; 
  
  
}

int x(){
 return cols; 
  
  
}

int y(){
 return cols; 
  
  
}





}