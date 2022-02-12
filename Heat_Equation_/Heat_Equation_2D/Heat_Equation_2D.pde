String material = "Copper"; //<>// //<>// //<>// //<>//
float leftEndTemp = 150;      //degC
float rightEndTemp = 30;   //degC
float rodLength = 6.;      //mm
boolean fixRightEnd = true; //true if rightEnd temperature is fixed
float div = 1;

float delT = 0.0001;
float delX = 0.1;
float thDiffusivity = .082;

float[] initialTemp;
float[] finalTemp;
float[] initialCond;
float maxTemp;
float minTemp;
float elapsedTime;
float time;

float averageTemp;
float prevTemp;

float scaleX;
float scaleY;
float[] origin;
boolean start = false;

void setup() {

  size(500, 400);

  scaleX = 400/rodLength;

  maxTemp = 0;
  if (leftEndTemp > rightEndTemp) {
    maxTemp = leftEndTemp;
    minTemp = rightEndTemp;
  } else {
    maxTemp = rightEndTemp;
    minTemp = leftEndTemp;
  }

  scaleY = 280/maxTemp;

  origin = new float[2];
  origin[0] = 50;
  origin[1] = height-50;

  initialConditions();
  boundaryConditions();

  elapsedTime = 0;
  prevTemp = 0;
}

void draw() {
  background(255);

  plot(initialCond, 1);
  plot(initialTemp, 2);

  if (start) {
    elapsedTime = millis() - time;
    for (int i=0; i<(1/delT); i++) {
      calculate();
    }
  }
  displayData();
  rod(initialTemp);

  if (initialTemp[0] == prevTemp) {
    start = false;
  }

  if (initialTemp[0] != leftEndTemp) {
    prevTemp = initialTemp[0];
  }
  //frameRate(5);
}

void initialConditions() {
  initialTemp = new float[floor(rodLength/delX)+1];
  finalTemp = new float[floor(rodLength/delX)+1];
  initialCond = new float[floor(rodLength/delX)+1];

  for (int i=0; i < initialTemp.length; i++) {
    if (i < initialTemp.length * div) {
      initialTemp[i] = leftEndTemp;
      initialCond[i] = leftEndTemp;
    } else {
      initialTemp[i] = rightEndTemp;
      initialCond[i] = rightEndTemp;
    }
  }
}

void boundaryConditions() {
  //slope = 0 at x = 0 & x = rod length
  initialTemp[0] = initialTemp[1];

  if (fixRightEnd) {
    initialTemp[finalTemp.length-1] = rightEndTemp;
    initialTemp[0] = leftEndTemp;
  } else {
    initialTemp[finalTemp.length-1] = initialTemp[finalTemp.length-2];
  }
}

void calculate() {

  for (int i=1; i < initialTemp.length-1; i++) {
    float termOne = (delT/(delX*delX))*thDiffusivity;
    float termTwo = initialTemp[i+1] - 2*initialTemp[i] + initialTemp[i-1];

    finalTemp[i] = initialTemp[i] + termOne * termTwo;
  }
  
  //store current temperature data to previous data
  for (int i=0; i < initialTemp.length; i++) {
    initialTemp[i] = finalTemp[i];
  }
  
  boundaryConditions();

  averageTemp = 0;
  for (int i=0; i < finalTemp.length; i++) {
    averageTemp += finalTemp[i];
  }
  averageTemp /=finalTemp.length;
}

void plot(float[] data, float strkW) {
  strokeWeight(.8);
  line(origin[0], origin[1], origin[0], 60);
  line(origin[0], origin[1], 450, origin[1]);
  line(origin[0], 60, 450, 60);
  line(450, origin[1], 450, 60);

  strokeWeight(strkW);
  for (int i=0; i < data.length; i++) {
    float x = i*delX*scaleX + origin[0];
    float y = -data[i]*scaleY + origin[1];

    point(x, y);
  }

  strokeWeight(0.1);
  float xMax = origin[0]+(data.length-1)*delX*scaleX;
  float yMax = -data[data.length-1]*scaleY +origin[1];

  line(xMax, yMax, origin[0], yMax);
  text(data[data.length-1], origin[0] - 50, yMax + 5);

  float xMin = origin[0] - 50;
  float yMin = -data[0]*scaleY +origin[1];

  fill(255);
  noStroke();
  rect(xMin, yMin-8, 45, 16);
  fill(2);
  stroke(2);
  text(data[0], xMin, yMin+5);

  fill(2);
}

void rod(float[] data) {
  strokeWeight(15);
  float prevX = 50;
  for (int i = 1; i < data.length; i++) {
    float x = 50 + i*delX*scaleX;
    float r = map(data[i], minTemp, maxTemp, 0, 255); //<>//
    stroke(r, 0, 255-r);
    line(prevX, height - 30, x, height-30);
    prevX = x;
  }
  stroke(50);
  strokeWeight(.2);
  line(50 + 400*div, 60, 50 + 400*div, height - 22);
  stroke(20);
  fill(255);
  circle(50 + 400*div, height - 29.5, 16);

  stroke(0);
}

void input() {
}

void displayData() {

  textSize(10);

  text("AverageTemp: " + averageTemp + " deg.C", 20, 15);
  text("Left end temp: " + initialTemp[0] + " deg.C", 20, 30);
  text("Right end temp: " + initialTemp[initialTemp.length-1] + " deg.C", 20, 45);
  text("Elapsed Time: " + elapsedTime/1000 + "s ", 200, 15);
  text("Material : " + material, 330, 15);
  text("Thermal Diffusivity : " + thDiffusivity + "mm2/s ", 330, 30);
  text("Rod Length : " + int(rodLength) + "mm ", 330, 45);
}

void keyPressed() {
  if (key == 32) {
    start = !start;
    time = millis() - elapsedTime;
  }
}
