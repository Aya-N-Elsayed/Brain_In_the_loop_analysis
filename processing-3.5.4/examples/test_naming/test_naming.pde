  
int d = day();    // Values from 1 - 31
int m = month();  // Values from 1 - 12
int y = year();   // 2003, 2004, 2005, etc.
int m = minute();
int h = hour();

PrintWriter output;

void setup() {
  // Create a new file in the sketch directory
  output = createWriter("positions.txt"); 
}

void draw() {
  point(mouseX, mouseY);
  output.println(mouseX);  // Write the coordinate to the file
}

void keyPressed() {
  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
  exit();  // Stops the program
}
