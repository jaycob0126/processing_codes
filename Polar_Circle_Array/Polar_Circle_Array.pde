float s = 15;

void setup() {

  size(1280, 800);
}

void draw() {
  background(255);

  noStroke();

  //for(float r = 10.0; r < width; r=r+50.0){

  //  float theta = acos((pow(r,2)-2*pow(s/2,2))/pow(r,2));
  //  println(theta);

  //  for(float a = 0.0; a <= 2*PI; a=a+theta){

  //    float x = r*cos(a)+width/2;
  //    float y = r*sin(a)+height/2;

  //    circle(x, y, s);
  //  }
  //}



  //for (int i = 2; i <=300; i=i+10) {

  //  float theta = 2*PI/i;
  //  float R = sqrt((4*pow(s/2, 2))/(1-cos(theta)));

  //  fill(random(255), random(255), random(255));

  //  for (float a=0; a <=2*PI; a=a+theta) {
  //    float x = R*cos(a)+width/2;
  //    float y = R*sin(a)+height/2;

  //    circle(x, y, s);
  //  }
  //}



  float R = 0;
  int i = 2;
  float theta = 2*PI/i;;
  

  while (R<width/2+150) {

    theta = 2*PI/i;
    R = sqrt((4*pow(s/2, 2))/(1-cos(theta)));
    
    fill(random(255), random(255), random(255));

    for (float a=0; a <=2*PI; a=a+theta) {
      float x = R*cos(a)+width/2;
      float y = R*sin(a)+height/2;

      circle(x, y, s);
    }
    i=i+10;
  }
  noLoop();
  
}
