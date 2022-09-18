class Firework{
  
  float g = 9.8;
  
  float w = 3;
  float h = 10;
  
  PVector pos;
  PVector endPos;
  PVector vel;
  
  ArrayList<Particle> particles;
  
  Firework(float posX, float posY, float endX, float endY){
      pos = new PVector(posX, posY);
      endPos = new PVector(endX, endY);
      vel = new PVector(0, -60);
      
      particles = new ArrayList<Particle>();
  }
  
  void update(float dt){
      
    //update velocity and position
    PVector velPrev = vel.copy();
    pos.add(velPrev.mult(dt));
    
    if(pos.y < endPos.y){
       particles.add(new Particle(pos.x, pos.y,random(-50, 50), random(50, 50), 5));
    }
  }
  
  void render(color col){
    
    noStroke();
    fill(col);
    
    rectMode(CENTER);
    rect(pos.x, pos.y, w, h);
  }
  
}
