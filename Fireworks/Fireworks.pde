ArrayList<Particle> parts;

Firework f;

float prevTime, currTime, dt;

float g = 9.8;

void setup(){
  size(500, 500);
  currTime = millis()/1000.0;
  
  f = new Firework(width/2, height, 0, 200);
}

void draw(){
  background(255);
  
  dt = currTime - prevTime;
  prevTime = currTime;
  currTime = millis()/1000.0;
  
  f.update(dt);
  f.render(color(255, 0, 0));
}
