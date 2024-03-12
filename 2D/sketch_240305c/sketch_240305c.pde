float squareSize = 5;
int smokeDecay = 25;
int gridWidth = 160;
int gridHeight = 160;
float[][] waterGrid = new float[gridHeight][];
int[][] grid = new int[gridHeight][];
int[][] newGrid = new int[gridHeight][];
int[][] smokeTimes = new int[gridHeight][];
String rule = "B678/S2345678";
int generation = 0;

void setup() {
  size(800, 800);
  background(100, 100, 100);
  generateGrid();
  drawGrid();
  updateGrid();
}

void draw() {
  if (generation < 1500) {
    println("Generation: " + generation);
    updateGrid();
    drawGrid();
    delay(100);
    generation ++;
  } else if (generation == -15) {
    for (int i = 0; i < gridHeight; i++) {
      for (int j = 0; j < gridWidth; j++) {
        if (grid[i][j] == 1) continue;
        float r = random(1); // Generates a number between 0.0 and 1.0
        if (r < 0.15) { // 40% chance
            grid[i][j] = 2;
        } else if (r < 0.3) { // 60% chance
            grid[i][j] = 3;
        } else if (r < 0.5) { // 60% chance
            grid[i][j] = 7;
            waterGrid[i][j] = 1.;
        }
        else if (r > 0.8) { // 60% chance
            grid[i][j] = 4;
        }
        //grid[i][j] = 0;
      }
    }
    //grid[8][4] = 1;
    //grid[9][4] = 7;
    //grid[9][5] = 7;
    //grid[9][3] = 7;
    //grid[9][5] = 7;
    //grid[16][1] = 2;
    //grid[9][3] = 7;
    //grid[15][0] = 7;
    //grid[19][2] = 1;
    //grid[19][1] = 1;
    //grid[19][0] = 1;
    //grid[7][4] = 7;
    //waterGrid[7][4] = 1.0;
    //waterGrid[9][4] = 1.;
    //waterGrid[9][5] = 1.;
    //waterGrid[9][3] = 1.;
    //waterGrid[9][5] = 0.7;
    //waterGrid[9][4] = 0.2;
    //waterGrid[9][3] = 0.1;
    //waterGrid[15][0] = 0.5;
    //waterGrid[9][1] = 0.2;
    //waterGrid[19][0] = 0.5;
    drawGrid();
    generation++;
  } else {
    //arrayCopy(grid, newGrid);
    for (int i = 0; i < grid.length; i++) {
      arrayCopy(grid[i], newGrid[i]); // Copies each inner array individually
    }
    for (int i = gridHeight - 1; i >= 0; i--) {
      for (int j = 0; j < gridWidth; j++) {
        if (grid[i][j] == 2) {
          println("DELA A");
          if (i + 1 < gridHeight && (newGrid[i + 1][j] == 0 || newGrid[i + 1][j] == 4) ) {
            println("DELA B");
            newGrid[i][j] = 0;
            newGrid[i + 1][j] = 2;
          } else if (i + 1 < gridHeight && newGrid[i + 1][j] == 7 ) {
            println("DELA C");
            newGrid[i][j] = 7;
            newGrid[i + 1][j] = 2;
            waterGrid[i][j] = waterGrid[i+1][j];
            waterGrid[i+1][j] = 0;
          }
          else if (i + 1 < gridHeight && j - 1 >= 0 && newGrid[i + 1][j - 1] == 7 ) {
            println("DELA C");
            if (i + 1 < gridHeight && j + 1 < gridWidth && newGrid[i + 1][j + 1] == 7 ) {
               println("DELA D");
              int choice = (int)random(2);
              choice = 0;
              if (choice == 0) {
                if (newGrid[i][j-1] == 0) {
                  newGrid[i][j-1] = 7;
                  newGrid[i][j] = 0;
                  waterGrid[i][j-1] = waterGrid[i+1][j-1];
                } else {
                  newGrid[i][j] = 7;
                  waterGrid[i][j] = waterGrid[i+1][j-1];
                }
                newGrid[i + 1][j - 1] = 2;
                waterGrid[i+1][j-1] = 0;
              } else {
                println("UI(*(*)J()");
                if (newGrid[i][j+1] == 0) {
                  newGrid[i][j+1] = 7;
                  newGrid[i][j] = 0;
                  waterGrid[i][j+1] = waterGrid[i+1][j+1];
                  println("UI(*(*)J()");
                } else {
                  newGrid[i][j] = 7;
                  waterGrid[i][j] = waterGrid[i+1][j+1];
                }
                newGrid[i+1][j+1] = 2;
                waterGrid[i+1][j+1] = 0;
              }
            } else {
                if (newGrid[i][j-1] == 0) {
                  newGrid[i][j-1] = 7;
                  newGrid[i][j] = 0;
                  waterGrid[i][j-1] = waterGrid[i+1][j-1];
                } else {
                  newGrid[i][j] = 7;
                  waterGrid[i][j] = waterGrid[i+1][j-1];
                }
                newGrid[i + 1][j - 1] = 2;
                waterGrid[i+1][j-1] = 0;
            }
          } else if (i + 1 < gridHeight && j + 1 < gridWidth && newGrid[i + 1][j + 1] == 0 ) {
                 println("DELA E");
                if (newGrid[i][j+1] == 0) {
                  newGrid[i][j+1] = 7;
                  newGrid[i][j] = 0;
                  waterGrid[i][j+1] = waterGrid[i+1][j+1];
                } else {
                  newGrid[i][j] = 7;
                  waterGrid[i][j] = waterGrid[i+1][j+1];
                }
                newGrid[i+1][j+1] = 2;
                waterGrid[i+1][j+1] = 0;
          }
          else {
            if (i + 1 < gridHeight && j - 1 >= 0 && newGrid[i + 1][j - 1] == 0 ) {
              println("DELA F");
              if (i + 1 < gridHeight && j + 1 < gridWidth && newGrid[i + 1][j + 1] == 0 ) {
              println("DELA G");
                int choice = (int)random(2);
                if (choice == 1) {
                  newGrid[i][j] = 0;
                  newGrid[i + 1][j - 1] = 2;
                } else {
                  newGrid[i][j] = 0;
                  newGrid[i + 1][j + 1] = 2;
                }
              } else {
                newGrid[i][j] = 0;
                newGrid[i + 1][j - 1] = 2;
              }
            } else if (i + 1 < gridHeight && j + 1 < gridWidth && newGrid[i + 1][j + 1] == 0 ) {
              println("DELA H");
              newGrid[i][j] = 0;
              newGrid[i + 1][j + 1] = 2;
            }
          }
        }
        else if (grid[i][j] == 3) {
          boolean fire = false;
          for (int k = i - 1; k <= i + 1; k++) {
            for (int l = j - 1; l <= j + 1; l++) {
              try {
                if (grid[k][l] == 4 && (k != i && l != j)) {
                  fire = true;
                }
              } catch (ArrayIndexOutOfBoundsException e) {
                // Handle the case where k or l is outside the bounds of newGrid
                //println("Attempted to access an element outside the array's bounds.");
              }
            }
          }
          if (fire) {
            newGrid[i][j] = 4;
          }
          else if (i + 1 < gridHeight && newGrid[i + 1][j] == 0 ) {
            newGrid[i][j] = 0;
            newGrid[i + 1][j] = 3;
          }
          else if (i - 1 >= 0 && newGrid[i - 1][j] == 7 ) {
            newGrid[i][j] = 7;
            newGrid[i - 1][j] = 3;
            waterGrid[i][j] = waterGrid[i-1][j];
            waterGrid[i-1][j] = 0;
          }
        }
        else if (newGrid[i][j] == 4) {
          if (i + 1 < gridHeight && newGrid[i + 1][j] == 3) {
              newGrid[i][j] = 6;
              smokeTimes[i][j] = smokeDecay;
              println("asdfghjkl;'sdfghjkl;sghjjg");
          }
          else if (i + 1 == gridHeight || newGrid[i+1][j] != 0) {
            newGrid[i][j] = 5;
            smokeTimes[i][j] = smokeDecay;
            println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
          } 
          else {
            boolean left = false;
            boolean right = false;
            if (i + 1 < gridHeight && j - 1 >= 0 && newGrid[i + 1][j - 1] == 0 ) left = true;
            if (i + 1 < gridHeight && j + 1 < gridWidth && newGrid[i + 1][j + 1] == 0 ) right = true;
            
            if (i + 1 < gridHeight && newGrid[i + 1][j] == 0 ) {
              if (left && right) {
                int choice = (int)random(3);
                if (choice == 0) {
                  newGrid[i][j] = 0;
                  newGrid[i + 1][j] = 4;
                  //if (i + 2 < gridHeight && newGrid[i + 1][j] == 3) {
                  //  newGrid[i + 1][j] = 6;
                  //}
                }
                else if (choice == 1) {
                  newGrid[i][j] = 0;
                  newGrid[i + 1][j + 1] = 4;
                  //if (i + 2 < gridHeight && newGrid[i + 1][j + 1] == 3) {
                  //  newGrid[i + 1][j + 1] = 6;
                  //}
                } else {
                  newGrid[i][j] = 0;
                  newGrid[i + 1][j - 1] = 4;
                  //if (i + 2 < gridHeight && newGrid[i + 1][j - 1] == 3) {
                  //  newGrid[i + 1][j - 1] = 6;
                  //}
                }
                //if (i + 1 < gridHeight && newGrid[i + 1][j] == 3) {
                //  newGrid[i][j] = 6;
                //}
              } else if (left) {
                int choice = (int)random(3);
                if (choice == 0) {
                  newGrid[i][j] = 0;
                  newGrid[i + 1][j] = 4;
                  //if (i + 2 < gridHeight && newGrid[i + 1][j] == 3) {
                  //  newGrid[i + 1][j] = 6;
                  //}
                }
                else if (choice == 1) {
                  newGrid[i][j] = 0;
                  newGrid[i + 1][j - 1] = 4;
                  //if (i + 2 < gridHeight && newGrid[i + 1][j - 1] == 3) {
                  //  newGrid[i + 1][j - 1] = 6;
                  //}
                }
              } else if (right) {
                int choice = (int)random(3);
                if (choice == 0) {
                  newGrid[i][j] = 0;
                  newGrid[i + 1][j] = 4;
                  //if (i + 2 < gridHeight && newGrid[i + 1][j] == 3) {
                  //  newGrid[i + 1][j] = 6;
                  //}
                }
                else if (choice == 1) {
                  newGrid[i][j] = 0;
                  newGrid[i + 1][j + 1] = 4;
                  //if (i + 2 < gridHeight && newGrid[i + 1][j + 1] == 3) {
                  //  newGrid[i + 1][j + 1] = 6;
                  //}
                }
              } else {
                newGrid[i][j] = 0;
                newGrid[i + 1][j] = 4;
                //if (i + 2 < gridHeight && newGrid[i + 1][j] == 3) {
                //    newGrid[i + 1][j] = 6;
                //}
              }
            }
          }
        } else if (newGrid[i][j] == 7) {
          if (i + 1 < gridHeight && (newGrid[i + 1][j] == 0 || newGrid[i + 1][j] == 4) && newGrid[i + 1][j] != 7 ) {
            newGrid[i][j] = 0;
            newGrid[i + 1][j] = 7;
            waterGrid[i + 1][j] = waterGrid[i][j];
            waterGrid[i][j] = 0.;
          } else {
            if (i + 1 < gridHeight && j - 1 >= 0 && newGrid[i + 1][j - 1] == 0  && newGrid[i + 1][j - 1] != 7 ) {
              if (i + 1 < gridHeight && j + 1 < gridWidth && newGrid[i + 1][j + 1] == 0 && newGrid[i + 1][j + 1] != 7 ) {
                //int choice = (int)random(2);
                //if (choice == 1) {
                //  newGrid[i][j] = 0;
                //  newGrid[i + 1][j - 1] = 7;
                //} else {
                //  newGrid[i][j] = 0;
                //  newGrid[i + 1][j + 1] = 7;
                //}
                newGrid[i][j] = 0;
                newGrid[i + 1][j - 1] = 7;
                newGrid[i + 1][j + 1] = 7;
                waterGrid[i+1][j-1] = waterGrid[i][j]/2;
                waterGrid[i+1][j+1] = waterGrid[i][j]/2;
                waterGrid[i][j] = 0.;
              } else {
                newGrid[i][j] = 0;
                newGrid[i + 1][j - 1] = 7;
                waterGrid[i+1][j-1] = waterGrid[i][j];
                waterGrid[i][j] = 0.;
              }
            } else if (i + 1 < gridHeight && j + 1 < gridWidth && newGrid[i + 1][j + 1] == 0 && newGrid[i + 1][j + 1] != 7) {
              newGrid[i][j] = 0;
              newGrid[i + 1][j + 1] = 7;
              waterGrid[i+1][j + 1] = waterGrid[i][j];
              waterGrid[i][j] = 0.;
            } else {
              //println();
              //for (int k = 0; k < grid.length; k++) {
              //  for (int l = 0; l < grid.length; l++) {
              //      print(waterGrid[i][j] + " "); 
              //      //if (waterGrid[i][j] == )
              //  }
              //  println();
              //}
              while (waterGrid[i][j] > 0) {
                if (i + 1 < gridHeight)
                  println("EEE? " + newGrid[i + 1][j] + " " + waterGrid[i + 1][j]);
                if (i + 1 < gridHeight && newGrid[i + 1][j] == 7 && waterGrid[i + 1][j] < 1) {
                  println("HUH");
                  if (1. - waterGrid[i + 1][j] <= waterGrid[i][j]) {
                    waterGrid[i][j] -= 1. - waterGrid[i + 1][j];
                    waterGrid[i + 1][j] += 1. - waterGrid[i + 1][j];
                    if (waterGrid[i][j] == 0) newGrid[i][j] = 0;
                  } else {
                    waterGrid[i + 1][j] += waterGrid[i][j];
                    waterGrid[i][j] = 0;
                    newGrid[i][j] = 0;
                  }
                }
                else if (i + 1 < gridHeight && j - 1 >= 0 && newGrid[i + 1][j - 1] == 7 && waterGrid[i + 1][j - 1] < 1) {
                    if (i + 1 < gridHeight && j + 1 < gridWidth && newGrid[i + 1][j + 1] == 7 && waterGrid[i + 1][j + 1] < 1) {
                        float fillAmount = min(1. - waterGrid[i + 1][j - 1], 1. - waterGrid[i + 1][j + 1]);
                        if (2 * fillAmount <= waterGrid[i][j]) {
                          waterGrid[i + 1][j + 1] += fillAmount;
                          waterGrid[i + 1][j - 1] += fillAmount;
                          waterGrid[i][j] -= 2 * fillAmount;
                          if (waterGrid[i][j] == 0) newGrid[i][j] = 0;
                        } else {
                          waterGrid[i + 1][j + 1] += waterGrid[i][j] / 2;
                          waterGrid[i + 1][j - 1] += waterGrid[i][j] / 2;
                          waterGrid[i][j] = 0;
                          newGrid[i][j] = 0;
                        }
                    } else {
                      if (1. - waterGrid[i + 1][j - 1] <= waterGrid[i][j]) {
                        waterGrid[i][j] -= 1. - waterGrid[i + 1][j - 1];
                        waterGrid[i + 1][j-1] += 1. - waterGrid[i + 1][j - 1];
                        //if (waterGrid[i][j] == 0) newGrid[i][j] = 0;
                      } else {
                        waterGrid[i + 1][j-1] += waterGrid[i][j];
                        waterGrid[i][j] = 0;
                        newGrid[i][j] = 0;
                      }
                    }
                } else if (i + 1 < gridHeight && j + 1 < gridWidth && newGrid[i + 1][j + 1] == 7 && waterGrid[i + 1][j + 1] < 1 ) {
                    print("ETO NAS");
                    if (1. - waterGrid[i + 1][j + 1] <= waterGrid[i][j]) {
                        waterGrid[i][j] -= 1. - waterGrid[i + 1][j + 1];
                        waterGrid[i + 1][j + 1] += 1. - waterGrid[i + 1][j + 1];
                        if (waterGrid[i][j] == 0) newGrid[i][j] = 0;
                    } else {
                        waterGrid[i + 1][j+1] += waterGrid[i][j];
                        waterGrid[i][j] = 0;
                        newGrid[i][j] = 0;
                    }
                }
                else if (j - 1 >= 0 && (newGrid[i][j - 1] == 7 || newGrid[i][j - 1] == 0) && waterGrid[i][j - 1] < waterGrid[i][j]) {
                  //println("ETO " + waterGrid[i][j - 1] + " " + i + " " + j);
                  //  println(j + 1 < gridWidth, (newGrid[i][j + 1] == 7 || newGrid[i][j + 1] == 0), waterGrid[i][j + 1] < waterGrid[i][j], newGrid[i][j + 1]);
                    if (j + 1 < gridWidth && (newGrid[i][j + 1] == 7 || newGrid[i][j + 1] == 0) && waterGrid[i][j + 1] < waterGrid[i][j]) {
                        float water = (waterGrid[i][j] + waterGrid[i][j - 1] + waterGrid[i][j + 1])/3;
                        waterGrid[i][j] = water;
                        waterGrid[i][j + 1] = water;
                        waterGrid[i][j - 1] = water;
                        newGrid[i][j + 1] = 7;
                        newGrid[i][j - 1] = 7;
                        break;
                    } else {
                        float water = (waterGrid[i][j] + waterGrid[i][j - 1])/2;
                        waterGrid[i][j] = water;
                        waterGrid[i][j - 1] = water;
                        newGrid[i][j - 1] = 7;
                        break;
                    }
                } 
                else if (j + 1 < gridWidth && (newGrid[i][j + 1] == 7 || newGrid[i][j + 1] == 0) && waterGrid[i][j + 1] < waterGrid[i][j]) {
                    float water = (waterGrid[i][j] + waterGrid[i][j + 1])/2;
                    waterGrid[i][j] = water;
                    waterGrid[i][j + 1] = water;
                    newGrid[i][j + 1] = 7;
                    break;
                }
                else {
                  //println(j - 1 >= 0, (newGrid[i][j - 1] == 7 || newGrid[i][j - 1] == 0), waterGrid[i][j - 1] < waterGrid[i][j], waterGrid[i][j - 1] + " < " + waterGrid[i][j], grid[9][0]);
                  if (waterGrid[i][j] < 0.0009) newGrid[i][j] = 0;
                  break;
                }
              }
            }
          }
        }
      }
    }
    //for (int i = 0; i < gridHeight; i++) {
    //  for (int j = 0; j < gridWidth; j++) {
    //   print(grid[i][j] + " ");
    //  }
    //  println();
    //}
    //println();
    //for (int i = 0; i < gridHeight; i++) {
    //  for (int j = 0; j < gridWidth; j++) {
    //   print(newGrid[i][j] + " ");
    //  }
    //  println();
    //}
    for (int i = 0; i < gridHeight; i++) {
      for (int j = 0; j < gridWidth; j++) {
        if (grid[i][j] == 5 || grid[i][j] == 6) {
          if (smokeTimes[i][j] == 0) {
            newGrid[i][j] = 0;
            continue;
          } 
          int type = grid[i][j];
          //for (int ai = 0; ai < gridHeight; ai++) {
          //  for (int aj = 0; aj < gridWidth; aj++) {
          //   print(grid[ai][aj] + " ");
          //  }
          //  println();
          //}
          //println();
          //for (int ai = 0; ai < gridHeight; ai++) {
          //  for (int aj = 0; aj < gridWidth; aj++) {
          //   print(newGrid[ai][aj] + " ");
          //  }
          //  println();
          //}
          try {
            println(i + " " + j);
            //println("SADASDASD " + grid[i][j-1] + " " + grid[i][j+1]);
          } catch (ArrayIndexOutOfBoundsException e) {
          
          }
          //for (int k = i - 1; k <= i; k++) {
          //    for (int l = j - 1; l <= j + 1; l++) {
                
          //    }
          //}
          boolean leftUp = false;
          boolean left = false;
          boolean rightUp = false;
          boolean right = false;
          try {
            if (newGrid[i-1][j - 1] == 0) {
              leftUp = true;
            }
          } catch (ArrayIndexOutOfBoundsException e) {
            // Handle the case where k or l is outside the bounds of newGrid
            //println("Attempted to access an element outside the array's bounds.");
          }
          try {
            if (newGrid[i-1][j + 1] == 0) {
              rightUp = true;
            }
          } catch (ArrayIndexOutOfBoundsException e) {
            // Handle the case where k or l is outside the bounds of newGrid
            //println("Attempted to access an element outside the array's bounds.");
          }
          try {
            if (newGrid[i][j - 1] == 0) {
              left = true;
              println("LEVA");
            }
          } catch (ArrayIndexOutOfBoundsException e) {
            // Handle the case where k or l is outside the bounds of newGrid
            //println("Attempted to access an element outside the array's bounds.");
          }
          try {
            if (newGrid[i][j + 1] == 0) {
              right = true;
              println("DESNA");
            }
          } catch (ArrayIndexOutOfBoundsException e) {
            // Handle the case where k or l is outside the bounds of newGrid
            //println("Attempted to access an element outside the array's bounds.");
          }
          try {
            if (i - 1 > 0 && newGrid[i-1][j] == 0) {
              println("A");
              if (leftUp && rightUp) {
                int choice = (int)random(3);
                if (choice == 0) {
                  newGrid[i-1][j] = type;
                  newGrid[i][j] = 0;
                  smokeTimes[i-1][j] = smokeTimes[i][j];
                  smokeTimes[i][j] = 0;
                } else if (choice == 1) {
                    newGrid[i-1][j-1] = type;
                    newGrid[i][j] = 0;
                    smokeTimes[i-1][j-1] = smokeTimes[i][j];
                    smokeTimes[i][j] = 0;
                } else {
                  newGrid[i-1][j+1] = type;
                  newGrid[i][j] = 0;
                  smokeTimes[i-1][j+1] = smokeTimes[i][j];
                  smokeTimes[i][j] = 0;
                }
              }
              else if (leftUp) {
                int choice = (int)random(2);
                if (choice == 0) {
                  newGrid[i-1][j] = type;
                  newGrid[i][j] = 0;
                  smokeTimes[i-1][j] = smokeTimes[i][j];
                  smokeTimes[i][j] = 0;
                } else if (choice == 1) {
                  newGrid[i-1][j-1] = type;
                  newGrid[i][j] = 0;
                  smokeTimes[i-1][j-1] = smokeTimes[i][j];
                  smokeTimes[i][j] = 0;
                }
              }
              else if (rightUp) {
                int choice = (int)random(2);
                if (choice == 0) {
                  newGrid[i-1][j] = type;
                  newGrid[i][j] = 0;
                  smokeTimes[i-1][j] = smokeTimes[i][j];
                  smokeTimes[i][j] = 0;
                } else if (choice == 1) {
                  newGrid[i-1][j+1] = type;
                  newGrid[i][j] = 0;
                  smokeTimes[i-1][j+1] = smokeTimes[i][j];
                  smokeTimes[i][j] = 0;
                }
              }
              else {
                newGrid[i-1][j] = type;
                newGrid[i][j] = 0;
                smokeTimes[i-1][j] = smokeTimes[i][j];
                smokeTimes[i][j] = 0;
              }
              
            } else if (leftUp && rightUp) {
              int choice = (int)random(2);
              if (choice == 0) {
                newGrid[i-1][j-1] = type;
                newGrid[i][j] = 0;
                smokeTimes[i-1][j-1] = smokeTimes[i][j];
                smokeTimes[i][j] = 0;
              } else if (choice == 1) {
                newGrid[i-1][j+1] = type;
                newGrid[i][j] = 0;
                smokeTimes[i-1][j+1] = smokeTimes[i][j];
                smokeTimes[i][j] = 0;
              }
            } else if (leftUp) {
              newGrid[i-1][j-1] = type;
              newGrid[i][j] = 0;
              smokeTimes[i-1][j-1] = smokeTimes[i][j];
              smokeTimes[i][j] = 0;
            } else if (rightUp) {
              newGrid[i-1][j+1] = type;
              newGrid[i][j] = 0;
              smokeTimes[i-1][j+1] = smokeTimes[i][j];
              smokeTimes[i][j] = 0;
            } else if (left && right) {
              println("B");
              //println("LEFT RIGHT " + i + " " + j + " " + newGrid[i][j-1]  + " " + newGrid[i][j+1] );
              int choice = (int)random(2);
              if (choice == 0) {
                newGrid[i][j-1] = type;
                newGrid[i][j] = 0;
                smokeTimes[i][j-1] = smokeTimes[i][j];
                smokeTimes[i][j] = 0;
                //println("SADASDASD " + grid[i][j-2] + " " + grid[i][j]);
              } else {
                newGrid[i][j+1] = type;
                newGrid[i][j] = 0;
                smokeTimes[i][j+1] = smokeTimes[i][j];
                smokeTimes[i][j] = 0;
                //println("SADASDASD " + grid[i][j] + " " + grid[i][j+2]);
              }
            } else if (left) {
              println("C");
              //println("LEFT " + i + " " + j + " " + newGrid[i][j-1]);
              newGrid[i][j-1] = type;
              newGrid[i][j] = 0;
              smokeTimes[i][j-1] = smokeTimes[i][j];
              smokeTimes[i][j] = 0;
              //println("SADASDASD " + grid[i][j-2] + " " + grid[i][j]);
            } else if (right) {
              println("D");
              //println("RIGHT " + i + " " + j  + " " + newGrid[i][j+1]);
              newGrid[i][j+1] = type;
              newGrid[i][j] = 0;
              smokeTimes[i][j+1] = smokeTimes[i][j];
              smokeTimes[i][j] = 0;
              //println("SADASDASD " + grid[i][j] + " " + grid[i][j+2]);
            }
          } catch (ArrayIndexOutOfBoundsException e) {
            // Handle the case where k or l is outside the bounds of newGrid
            println("Attempted to access an element outside the array's bounds.");
          }
        }
      }
    }
    println("THE GRID HAS BEEN DRAWN");
    //arrayCopy(newGrid, grid);
    for (int i = 0; i < grid.length; i++) {
      arrayCopy(newGrid[i], grid[i]); // Copies each inner array individually
    }
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid.length; j++) {
            if(smokeTimes[i][j] != 0) {
              smokeTimes[i][j]--;
            }
      }
    }
    println();
    //for (int k = 0; k < grid.length; k++) {
    //  for (int l = 0; l < grid.length; l++) {
    //      print(waterGrid[k][l] + " "); 
    //      //if (waterGrid[i][j] == )
    //  }
    //  println();
    //}
    delay(500);
    drawGrid();
  }
}

void generateGrid() {
  float fillProbability = random(0.4, 0.5);
  for (int i = 0; i < gridHeight; i++) {
    int[] row1 = new int[gridWidth];
    int[] row2 = new int[gridWidth];
    int[] row3 = new int[gridWidth];
    float[] row4 = new float[gridWidth];
    for (int j = 0; j < gridWidth; j++) {
        float r = random(1); // Generates a number between 0.0 and 1.0
        if (r < fillProbability) { // 40% chance
            row1[j] = 1;
            row2[j] = 1;
        } else { // 60% chance
            row1[j] = 0;
            row2[j] = 0;
        }
        row3[j] = 0;
        row4[j] = 0.;
    }
    grid[i] = row1;
    newGrid[i] = row2;
    smokeTimes[i] = row3;
    waterGrid[i] = row4;
  }
}

void updateGrid() {
  //arrayCopy(grid, newGrid);
  //for (int i = 0; i < grid.length; i++) {
  //  arrayCopy(grid[i], newGrid[i]); // Copies each inner array individually
  //}
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      newGrid[i][j] = grid[i][j];
    }
  }
  for (int i = 0; i < gridHeight; i++) {
    for (int j = 0; j < gridWidth; j++) {
        if (grid[i][j] == 0) {
          //println("GLEDAMO: " + i + " " + j);
          int neighbours = 0;
          for (int k = i - 1; k <= i + 1; k++) {
            if (k < 0 || k >= gridHeight) continue;
            if (k == i) {
              for (int l = j - 1; l <= j + 1; l += 2) {
                //println(i + "a" + j);
                if (l < 0 || l >= gridWidth) continue;
                if (grid[k][l] == 1) neighbours++;
              }
            } else {
              for (int l = j - 1; l <= j + 1; l ++) {
                //println(i + "a" + j);
                if (l < 0 || l >= gridWidth) continue;
                if (grid[k][l] == 1) neighbours++;
              }
            }
          }
          //println(neighbours);
          if (neighbours >= 6 && neighbours <= 8) {
            newGrid[i][j] = 1;
          } else newGrid[i][j] = 0;
        } else {
          //println("GLEDAMO: " + i + " " + j);
          int neighbours = 0;
          for (int k = i - 1; k <= i + 1; k++) {
            if (k < 0 || k >= gridHeight) continue;
            if (k == i) {
              for (int l = j - 1; l <= j + 1; l += 2) {
                //println(i + "a" + j);
                if (l < 0 || l >= gridWidth) continue;
                if (grid[k][l] == 1) neighbours++;
              }
            } else {
              for (int l = j - 1; l <= j + 1; l ++) {
                //println(i + "a" + j);
                if (l < 0 || l >= gridWidth) continue;
                if (grid[k][l] == 1) neighbours++;
              }
            }
          }
          //println(neighbours);
          if (neighbours >= 2 && neighbours <= 8) {
            newGrid[i][j] = 1;
          } else newGrid[i][j] = 0;
        }
    }
  }
  //arrayCopy(newGrid, grid);
  //for (int i = 0; i < grid.length; i++) {
  //  arrayCopy(newGrid[i], grid[i]); // Copies each inner array individually
  //}
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      grid[i][j] = newGrid[i][j];
    }
  }
}

void drawGrid() {
  background(100); // Clear the canvas

  for (int i = 0; i < gridHeight; i++) {
    for (int j = 0; j < gridWidth; j++) {
      if (grid[i][j] == 0) fill(0);
      else if (grid[i][j] == 2) fill(194, 178, 128);
      else if (grid[i][j] == 3) fill(99,73,43);
      else if (grid[i][j] == 4) fill(255,90,0);
      else if (grid[i][j] == 5) fill(200);
      else if (grid[i][j] == 6) fill(100);
      else if (grid[i][j] == 7) {
        
        //if (waterGrid[i][j] < 0.25 && waterGrid[i][j] > 0.001) fill(240, 255, 255);
        //else if (waterGrid[i][j] < 0.5 && waterGrid[i][j] > 0.001) fill(137, 207, 240);
        //else if (waterGrid[i][j] < 0.75 && waterGrid[i][j] > 0.001) fill(0, 150, 255);
        //else if (waterGrid[i][j] <= 1. && waterGrid[i][j] > 0.001) fill(0, 71, 171);
        
        if (waterGrid[i][j] > 0.0001) {
          fill(0, 0, 150 + (int)((1. - waterGrid[i][j]) * 105));
        } else {
          waterGrid[i][j] = 0;
          grid[i][j] = 0;
          fill(0);
          //continue;
        }
      }
      else if (grid[i][j] == 8) fill (0, 255, 0);
      else fill(255);
      rect(j * squareSize, i * squareSize, squareSize, squareSize);
      //if (grid[i][j] == 7) {
      //  println("sertyuiopjuhytrdtuiuk");
      //  fill(255); // Set text color (e.g., black)
      //  textAlign(CENTER, CENTER); // Align text to be centered
      //  // Calculate the center of the block
      //  float textX = j * squareSize + squareSize / 2;
      //  float textY = i * squareSize + squareSize / 2;
      //  text(waterGrid[i][j], textX, textY); // Draw the number (or any other value you want)
      //}
    }
  }
}

void mousePressed() {
  // Calculate which grid cell was clicked
  int clickedRow = (int)(mouseY / squareSize);
  int clickedCol = (int)(mouseX / squareSize);

  // Check if the click is within the bounds of the grid
  if (clickedRow >= 0 && clickedRow < gridHeight && clickedCol >= 0 && clickedCol < gridWidth) {
    // Set the grid cell to a new value, e.g., adding an element
    // Example: Set the clicked cell to have a value indicating a new element was added
    grid[clickedRow][clickedCol] = 8; // or any other value you'd like to represent the new element

    // Optionally, set waterGrid value if needed, for example:
    //waterGrid[clickedRow][clickedCol] = 1.0; // setting full water value, adjust as necessary
  }
}
