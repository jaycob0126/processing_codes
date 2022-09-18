
Sliders window;
Slider gridSlider;
Sliders colorControl;
Slider red;
Slider green;
Slider blue;

int grid;
float angle = 0;

void setup() {
  size(1000, 1000);
  
  window = new Sliders("Controller");
  gridSlider = window.addSlider("grid",20 , 5, width/2, 50);
  
  colorControl = new Sliders("Color Control", 0, 100);
  red = colorControl.addSlider("Red", 1, 0, 255);
  green = colorControl.addSlider("Green", 1, 0, 255);
  blue = colorControl.addSlider("Blue", 1, 0, 255);
  
}

void draw() {
  background(255);
  grid = int(gridSlider.value);
  
  loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + width*y;
      
      int i = x%(grid*2) - grid;
      int j = y%(grid*2) - grid;
      
      if( i*j > 0){
        pixels[index] = color(red.value, green.value, blue.value);
      }
    }
  }
  updatePixels();
  
  red.value += 2.2*sin(radians(angle));
  green.value += 2.2*sin(radians(angle+60));
  blue.value += 2.2*sin(radians(angle+120));
  angle++;
  if(angle>360){
    angle = 0;  
  }
  
  window.render();
  colorControl.render();
}

void keyPressed(){
  if(key == 32){
  }
}
