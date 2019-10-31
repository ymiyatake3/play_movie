import processing.video.*;
import processing.serial.*;

Movie movie;
Serial port;
boolean playing;

void setup() {
  //fullScreen();  // Open with full screen size
  //fullScreen(2);  // Open in the 2nd display with full screen size
  size(500, 200);
  
  port = new Serial(this, "/dev/cu.usbmodem14111", 9600);  // **PLEASE change to your port address** 
 
  movie = new Movie(this, "TITLE.mov"); // **PLEASE change TITLE into your file name**
}

void draw() {
  background(0);
  
  // THIS PART IS A LITTLE DOUBTFUL m(__)m
  while (port.available() > 0) {
    int signal = port.read();
    println(signal);
    if (signal >= 1) {
      restart();
    }
  }
  // ---
  
  if (movie.time() < movie.duration()) {
    image(movie, 0, 0, width, 225);  // Show movie in the active window
  }
}

// Called with every frame
void movieEvent(Movie m) {
  m.read();  // Get an image of current position
}

void restart() {
  movie.jump(0);  // Go back to 0s position
  movie.play();   // Play once
}

// For debug
void mousePressed() {
  restart();
}
