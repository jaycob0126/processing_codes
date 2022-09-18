class Ball{
  
  float x, y, dia;
  
  float speedX, speedY;
  color col;
 
  Ball(){
    
    dia = random(20, 100);
    x = random(dia, width-dia);
    y = random(dia, height-dia);
    speedX = random(-2, 2);
    speedY = random(-2, 2);
    
    col = color(random(0, 255), random(0, 255), random(0,255));
  }
  
  void update(){
    
    wallCollision();
    
    x += speedX;
    y += speedY;
    
  }
  
  void render(){
    noStroke();
    fill(col);
    circle(x, y, dia);
  }
  
  void wallCollision(){
    
    if(x - dia/2 <= 0 || x+dia/2 >=width){
      
      speedX *= -1;  
    }
    
    if(y-dia/2<=0 || y +dia/2 >= height){
      speedY *= -1;  
    }
    
  }
  
  void collide(Ball b){
    
    if((b.dia+dia)/2 <= dist(b.x, b.y, x, y)){
        col = color(random(0, 255), random(0, 255), random(0,255));
    } 
  }
}
