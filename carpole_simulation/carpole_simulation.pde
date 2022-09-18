float x1, x2, y2;
float xdot, thetadot;

float v1, a1, v2, a2;


float m1 = 50;  //kg
float m2 = 1;  //kg

float theta = radians(70);
float g = 1;//gravitational acceleration m/s^2
float l = 200; //mm
float force = 0; //Newtons

float rectW = 60; //m
float rectH = 30; //m
float bobDia = 10;


float kp = 30;
float kd = 320;
float thetaDes = radians(0);
float v1Prev;

void setup() {
  size(1200, 500);

  x1 = 0;

  x2 = x1+l*sin(theta);
  y2 = l*cos(theta);

  v1 = 0;
  v2 = 0;

  //WIDTH_SCALE = displayWidth / 3.1;
  //HEIGHT_SCALE = displayHeight /1.75;
}

void draw() {
  background(255);

  noStroke();
  translate(width/2, height/2);


  stabilize();
  update();
  render();
}

void stabilize() {
  float err = -thetaDes + theta;
  force = err*kp + kd*v2;
  
  text(force, 0, -height/2+20);
  text(v1, 0, -height/2+30);
}

void update() {

  float num1 = g*m2*sin(theta)*cos(theta) + force + l*m2*pow(v2, 2)*sin(theta);
  float den1 = m1-m2*pow(cos(theta), 2)+m2;
  a1 = num1/den1;

  float num2 = -g*(m1+m2)*sin(theta) - (force + l*m2*pow(v2, 2)*sin(theta))*cos(theta);
  float den2 = (m1-m2*pow(cos(theta), 2)+m2)*l;
  a2 = num2/den2;
  
  v1Prev = v1;
  v1 += a1;
  v2 += a2;
  x1 += v1;

  theta += v2;
  x2 = x1+l*sin(theta);
  y2 = l*cos(theta);
  
}

void render() {
  fill(0);
  rect(x1-rectW/2, -rectH/2, rectW, rectH);
  fill(255, 0, 0);
  circle(x1, 0, 3);

  circle(x2, y2, bobDia);
  stroke(200, 180, 0);
  line(x1, 0, x2, y2);
}
