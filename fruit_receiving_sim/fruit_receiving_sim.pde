ArrayList<Particle> p;
ArrayList<Mover> m;

boolean mouseHold = false;
boolean addParticle = false;
boolean addMover = true;

void setup() {
  size(600, 600);

  p = new ArrayList<Particle>();
  m = new ArrayList<Mover>();
}

void draw() {

  background(255);

  addParticle();
  showParticles();

  showMovers();

  showTexts();
}


void addParticle() {

  if (mouseHold && addParticle) {
    PVector moverPos = m.get(0).mInitialMousePos;
    Particle newParticle = new Particle(moverPos.x + random(-15, 15), 
                                    moverPos.y + random(-15, 15), 20);
    newParticle.mVel.set(random(-5, 5), random(-5, 5));

    p.add(newParticle);
  }
}

void showParticles() {
  for (int i=0; i < p.size(); i++) {

    if (p.get(i).edgeBounces > 2) {
      p.remove(i);
    }
  }

  for (int i=0; i < p.size(); i++) {
    
    for(int j=0; j < m.size(); j++){
      p.get(i).checkMover(m.get(j));
    }
    
    p.get(i).show();
    p.get(i).update();
  }
}

void addMover() {
  Mover newMover = new Mover();

  m.add(newMover);
}

void showMovers() {

  if (mouseHold && addMover) {
    m.get(m.size()-1).genVelocity();
  }

  for (int i=0; i < m.size(); i++) {
    m.get(i).show();
  }
}

void showTexts() {

  stroke(0);
  fill(0);
  text("Particles: " + p.size(), 20, 20);
  text("Add Particle: " + addParticle, 20, 10);

  if (m.size()>0) {
    Mover mov = m.get(m.size()-1);
    text("Mover " + m.size() + "Dir = " + mov.mDir + ", " + mov.mSpeed, 20, 30);
  }
}

void mousePressed() {
  mouseHold = true;

  if (addMover) {
    addMover();
  }
}

void mouseReleased() {
  mouseHold = false;
}

void keyPressed() {

  if (key == ' ') {
    addParticle = !addParticle;
    addMover = !addMover;
  }
}
