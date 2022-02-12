float x, y;
float velX, velY;
float acc = 9810;

float prevTime;
float currentTime;
float dt;
float totalTime = 0;

float frames;

void setup() {
  size(800, 800);  

  velY = 0.f;
  y = 0;

  prevTime = millis();
  frameRate(120);
}

void draw() {

  currentTime = millis();
  dt = (currentTime - prevTime)/1000;
  totalTime += dt;
  update(dt);

  background(.2, .2, .2);

  pushMatrix();
  translate(width/2, height/2);

  translate(x, y);
  circle(0, 0, 20);

  popMatrix();

  prevTime = currentTime;
}

void update(float dt) {

  //0.15875 mm/pix
  //9810 mm/s^2
  //9810/0.15875 pix/s^2
  y += velY*dt + 0.5f*acc/0.15875f*pow(dt,2);
  velY += acc/0.15875f*dt;

  print("D = " + y);
  print(", vel = " + velY);
  print(", dt = " + dt);
  println();
  
  if (y >= height/2) {
    //println(totalTime);
    //velY += 10;
    velY = -velY;
    //noLoop();
  }
}
