
class Spill{
  
  float radius;
  
  PVector pos;
  PVector vel, acc;
  
  color col;
  float GRAV = 0.5f;
  
  boolean alive = true;
  int age = 0;
  int life;
  int MAX_LIFE = 15;
  int MIN_LIFE = 2;
  
  Spill(float x, float y, float radius, color col){
    
    pos = new PVector(x, y);
    this.radius = radius;
    this.col = col;
    
    vel = new PVector(random(-8, 8), random(-20, -1));
    acc = new PVector(0,0);
    
    life = (int)random(MIN_LIFE, MAX_LIFE);
  }
  
  Spill(float x, float y, float radius, color col, float strength){
    
    pos = new PVector(x, y);
    this.radius = radius;
    this.col = col;
    
    vel = new PVector(strength*random(-10, 10), strength*random(-40, -1));
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
     
     noStroke();
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
