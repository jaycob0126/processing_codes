
float x, y;

float radius;
float axialVel;
float angle, aVel;

void setup(){
  
  size(500, 500);
  
  x = 0;
  y = 0;
    
  angle = 0;
  aVel = .01;
  axialVel = .02;
}

void draw(){
  
  //background(255);
  
  angle += aVel;
  radius += axialVel;
 
  x = radius*cos(angle);
  y = radius*sin(angle);
  
  circle(width/2 + x, height/2 + y, 2);
  
}
