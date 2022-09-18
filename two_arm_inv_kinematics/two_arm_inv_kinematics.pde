float theta1, theta2;
float l1 = 300;
float l2 = 300;

float x, y, gamma;

float s;
float pathX0 = 200;
float pathY0 = 180;
float pathX1 = 120;
float pathY1 = -160;

Sliders window;
Slider arm1;
Slider arm2;
Slider speed;
Slider originX, originY;

void setup() {

  size(800, 800);

  window = new Sliders("Variables");
  arm1 = window.addSlider("arm 1", 10, 50, 400, 100);
  arm2 = window.addSlider("arm 2", 10, 50, 400, 200);
  speed = window.addSlider("speed", 0.01, 0, 0.1);
  originX = window.addSlider("Origin X", 10, -width/2, width/2);
  originY = window.addSlider("Origin Y", 10, -height/2, height/2);
}

void draw() {
  background(255);

  pushMatrix();
  translate(width/2, height/2);
  rotate(PI);
  //task space
  //x = pathX0 + 100*cos(-s*2*PI);
  //y = 100*sin(-s*2*PI);

  ////time scaling
  ////s = 0.5-0.5*sin(speed*millis()/100);
  //s+=speed.value*.1;
  //if(s>1){
  //  s=0;  
  //}

  if (s >= 0 && s <= 0.5) {
    x = -100 + 400*s;
    y = (-1/50.0)*pow(x, 2)+200;
  } else if (s > 0.5 && s <=1) {
    x = 300 + 2*s*(-200);
    y=0;
  } else {
    s = 0;
  }
  
  s+=speed.value;
  
  //set arm lengths
  l1 = arm1.value;
  l2 = arm2.value;


  //inverse kinematics
  float hyp = sqrt(pow(x-originX.value, 2)+pow(y-originY.value, 2));
  if ( hyp > l1+l2) {
    hyp = l1+l2;
  } else if ( hyp < l1-l2) {
    hyp = l1-l2;
  }

  gamma = atan2(y-originY.value, x-originX.value);
  float beta = acos((pow(l1, 2)+pow(l2, 2)-pow(hyp, 2))/(2*l1*l2));
  float alpha = acos((pow(hyp, 2)+pow(l1, 2)-pow(l2, 2))/(2*l1*hyp));
  theta1 = gamma + alpha;
  theta2 = -PI + beta;

  fill(0);
  stroke(0);
  //render
  circle(x, y, 10);
  line(originX.value, originY.value, originX.value+l1*cos(theta1), originY.value+l1*sin(theta1));
  line(originX.value+l1*cos(theta1), originY.value+l1*sin(theta1), originX.value+l1*cos(theta1)+l2*cos(theta1+theta2), originY.value+l1*sin(theta1)+l2*sin(theta1+theta2));
  popMatrix();

  window.render();
}
