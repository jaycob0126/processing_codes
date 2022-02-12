
class Pendulum{
  
  float GRAV = 1;
  
  float x0, y0, x, y, len;
  float radius;
  
  float angle, aVel, aAcc;
  
  color bobCol;
  color stringCol;
  
  Pendulum(float x, float y, float len, float deg, float bobRadius){
    
    this.x0 = x;
    this.y0 = y;
    this.len = len;
    this.radius = bobRadius;
    this.angle = radians(deg);
    
    stringCol = color(random(255), random(255), random(255));
    bobCol = stringCol;
  }
  
  void update() {
    
    aAcc = -(GRAV/len)*sin(angle);
    aVel += aAcc;
    angle += aVel;
    
    x = x0 + len*sin(angle);
    y = y0 + len*cos(angle);
  }
  
  void render() {
    
    stroke(stringCol);
    line(x0, y0, x, y);
    
    stroke(bobCol);
    fill(bobCol);
    circle(x, y, radius);
    
  }
  
}
