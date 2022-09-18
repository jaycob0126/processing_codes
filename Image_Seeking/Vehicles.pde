class Vehicles {
  PVector targ;
  PVector pos;
  PVector vel;
  PVector acc;
  color c;

  float dia;
  float coeff;

  Vehicles(float x, float y, float _dia, color _c) {
    this.targ = new PVector(x, y);
    this.pos = new PVector(random(width), random(height));

    this.vel = new PVector();
    this.acc = new PVector();

    this.dia = _dia;
    this.c = _c;
    coeff = random(.2, 0.5);
  }

  void update() {

    PVector dir = PVector.sub(targ, pos);
    float velMag = dir.mag();
    dir.normalize();

    vel = dir.copy();
    vel.mult(velMag*coeff);

    //vel.add(acc);
    pos.add(vel);
  }

  void render() {
    noStroke();
    fill(this.c);
    circle(this.pos.x, this.pos.y, this.dia);
  }

  void relocate() {
    coeff = random(.01, 0.05);
    this.pos.set(random(width), random(height));
  }
  
  void renew(float targX, float targY, color _c){
      this.c = _c;
      targ.set(targX, targY);
  }
}
