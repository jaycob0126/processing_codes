//system variables
PVector p1, p2;
float l1, l2, theta, phi, m1, m2;
float thetadot, phidot, thetaddot, phiddot;
float g = 981;

//time variables
float prevTime;
float currTime;

ArrayList<PVector> points1;
ArrayList<PVector> points2;


void setup() {

  size(500, 500);

  currTime = millis()/1000.0;
  prevTime = currTime;


  //initialize system variables
  l1 = 100;
  l2 = 100;
  m1 = 100;
  m2 = 100;

  theta = radians(30);
  phi = radians(90);

  p1 = new PVector(l1*sin(theta), - l1*cos(theta));
  p2 = new PVector(l1*sin(theta)+l2*sin(phi), -l1*cos(theta)-l2*cos(phi));

  points1 = new ArrayList<PVector>();
  points2 = new ArrayList<PVector>();

  points1.add(p1);
  points2.add(p2);
}

void draw() {

  float dt = currTime - prevTime;
  prevTime = currTime;
  currTime = millis()/1000.0;

  translate(width/2, height/2-50);
  rotate(radians(180));

  update(dt);
  render();
}

void update(float dt) {

  /***** calculate accelerations *****/
  //theta double dot
  float thetaddot_num = -g*(m1+m2)*sin(theta)+l2*m2*pow(phidot, 2)*sin(phi-theta)+m2*(g*sin(phi)+l1*pow(thetadot, 2)*sin(phi-theta))*cos(phi-theta);
  float thetaddot_den = l1*(m1-m2*pow(cos(phi-theta), 2)+m2);
  thetaddot = thetaddot_num/thetaddot_den;


  //phi double dot
  float phiddot_num = -(m1+m2)*(g*sin(phi)+l1*pow(thetadot, 2)*sin(phi-theta))+(g*(m1+m2)*sin(theta)-l2*m2*pow(phidot, 2)*sin(phi-theta))*cos(phi-theta);
  float phiddot_den = l2*(m1-m2*pow(cos(phi-theta), 2)+m2);
  phiddot = phiddot_num/phiddot_den;


  //update velocity and positions
  //float prevThetadot = thetadot;
  thetadot += thetaddot*dt;
  theta += thetadot*dt;

  //float prevPhidot = phidot;
  phidot += phiddot*dt;
  phi += phidot*dt;


  p1.set(l1*sin(theta), - l1*cos(theta));
  p2 = p1.copy().add(l2*sin(phi), -l2*cos(phi));


  //streak

  if (frameCount%500 == 0) {
    points1.clear();
    points2.clear();
  }
  points1.add(p1.copy());
  points2.add(p2.copy());
}

void render() {
  background(255);

  stroke(90);
  line(0, 0, p1.x, p1.y);
  line(p1.x, p1.y, p2.x, p2.y);

  fill(0, 0, 200);
  circle(p2.x, p2.y, 20);
  fill(200, 0, 0);
  circle(p1.x, p1.y, 20);
  
  //for(int i = 1; i < points1.size(); i++){
  //  line(points1.get(i-1).x, points1.get(i-1).y, points1.get(i).x, points1.get(i).y);
  //}
  
  for(int i = 1; i < points1.size(); i++){
    stroke(0, 0, 200);
    line(points2.get(i-1).x, points2.get(i-1).y, points2.get(i).x, points2.get(i).y);
  }
  //for(PVector p : points2){
  //  point(p.x, p.y);
  //}
}
