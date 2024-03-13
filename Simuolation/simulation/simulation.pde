class Grid {
  float squareSize;
  int gridWidth;
  int gridHeight;
  String rule;
  int smokeDecay;
  int[][] grid;
  int[][] newGrid;
  float[][] waterGrid;
  int generation;
  int[] B;
  int[] S;
  float waterTreshold;
  
  Grid(float squareSize, int gridWidth, int gridHeight, String rule, int smokeDecay, float waterTreshold) {
    this.squareSize = squareSize;
    this.gridWidth = gridWidth;
    this.gridHeight = gridHeight;
    this.rule = rule;
    this.smokeDecay = smokeDecay;
    this.waterTreshold = waterTreshold;
    this.grid = new int[this.gridHeight][];
    this.newGrid = new int[this.gridHeight][];
    this.waterGrid = new float[this.gridHeight][];
    this.generation = 14;
    this.parseRule(this.rule);
  }
  
  void printGrid() {
    for (int i = 0; i < this.gridHeight; i++) {
      for (int j = 0; j < this.gridWidth; j++) {
        print(this.grid[i][j] + " ");
      }
      println();
    }
  }
  
  void parseRule(String rule) {
    String[] parts = split(rule, '/');
    String bPart = parts[0].substring(1);
    String sPart = parts[1].substring(1);
    
    this.B = new int[bPart.length()];
    for (int i = 0; i < bPart.length(); i++) {
      this.B[i] = Integer.parseInt(bPart.charAt(i) + "");
    }
    
    this.S = new int[sPart.length()];
    for (int i = 0; i < sPart.length(); i++) {
      this.S[i] = Integer.parseInt(sPart.charAt(i) + "");
    }
  }
  
  boolean containsElement(int[] array, int value) {
    for (int i = 0; i < array.length; i++) {
      if (array[i] == value) {
        return true;
      }
    }
    return false; 
  }
  
  void updateNewGrid() {
    for (int i = 0; i < this.grid.length; i++) {
      for (int j = 0; j < this.grid[i].length; j++) {
        this.newGrid[i][j] = this.grid[i][j];
      }
    }
  }
  
  void updateGrid() {
    for (int i = 0; i < this.grid.length; i++) {
      for (int j = 0; j < this.grid[i].length; j++) {
        this.grid[i][j] = this.newGrid[i][j];
      }
    }
  }
  
  boolean availableSpace(int i, int j) {
    if (j-1 >= 0 && (this.newGrid[i][j-1] == 0 || (this.newGrid[i][j-1] == 7 && this.waterGrid[i][j-1] < 1. + this.waterTreshold))) return true;
    if (j+1 < this.gridWidth && (this.newGrid[i][j+1] == 0 || (this.newGrid[i][j+1] == 7 && this.waterGrid[i][j+1] < 1. + this.waterTreshold))) return true;
    println("Mamico ti jebem");
    return false;
  }
  
  void updateWater(int i, int j) {
    if (i + 1 < this.gridHeight && this.newGrid[i + 1][j] == 0) {
        this.newGrid[i][j] = 0;
        this.newGrid[i + 1][j] = 7;
        this.waterGrid[i + 1][j] = this.waterGrid[i][j];
        this.waterGrid[i][j] = 0.;
    }
    else if (i + 1 < this.gridHeight && this.newGrid[i + 1][j] == 7 && this.waterGrid[i+1][j] < 1. + this.waterTreshold) {
      if(i == 8 && j == 2) {
        println("##############################################");
        this.printGrid();
      }
      float waterTransfer;
      if (i - 1 >= 0 && this.newGrid[i-1][j] == 7 && this.waterGrid[i-1][j] >= 1) waterTransfer = abs((1. + this.waterTreshold) - this.waterGrid[i + 1][j]);
      else waterTransfer = abs(1. - this.waterGrid[i + 1][j]);
      
      println(waterTransfer);
      
      if (waterTransfer < this.waterGrid[i][j]) {
        this.waterGrid[i + 1][j] += waterTransfer;
        this.waterGrid[i][j] -= waterTransfer;
      } else {
        this.waterGrid[i + 1][j] += this.waterGrid[i][j];
        this.waterGrid[i][j] = 0;
      }
      
      if (this.waterGrid[i][j] == 0.) this.newGrid[i][j] = 0;
      
    }
    else if (j + 1 <= this.gridWidth && this.newGrid[i][j+1] == 0) {
      float waterTransfer = (this.waterGrid[i][j] + this.waterGrid[i][j+1])/2;
      this.waterGrid[i][j] = waterTransfer;
      this.waterGrid[i][j+1] = waterTransfer;
      this.newGrid[i][j+1] = 7;
    }
    //else if (j + 1 < this.gridWidth && j - 1 >= 0 && this.newGrid[i][j+1] == 7 && this.newGrid[i][j-1] == 7) {
    //  //float waterTransfer = (this.waterGrid[i][j+1] + this.waterGrid[i][j] + this.waterGrid[i][j-1])/3;
    //  //this.waterGrid[i][j] = waterTransfer;
    //  //this.waterGrid[i][j+1] = waterTransfer;
    //  //this.waterGrid[i][j-1] = waterTransfer;
    //}
    else if (j + 1 < this.gridWidth && this.newGrid[i][j+1] == 7 && this.waterGrid[i][j] > this.waterGrid[i][j+1]) {
      float waterTransfer = (this.waterGrid[i][j] + this.waterGrid[i][j+1])/2;
      if (i - 1 >= 0 && this.newGrid[i-1][j] == 7 && this.waterGrid[i-1][j] >= 1) waterTransfer = abs((1. + this.waterTreshold) - this.waterGrid[i][j+1]);
      else if (j - 1 >= 0 && this.newGrid[i][j-1] == 7) waterTransfer = abs((1. + this.waterTreshold) - this.waterGrid[i][j+1]);
      else waterTransfer = abs(1. - this.waterGrid[i][j+1]);
      //this.waterGrid[i][j] = waterTransfer;
      //this.waterGrid[i][j+1] = waterTransfer;
      if (this.waterGrid[i][j+1] < (1. + this.waterTreshold)) {
        if (waterTransfer < this.waterGrid[i][j]) {
          this.waterGrid[i][j+1] += waterTransfer;
          this.waterGrid[i][j] -= waterTransfer;
        } else {
          this.waterGrid[i][j+1] += this.waterGrid[i][j];
          this.waterGrid[i][j] = 0;
        }
      }
      
    }
    else if (this.waterGrid[i][j] > 1.) {
       if (i - 1 >= 0 && this.newGrid[i-1][j] == 0 || this.newGrid[i-1][j] == 7) {
         float waterTransfer = abs(1. - this.waterGrid[i][j]);
         this.waterGrid[i][j] -= waterTransfer;
         this.waterGrid[i - 1][j] += waterTransfer;
         this.newGrid[i-1][j] = 7;
       }
    }

    //else if (i + 1 < this.gridHeight && this.newGrid[i + 1][j] == 7 && this.waterGrid[i+1][j] < (1. + this.waterTreshold)) {
    //    float waterTransfer = (1. + this.waterTreshold) - this.waterGrid[i + 1][j];
    //    if (i - 1 >= 0 && this.grid[i-1][j] == 7 && !this.availableSpace(i, j)) waterTransfer = (1. + this.waterTreshold) - this.waterGrid[i + 1][j];
    //    else waterTransfer = 1. - this.waterGrid[i + 1][j];
        
    //    if (waterTransfer > this.waterGrid[i][j]) {
    //      this.waterGrid[i + 1][j] += this.waterGrid[i][j];
    //      this.waterGrid[i][j] = 0;
    //    } else {
    //      this.waterGrid[i + 1][j] += waterTransfer;
    //      this.waterGrid[i][j] -= waterTransfer;
    //    }
    //    println(this.waterGrid[i][j]);
    //    if (this.waterGrid[i][j] == 0.) this.newGrid[i][j] = 0;
    //}
    //else if (i + 1 < this.gridHeight && j - 1 >= 0 && this.newGrid[i + 1][j - 1] == 0) {
    //  if (i + 1 < this.gridHeight && j + 1 < this.gridWidth && this.newGrid[i + 1][j + 1] == 0) { //levo frej, desno frej
    //    this.newGrid[i][j] = 0;
    //    this.newGrid[i + 1][j - 1] = 7;
    //    this.newGrid[i + 1][j + 1] = 7;
    //    this.waterGrid[i+1][j-1] = this.waterGrid[i][j]/2;
    //    this.waterGrid[i+1][j+1] = this.waterGrid[i][j]/2;
    //    this.waterGrid[i][j] = 0.;
    //  }
    //  else if (i + 1 < this.gridHeight && j + 1 < this.gridWidth && this.newGrid[i + 1][j + 1] == 7 && this.waterGrid[i+1][j+1] < (1. + this.waterTreshold)) { //levo frej, desno voda
    //    this.waterGrid[i+1][j-1] = this.waterGrid[i][j]/2;
    //    this.waterGrid[i+1][j+1] = this.waterGrid[i][j]/2;
    //    this.newGrid[i+1][j-1] = 7;
    //    this.waterGrid[i][j] = 0.;
    //    this.newGrid[i][j] = 0;
    //    if (this.waterGrid[i+1][j+1] > (1. + this.waterTreshold)) {
    //      float waterTransfer = abs((1. + this.waterTreshold) - this.waterGrid[i+1][j+1]);
    //      this.waterGrid[i+1][j+1] -= waterTransfer;
    //      this.waterGrid[i+1][j-1] += waterTransfer;
    //    }
    //  }
    //  else { //levo frej, desno ni frej
    //    this.newGrid[i][j] = 0;
    //    this.newGrid[i + 1][j - 1] = 7;
    //    this.waterGrid[i+1][j-1] = this.waterGrid[i][j];
    //    this.waterGrid[i][j] = 0.;
    //  }
    //}
    //else if (i + 1 < this.gridHeight && j - 1 >= 0 && this.newGrid[i + 1][j - 1] == 7 && this.waterGrid[i+1][j-1] < (1. + this.waterTreshold)) { 
    //  if (i + 1 < this.gridHeight && j + 1 < this.gridWidth && this.newGrid[i + 1][j + 1] == 0) { //levo voda, desno frej
    //    this.waterGrid[i+1][j-1] = this.waterGrid[i][j]/2;
    //    this.waterGrid[i+1][j+1] = this.waterGrid[i][j]/2;
    //    this.newGrid[i+1][j+1] = 7;
    //    this.waterGrid[i][j] = 0.;
    //    this.newGrid[i][j] = 0;
    //    if (this.waterGrid[i+1][j-1] > (1. + this.waterTreshold)) {
    //      float waterTransfer = abs((1. + this.waterTreshold) - this.waterGrid[i+1][j-1]);
    //      this.waterGrid[i+1][j-1] -= waterTransfer;
    //      this.waterGrid[i+1][j+1] += waterTransfer;
    //    }
    //  }
    //  else if (i + 1 < this.gridHeight && j + 1 < this.gridWidth && this.newGrid[i + 1][j + 1] == 7 && this.waterGrid[i+1][j+1] < (1. + this.waterTreshold)) { //levo voda, desno voda
    //    this.waterGrid[i+1][j-1] = this.waterGrid[i][j]/2;
    //    this.waterGrid[i+1][j+1] = this.waterGrid[i][j]/2;
    //    this.waterGrid[i][j] = 0.;
    //    this.newGrid[i][j] = 0;
    //    if (this.waterGrid[i+1][j-1] > (1. + this.waterTreshold)) {
    //      float waterTransfer = abs((1. + this.waterTreshold) - this.waterGrid[i+1][j-1]);
    //      this.waterGrid[i+1][j-1] -= waterTransfer;
    //      this.waterGrid[i+1][j+1] += waterTransfer;
    //    }
    //    if (this.waterGrid[i+1][j+1] > (1. + this.waterTreshold)) {
    //      float waterTransfer = abs((1. + this.waterTreshold) - this.waterGrid[i+1][j+1]);
    //      this.waterGrid[i+1][j+1] -= waterTransfer;
    //      this.waterGrid[i][j] += waterTransfer;
    //      this.newGrid[i][j] = 7;
    //    }
    //  }
    //  else { //levo voda, desno ni frej
    //    this.waterGrid[i+1][j-1] += this.waterGrid[i][j];
    //    if (this.waterGrid[i+1][j-1] > (1. + this.waterTreshold)) {
    //      float waterTransfer = abs((1. + this.waterTreshold) - this.waterGrid[i+1][j-1]);
    //      this.waterGrid[i+1][j-1] -= waterTransfer;
    //      this.waterGrid[i][j] = waterTransfer;
    //    }
    //    else {
    //      waterGrid[i][j] = 0.;
    //      this.newGrid[i][j] = 0;
    //    }
    //  }
    //}
    //else if (i + 1 < this.gridHeight && j + 1 < this.gridWidth && this.newGrid[i + 1][j + 1] == 0) { //levo ni frej, desno frej
    //  this.newGrid[i][j] = 0;
    //  this.newGrid[i + 1][j + 1] = 7;
    //  this.waterGrid[i+1][j+1] = this.waterGrid[i][j];
    //  this.waterGrid[i][j] = 0.;
    //  //if (i - 1 >= 0 && this.grid[i-1][j] != 7 && this.waterGrid[i+1][j+1] > 1.) {
    //  //  float waterTransfer = abs(1. - this.waterGrid[i+1][j+1]);
    //  //  this.waterGrid[i+1][j+1] -= waterTransfer;
    //  //  this.waterGrid[i][j] = waterTransfer;
    //  //}
    //}
    //else if (i + 1 < this.gridHeight && j + 1 < this.gridWidth && this.newGrid[i + 1][j + 1] == 7 && this.waterGrid[i+1][j+1] < (1. + this.waterTreshold)) { //levo ni frej, desno voda
    //  this.waterGrid[i+1][j+1] += this.waterGrid[i][j];
    //  if (this.waterGrid[i+1][j+1] > (1. + this.waterTreshold)) {
    //    float waterTransfer = abs((1. + this.waterTreshold) - this.waterGrid[i+1][j+1]);
    //    this.waterGrid[i+1][j+1] -= waterTransfer;
    //    this.waterGrid[i][j] = waterTransfer;
    //  }
    //  else {
    //    waterGrid[i][j] = 0.;
    //    this.newGrid[i][j] = 0;
    //  }
    //}
    //else if (j - 1 >= 0 && (this.newGrid[i][j - 1] == 7 || this.newGrid[i][j - 1] == 0) && this.waterGrid[i][j - 1] < this.waterGrid[i][j]) {
    //    if (j + 1 < this.gridWidth && (this.newGrid[i][j + 1] == 7 || this.newGrid[i][j + 1] == 0) && this.waterGrid[i][j + 1] < this.waterGrid[i][j]) {
    //        float waterTransfer = (this.waterGrid[i][j] + this.waterGrid[i][j - 1] + this.waterGrid[i][j + 1])/3;
    //        this.waterGrid[i][j] = waterTransfer;
    //        this.waterGrid[i][j + 1] = waterTransfer;
    //        this.waterGrid[i][j - 1] = waterTransfer;
    //        this.newGrid[i][j + 1] = 7;
    //        this.newGrid[i][j - 1] = 7;
    //    } else {
    //        float waterTransfer = (this.waterGrid[i][j] + this.waterGrid[i][j - 1])/2;
    //        this.waterGrid[i][j] = waterTransfer;
    //        this.waterGrid[i][j - 1] = waterTransfer;
    //        this.newGrid[i][j - 1] = 7;
    //    }
    //} 
    //else if (j + 1 < this.gridWidth && (this.newGrid[i][j + 1] == 7 || this.newGrid[i][j + 1] == 0) && this.waterGrid[i][j + 1] < this.waterGrid[i][j]) {
    //    float waterTransfer = (this.waterGrid[i][j] + this.waterGrid[i][j + 1])/2;
    //    this.waterGrid[i][j] = waterTransfer;
    //    this.waterGrid[i][j + 1] = waterTransfer;
    //    this.newGrid[i][j + 1] = 7;
    //}
    //else if (this.waterGrid[i][j] > 1.) {
    //   if (i - 1 >= 0 && (this.newGrid[i-1][j] == 0 || (this.newGrid[i-1][j] == 7 && this.waterGrid[i-1][j] < (1. + this.waterTreshold)))) {
    //     float waterTransfer = this.waterGrid[i][j] - 1.;
    //     this.waterGrid[i][j] -= waterTransfer;
    //     this.waterGrid[i-1][j] += waterTransfer;
    //     this.newGrid[i-1][j] = 7;
    //     if (this.waterGrid[i-1][j] > (1. + this.waterTreshold)) {
    //       waterTransfer = this.waterGrid[i-1][j] - (1. + this.waterTreshold);
    //       this.waterGrid[i-1][j] -= waterTransfer;
    //       this.waterGrid[i][j] += waterTransfer;
    //     }
    //   }
    //}
   } 
  
  void update() {
    this.updateNewGrid();
    for (int i = this.gridHeight - 1; i >= 0; i--) {
      for (int j = 0; j < this.gridWidth; j++) {
        if (this.generation < 15) {
          int neighbours = 0;
          for (int k = i - 1; k <= i + 1; k++) {
            if (k < 0 || k >= this.gridHeight) continue;
            if (k == i) {
              for (int l = j - 1; l <= j + 1; l += 2) {
                if (l < 0 || l >= this.gridWidth) continue;
                if (grid[k][l] == 1) neighbours++;
              }
            } else {
              for (int l = j - 1; l <= j + 1; l ++) {
                if (l < 0 || l >= this.gridWidth) continue;
                if (this.grid[k][l] == 1) neighbours++;
              }
            }
          }
          if (this.grid[i][j] == 0) {
            if (containsElement(this.B, neighbours)) {
              this.newGrid[i][j] = 1;
            } else this.newGrid[i][j] = 0;
          } else if (this.grid[i][j] == 1) {
            if (containsElement(this.S, neighbours)) {
              newGrid[i][j] = 1;
            } else newGrid[i][j] = 0;
          }
        } else if (generation == 15) {
          this.generateElements();
          this.generation++;
        } else {
          if (this.grid[i][j] == 7) this.updateWater(i, j);
        }
      }
    }
    this.updateGrid();
    this.generation++;
    println("Generation: " + this.generation);
  }
  
  void generateElements() {
    for (int i = 0; i < this.gridHeight; i++) {
      for (int j = 0; j < this.gridWidth; j++) {
        if (this.grid[i][j] == 1) continue;
        float r = random(1); // Generates a number between 0.0 and 1.0
        if (r < 0.15) { // 40% chance
            //grid[i][j] = 2;
        } else if (r < 0.3) { // 60% chance
            //grid[i][j] = 3;
        } else if (r < 0.5) { // 60% chance
            //this.newGrid[i][j] = 7;
            //this.waterGrid[i][j] = 0.5;
        }
        else if (r > 0.8) { // 60% chance
            //grid[i][j] = 4;
        }
        //grid[i][j] = 0;
      }
    }
    
    
    //this.newGrid[9][5] = 1;
    //this.newGrid[8][4] = 1;
    //this.newGrid[7][4] = 1;
    //this.newGrid[6][4] = 1;
    //this.newGrid[5][4] = 1;
    //this.newGrid[4][4] = 1;
    
    //this.newGrid[9][1] = 1;
    this.newGrid[8][2] = 1;
    this.newGrid[7][2] = 1;
    this.newGrid[6][2] = 1;
    this.newGrid[5][2] = 1;
    this.newGrid[4][2] = 1;
    
    this.newGrid[9][4] = 1;
    this.newGrid[8][4] = 1;
    this.newGrid[7][4] = 1;
    this.newGrid[6][4] = 1;
    this.newGrid[5][4] = 1;
    this.newGrid[4][4] = 1;
    
    this.newGrid[8][0] = 7;
    this.newGrid[7][0] = 7;
    this.newGrid[6][0] = 7;
    this.newGrid[5][0] = 7;
    //this.newGrid[4][0] = 7;
    
    //this.newGrid[4][0] = 7;
    //this.newGrid[4][1] = 7;
    //this.newGrid[4][2] = 7;
    //this.newGrid[4][3] = 7;
    
    //this.newGrid[5][0] = 7;
    //this.newGrid[5][1] = 7;
    //this.newGrid[5][2] = 7;
    //this.newGrid[5][3] = 7;
    
    //this.newGrid[6][0] = 7;
    //this.newGrid[6][1] = 7;
    //this.newGrid[6][2] = 7;
    //this.newGrid[6][3] = 7;
    
    this.waterGrid[8][0] = 1.;
    this.waterGrid[7][0] = 1.;
    this.waterGrid[6][0] = 1.;
    this.waterGrid[5][0] = 1.;
    //this.waterGrid[4][0] = 1.;
    
    //this.waterGrid[4][0] = 1.;
    //this.waterGrid[4][1] = 1.;
    //this.waterGrid[4][2] = 1.;
    //this.waterGrid[4][3] = 1.;
    
    //this.waterGrid[5][0] = 1.;
    //this.waterGrid[5][1] = 1.;
    //this.waterGrid[5][2] = 1.;
    //this.waterGrid[5][3] = 1.;
    
    //this.waterGrid[6][0] = 1.;
    //this.waterGrid[6][1] = 1.;
    //this.waterGrid[6][2] = 1.;
    //this.waterGrid[6][3] = 1.;
  }
  
  void generateGrid() {
    float fillProbability = random(0.4, 0.5);
    for (int i = 0; i < this.gridHeight; i++) {
      int[] rowGrid = new int[this.gridWidth];
      int[] rowNewGrid = new int[this.gridWidth];
      float[] rowWaterGrid = new float[this.gridWidth];
      for (int j = 0; j < gridWidth; j++) {
          float r = random(1); // Generates a number between 0.0 and 1.0
          r = 1;
          if (r < fillProbability) { // 40% chance
              rowGrid[j] = 1;
              rowNewGrid[j] = 1;
          } else { // 60% chance
              rowGrid[j] = 0;
              rowNewGrid[j] = 0;
          }
          rowWaterGrid[j] = 0.;
      }
      this.grid[i] = rowGrid;
      this.newGrid[i] = rowNewGrid;
      this.waterGrid[i] = rowWaterGrid;
    }
  }
  
  void drawGrid() {
    for (int i = 0; i < this.gridHeight; i++) {
      for (int j = 0; j < this.gridWidth; j++) {
        if (this.grid[i][j] == 0) fill(0);
        else if (this.grid[i][j] == 1) fill(255);
        else if (this.grid[i][j] == 7) fill(0, 0, 155 + (int)(((this.waterTreshold + 1.) - this.waterGrid[i][j]) * 100));
        
        rect(j * this.squareSize, i * this.squareSize, this.squareSize, this.squareSize);
        
        if (this.grid[i][j] == 7) {
          fill(255);
          textAlign(CENTER, CENTER);
          float textX = j * squareSize + squareSize / 2;
          float textY = i * squareSize + squareSize / 2;
          text(this.waterGrid[i][j], textX, textY);
        }
      }
    }
  }

}

Grid myGrid;
boolean tmp = false;

void setup() {
  size(800, 800);
  background(100, 100, 100);
  myGrid = new Grid(80, 10, 10, "B678/S2345678", 25, 0.25);
  myGrid.generateGrid();
  myGrid.drawGrid();
}

void draw() {
  
  if (tmp) {
    
    background(100);
    myGrid.update();
    myGrid.drawGrid();
    //delay(300);
    tmp = false;
    myGrid.printGrid();
  }
}

void mousePressed() {
  tmp = true;
}
