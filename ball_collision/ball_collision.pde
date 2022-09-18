Ball [] balls;

void setup() {
  size(800, 800);

  balls = new Ball[50];
  for(int i=0; i<balls.length; i++){
    balls[i] = new Ball();  
  }
}

void draw() {

  background(255);

  //for(Ball b : balls){
  for (int i=0; i < balls.length; i++) {    
    for(int j=0; j < balls.length; j++){
        if(j == i) break;
        
        balls[i].collide(balls[j]);
    }
    
    balls[i].update();
    balls[i].render();
  }
}
