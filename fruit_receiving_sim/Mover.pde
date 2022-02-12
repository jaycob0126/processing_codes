class Mover{
  
  PVector mDir;
  float mSpeed;
  PVector mPos;
  
  PVector mInitialMousePos;
  
  Mover(){
    mInitialMousePos = new PVector(mouseX, mouseY);
    mPos = new PVector();
  }
  
  void show(){
    stroke(20, 20, 20, 80);
    strokeWeight(50);
    line(mInitialMousePos.x, mInitialMousePos.y, mPos.x, mPos.y);
    circle(mPos.x, mPos.y, 3);
    
    strokeWeight(1);
    
    noStroke();
    fill(20, 20, 20, 60);
    circle(mInitialMousePos.x, mInitialMousePos.y, 50);
  }
  
  void genVelocity(){
      mPos.set(mouseX, mouseY);
      line(mInitialMousePos.x, mInitialMousePos.y, mPos.x, mPos.y);
      
      mDir = mPos.copy();
      mDir.sub(mInitialMousePos);
      mSpeed = mDir.mag()*0.01;
      mDir.normalize();
  }
}
