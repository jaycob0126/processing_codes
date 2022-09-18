Sliders root;
Slider xPos;
Slider yPos;
Slider dia;
Slider col;

void setup(){
  size(800, 500);  
  
  root = new Sliders("Controller");
  xPos = root.addSlider("x position", 10, 0, width);
  yPos = root.addSlider("y position", 10, 0, height);
  dia = root.addSlider("diameter", 10, 0, 200, 50);
  col = root.addSlider("lightness", 10, 0, 255);
}

void draw(){
  background(255);
 
  fill(col.value);
  circle(xPos.value, yPos.value, dia.value);
  root.render();
}
