  
int d = day();    // Values from 1 - 31
int m = month();  // Values from 1 - 12
int y = year()-2000;   // 2003, 2004, 2005, etc.
int mi = minute();
int h = hour();
String folder_loc = "C:/Users/aeite/Documents/GitHub/neural_signal_2020/extracting_info/";
PrintWriter output;


void setup() {
  // Create a new file in the sketch directory
 
  output = createWriter(folder_loc+"BCI"+m+"_"+d+"_"+y+"_"+h+"_"+mi+"R"+"005"+".txt"); //BCI(month)_(day)_(year)_(hour)_(min)(R/SW)_(matlab pause in sec).txt
  
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
