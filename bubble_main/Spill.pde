
class Spill{
  
  float radius;
  
  PVector pos;
  PVector vel, acc;
  
  color col;
  float GRAV = 0.5f;
  
  boolean alive = true;
  int age = 0;
  int life;
  int MAX_LIFE = 100;
  int MIN_LIFE = 10;
  
  Spill(float x, float y, float radius, color col){
    
    pos = new PVector(x, y);
    this.radius = radius;
    this.col = col;
    
    vel = new PVector(random(-10, 10), random(-20, 20));
    acc = new PVector(0,0);
    
    life = (int)random(MIN_LIFE, MAX_LIFE);
  }
  
  void update() {
     
    acc.add(0, GRAV);
    
    vel.add(acc);
    pos.add(vel);
     
    acc.set(0,0);
    
    fade();
  }

   void render(){
     
     fill(col, map(age, 0, MAX_LIFE, 255, 0));
     circle(pos.x, pos.y, radius);
   }
   
   void fade(){
     
     if(age >= life){
       alive = false;
     }
     age++;
   }
}
