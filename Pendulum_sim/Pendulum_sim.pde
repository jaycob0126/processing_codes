Pendulum[] pendulums;

void setup() {
 
  size(500, 500);
  
  pendulums = new Pendulum[2];
  
  for(int i=0; i<pendulums.length; i++) {
    pendulums[i] = new Pendulum(width/2.0, 0.0, 150+i*80.0, 45.0, 20);
  }
  
}

void draw() {
  
  background(255);
  
  
  for(Pendulum pendulum: pendulums) {
    pendulum.update();
    pendulum.render();
  }
  
}
