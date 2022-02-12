
class Bubble {

  float SIZELIMIT = 50;
  PVector position;
  float size;
  int alpha;

  float velocity;
  float inflation;

  color mColor;
  
  boolean hit = false;

  Bubble() {
  }

  Bubble(float x, float y) {
    position = new PVector(x, y);
    size = 0;
    alpha = 255;

    inflation = random(.01f, 0.3f);
    velocity = random(.5f, 3.0f);
    mColor = color(random(255), random(255), random(255));
  }

  void floating() {
    position.add(random(-velocity, velocity), -velocity);

    if (position.y < 0) {
      appear();
    }
  }

  void grow() {
    size += inflation;

    //fade
    alpha = (int)map(size, 0, SIZELIMIT, 255, 0);
  }

  void appear() {
    hit = false;
    size = 0.0f;
    alpha = 255;
    position.set(random(0, width), height);
    mColor = color(random(255), random(255), random(255));
  }

  void render() {

    noStroke();
    fill( mColor, alpha);

    circle(position.x, position.y, size);

    if (size > SIZELIMIT) {
      appear();
    }
  }
  
  void pop(float mousePosX, float mousePosY){
    
    if(mousePosX > position.x - size/2 && mousePosX < position.x + size/2 &&
       mousePosY > position.y - size/2 && mousePosY < position.y + size/2){
         appear();
         hit = true;
         
    }
    
  }
}
