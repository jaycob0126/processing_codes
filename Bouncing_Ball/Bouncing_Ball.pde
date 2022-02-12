import processing.sound.*;

float GRAV = .01;

float x0, y0, x, y, yVel, yAcc;
float radius;
float coefRestitution = .96;
float restitution = coefRestitution;

float mass;

float currentTime;
float prevTime;
float dt;

ArrayList<Effect> splashes;
boolean bounce;

PImage basketball;
SoundFile sound;

void setup() {

  size(500, 800);

  x = width/2;
  y = 0;

  x0 = x;
  y0 = y;

  radius = 50;

  splashes = new ArrayList<Effect>();
  bounce = false;

  currentTime = millis();
  prevTime = currentTime;
  
  basketball = loadImage("images/basketball.png");
  sound = new SoundFile(this, "sounds/bounce_sound.wav");
  sound.cue(.23);
}

void draw() {

  background(255);

  currentTime = millis();
  dt = currentTime-prevTime;
  prevTime = currentTime;

  update(dt);
  checkBounce();
  render();
  
}

void update(float dt) {
  
  yAcc = GRAV;
  y += yVel*dt + 1/2*yAcc*pow(dt, 2);
  yVel += yAcc*dt;
  
}

void render(){
  
  image(basketball, x-radius, y-radius, radius*2, radius*2);
  
  for (Effect splash : splashes) {
    splash.play();
  }
  
}

void checkBounce(){
  
  if (y+ radius> height) {
    yVel = -sqrt(2*yAcc*(height-radius - y0));
    yVel *= restitution;
    restitution *= coefRestitution;
    
    bounce = true;

    if (bounce && yVel < -0.02) {
      
      y = height-radius;
      
      splashes.add(new Effect(width/2, height, 50, restitution));
      bounce = false;
      sound.play();
    }
  }
  
    if (splashes.size() > 5) {
    for (int i=0; i<splashes.size()-5; i++) {
      splashes.remove(i);
    }
  }
}
