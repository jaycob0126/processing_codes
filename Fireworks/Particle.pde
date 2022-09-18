class Particle {

  PVector pos, vel, acc;

  float dia;
  float alpha = 0;

  Particle(float _x, float _y, float velX, float velY, float _dia) {
    this.pos = new PVector(_x, _y);
    this.vel = new PVector(velX, velY);
    this.acc = new PVector(0, 0);

    this.dia = _dia;
  }

  void update(float dt) {

    //solve for acceleration
    acc.set(0, 9.8);

    //update velocity and position
    PVector velPrev = vel.copy();
    PVector accPrev = acc.copy();

    vel.add(accPrev.mult(dt));
    pos.add(velPrev.mult(dt)).add(acc.mult(pow(dt, 2)/2));
  }

  void render(color col) {

    fill(col, alpha);
    noStroke();
    circle(pos.x, pos.y, dia);

    alpha += 0.5;
  }

  boolean isAlive() {
    if (alpha > 255) {
      return false;
    }
    return true;
  }
}
