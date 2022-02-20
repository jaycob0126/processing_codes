float ppmX; //pixel per meter
float ppmY; //pixel per meter 

float stiffness = .5; //N/m 
float unstretchedLength = .02; //m
PVector GRAV = new PVector(0, 9.81);
PVector pos;
PVector endPos;
PVector vel;
PVector acc;

float bobMass = 2;

float currentTime;
float prevTime;

void setup() {

  size(500, 500);
  ppmX = displayWidth / .310;
  ppmY = displayHeight / .175;


  pos = new PVector(width/2, 0);
  endPos = pos.copy();
  endPos.add(0, unstretchedLength*ppmY);

  vel = new PVector();
  acc = new PVector();

  currentTime = millis()/1000.0;
  prevTime = currentTime;
}

void draw() {
  background(255);

  currentTime = millis()/1000.0;
  float dt = currentTime - prevTime;
  prevTime = currentTime;

  PVector springForce = springForce(pos, endPos);
  PVector gravityForce = GRAV.copy().mult(bobMass);
  acc.set(calcForces(springForce, gravityForce).div(bobMass));

  PVector vel0 = vel.copy();
  vel.add(acc.copy().mult(dt));
  endPos.add(vel0.mult(dt)).add(acc.mult(.5*pow(dt, 2)));

  line(pos.x, pos.y, endPos.x, endPos.y);
  circle(endPos.x, endPos.y, 50);
}

PVector springForce(PVector pos0, PVector pos1) {

  PVector force = pos0.copy().sub(pos1);
  float stretchedLength = force.mag();
  float delS = stretchedLength-unstretchedLength;
  
  force.normalize().mult(delS*stiffness);

  return force;
}

PVector calcForces(PVector ...forces) {

  PVector totalForce = new PVector();
  for (PVector force : forces) {
    totalForce.add(force);
  }

  return totalForce;
}
