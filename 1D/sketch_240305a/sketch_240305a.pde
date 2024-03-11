import controlP5.*;

ControlP5 cp5;
String textValue = "20"; // Default square size as a string
float squareSize = 10; // Default square size
int gridWidth = 80; // Grid dimensions
int gridHeight = 80;
int currentRow = 0;
int lastRowUpdateTime = 0; // Time when the last row was updated
int rowUpdateInterval = 250;
boolean startedRender = false;
int[][] possibleStates = {
  {1, 1, 1},
  {1, 1, 0},
  {1, 0, 1},
  {1, 0, 0},
  {0, 1, 1},
  {0, 1, 0},
  {0, 0, 1},
  {0, 0, 0}
};
int[] curRow = new int[gridWidth];

int[] nextRow = new int[gridWidth];

String rule;

void setup() {
  size(800, 800);
  background(100, 100, 100);
  
  for (int i = 0; i < gridWidth; i ++) {
    curRow[i] = 0;
    nextRow[i] = 0;
  }
  
  cp5 = new ControlP5(this);

  cp5.addTextfield("input")
     .setPosition(20, 750)
     .setSize(100, 30)
     .setFont(createFont("arial", 18))
     .setAutoClear(false)
     .setColor(color(255, 255, 255))
     .setColorBackground(color(60, 60, 60))
     .setColorActive(color(80, 80, 80))
     .getCaptionLabel().setVisible(false);
     
  cp5.addTextlabel("label")
     .setText("Rule:")
     .setPosition(20, 720)
     .setColorValue(255)
     .setFont(createFont("arial", 16));

  // Initial draw of the grid
  //drawGrid();
}

void draw() {
  if (startedRender) {
      if (currentRow < gridHeight && millis() - lastRowUpdateTime > rowUpdateInterval) {
      drawRow(currentRow);
      currentRow++; // Move to the next row for the next frame
      lastRowUpdateTime = millis(); // Update the time we last added a row
    }
    //println(rule);
  }
}

void reset() {
  background(100, 100, 100);
  currentRow = 0;
  lastRowUpdateTime = 0;
  startedRender = false;
  for (int i = 0; i < curRow.length; i++) {
    curRow[i] = 0;
    nextRow[i] = 0;
  }
}

// This method is called every time text is entered in the text field
public void input(String text) {
  // Update the textValue variable with the entered text
  reset();
  textValue = text;
  try {
    //squareSize = Float.parseFloat(textValue); // Convert string to float
    rule = formatBinaryString(binary((int)Float.parseFloat(textValue)), 8);
    
    startedRender = true;
    //drawGrid(); // Redraw the grid with the new square size
  } catch (NumberFormatException e) {
    println("Not a valid number");
  }
}

void drawRow(int rowIndex) {
  arrayCopy(nextRow, curRow);
  for (int i = 0; i < gridWidth; i++) {
    print(curRow[i]);
  }
  println();
  for (int col = 0; col < gridWidth; col++) {
    int colorValue;
    if (rowIndex == 0 && col == gridWidth / 2) {
      colorValue = 1;
      curRow[col] = 1;
    } else if (rowIndex == 0) {
      //colorValue = (int)random(2);
      //println("Color: " + colorValue);
      //curRow[col] = colorValue;
      colorValue = 0;
      curRow[col] = 0;
    } else {
      colorValue = curRow[col];
      curRow[col] = curRow[col];
    }
    
    if (colorValue == 0) fill(0);
    else fill(255);
    rect(col * squareSize, rowIndex * squareSize, squareSize, squareSize);
  }
  for (int col = 0; col < gridWidth; col++) {
    int[] neighbourhood;

    if (col == 0) {
      neighbourhood = new int[]{0, curRow[col], curRow[col+1]};
    }
    else if (col == gridWidth - 1) {
      neighbourhood = new int[]{curRow[col-1], curRow[col], 0};
    }
    else {
      neighbourhood = new int[]{curRow[col-1], curRow[col], curRow[col+1]};
    }
    
    int index = findArrayIndex(possibleStates, neighbourhood);
    println("Index of target array: " + index + " " + rule.charAt(index) + " " + (rule.charAt(index) - '0') + " " + neighbourhood[0] + neighbourhood[1] + neighbourhood[2]);
    nextRow[col] = rule.charAt(index) - '0';
  }
  // Note: No need for delay() here, as the drawing will pause based on the frame update in draw()
}

void drawGrid() {
  background(100); // Clear the canvas

  for (int i = 0; i < gridHeight; i++) {
    for (int j = 0; j < gridWidth; j++) {
      int colorValue = (int)random(2);
      if (colorValue == 0) fill(0);
      else fill(255);
      rect(j * squareSize, i * squareSize, squareSize, squareSize);
    }
    delay(200);
  }
}

String formatBinaryString(String binaryString, int desiredLength) {
  // If the binary string is shorter than the desired length, pad it with leading zeros
  if (binaryString.length() < desiredLength) {
    return String.format("%" + desiredLength + "s", binaryString).replace(' ', '0');
  }
  // If the binary string is longer than the desired length, trim it to the last 'desiredLength' characters
  else if (binaryString.length() > desiredLength) {
    return binaryString.substring(binaryString.length() - desiredLength);
  }
  // If the binary string is exactly the desired length, return it as is
  return binaryString;
}

// Function to check if two int[] arrays are equal
boolean arraysEqual(int[] a, int[] b) {
  if (a.length != b.length) {
    return false; // Arrays of different lengths cannot be equal
  }
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return false; // If any corresponding elements differ, arrays are not equal
    }
  }
  return true; // Arrays are equal
}

// Function to find the index of an int[] array in an int[][] array
int findArrayIndex(int[][] array2D, int[] target) {
  for (int i = 0; i < array2D.length; i++) {
    if (arraysEqual(array2D[i], target)) {
      return i; // Found target, return its index
    }
  }
  return -1; // Target not found
}
