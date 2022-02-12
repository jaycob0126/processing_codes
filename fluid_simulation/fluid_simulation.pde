
int N = 20;

float[] dens0, dens;
float[] srcDens;
float[] u0, u, v0, v;

float cellWidth;
float cellHeight;

float currentTime;
float prevTime;
float dt;

void setup() {

  size(500, 500);

  dens0 = new float[(N)*(N)];
  dens  = new float[(N)*(N)];
  srcDens  = new float[(N)*(N)];
  u0  = new float[(N)*(N)];
  u  = new float[(N)*(N)];
  v0  = new float[(N)*(N)];
  v  = new float[(N)*(N)];

  cellWidth = width/N;
  cellHeight = height/N;

  currentTime = millis();
  prevTime = currentTime;

  srcDens[index(3, 3)] = 2;
  srcDens[index(6, 3)] = 1;
}

void draw() {

  currentTime = millis();
  dt = (currentTime - prevTime)/1000;
  prevTime = currentTime;

  addSource(dens, srcDens, dt);
  diffuse(dens, dens0, dt, 0.005);
  swapDensity();

  background(255);

  showDens();
  showGrid();
}

void addSource(float[] dens, float[] source, float dt) {

  for (int i = 0; i < (N)*(N); i++) {
    dens[i] += dt*source[i];

    //if (dens[i] > 1) dens[i] = 1;
  }
}

void diffuse(float[] d0, float[] d, float dt, float diff) {

  float a = dt*N*N*diff;
  float b = 1/(1+4*a);

  // using gauss-seidel method to calculate new density
  for (int k=0; k <= 30; k++) {
    for (int i=1; i < N-1; i++) {
      for (int j=1; j < N-1; j++) {

        d[index(i, j)] = (d0[index(i, j)] + a*(d[index(i+1, j)] + d[index(i-1, j)]+
          d[index(i, j+1)]+d[index(i, j-1)]))*b;
      }
    }
    setBound(d);
  }
}

void setBound(float[] prop) {
  for (int i=1; i < N-1; i++) {

    prop[index(0, i)] = 0; //left wall
    prop[index(N-1, i)] = 0; //right wall
    prop[index(i, 0)] = 0; //top wall
    prop[index(i, N-1)] = 0; //bottom wall
  }
}

void swapDensity() {
  float[] temp = dens;
  dens = dens0;
  dens0 = temp;
  
}

void showGrid() {

  for (int i=0; i < N; i++) {
    float x = i*cellWidth;
    float y = i*cellHeight;


    stroke(50);
    line(x, 0, x, height);
    line(0, y, width, y);
  }
}

void showDens() {

  for (int i=0; i < N; i++) {
    for (int j=0; j < N; j++) {
      float x0 = i * cellWidth;
      float y0 = j * cellHeight;
      float x = x0 + cellWidth;
      float y = y0 + cellHeight;

      int col = (int)map(dens[index(i, j)], 0, 1, 255, 0);

      noStroke();
      fill(col);
      rect(x0, y0, x, y);
    }
  }
}

int index(int i, int j) {
  int ind = i + (N)*j;
  return ind;
}

void mousePressed() {
}
