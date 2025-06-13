import processing.serial.*;

String filePath = "D:/ALL/Major Project/Jupyter/project/value.txt";
String previousValue = ""; // Variable to store the previous value read from the file
Serial port; // Serial object for communication with Arduino

void setup() {
  size(200, 200);
  port = new Serial(this, Serial.list()[0], 9600); // Open the serial port
}

void draw() {
  background(255);
  
  // Read the content of the text file
  String[] lines = loadStrings(filePath);
  
  if (lines != null && lines.length > 0) {
    String currentValue = lines[0];
    println("Current value read from file: " + currentValue); // Debugging message
    
    // Check if the value has changed
    if (!currentValue.equals(previousValue)) {
      previousValue = currentValue; // Update the previous value
      println("Previous value updated: " + previousValue); // Debugging message
      
      // Extract the integer value
      int value = Integer.parseInt(currentValue.trim());
      println("Integer value: " + value); // Debugging message
      
      // Send command to Arduino based on the value
      if (value == 200) {
        println("Sending command to Arduino: 1"); // Debugging message
        if (port != null) {
          if (!port.active()) {
            port.clear(); // Clear the serial buffer
          }
          port.write('1'); // Send '1' to turn on the LED
        }
      } else {
        println("Sending command to Arduino: 0"); // Debugging message
        if (port != null) {
          if (!port.active()) {
            port.clear(); // Clear the serial buffer
          }
          port.write('0'); // Send '0' to turn off the LED
        }
      }
    }
  }
}
