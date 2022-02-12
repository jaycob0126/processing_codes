class Particle {

  PVector mPos;
  PVector mVel;
  PVector mAcc;

  float mDia;
  int edgeBounces;

  Particle(float _x, float _y, float _dia) {
    mPos = new PVector(_x, _y);
    mVel = new PVector(0, 0);
    mAcc = new PVector(0, 0);

    mDia = _dia;
  }

  void show() {
    fill(255, 255, 0);
    circle(mPos.x, mPos.y, mDia);
  }

  void update() {

    checkEdges();

    mVel.add(mAcc);
    mPos.add(mVel);

    mAcc.set(0, 0);
  }

  void checkEdges() {
    if (mPos.x + mDia > width || mPos.x - mDia < 0) {
      mVel.x *= -1;  
      edgeBounces++;
    }

    if (mPos.y + mDia > height || mPos.y - mDia < 0) {
      mVel.y *= -1;  
      edgeBounces++;
    }
  }

  void checkMover(Mover m) {
    if (mPos.x < m.mInitialMousePos.x + 20 && mPos.x > m.mInitialMousePos.x - 20 &&
      mPos.y < m.mInitialMousePos.y + 20 && mPos.y > m.mInitialMousePos.y - 20) {
      mVel.set(m.mDir);
      mVel.mult(m.mSpeed);
    }
  }
}
