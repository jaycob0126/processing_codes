PImage img;
int gridSize = 200;
float circleSize = 2;
int threshold = 105;

String imageURL = "photos\\";

String[] titles = {"einstein", "newton", "tesla", "uaap", "thea"};
int imgIndex = 0;

ArrayList<Vehicles> v;

void setup() {

  size(800, 800);

  img = loadImage(imageURL+titles[imgIndex]+".jpg");
  img.resize(width, height);

  v = new ArrayList();

  generate();
  
}

void draw() {

  background(0);

  for (Vehicles i : v) {
    i.update();
    i.render();
  }

  //if(frameCount%400 == 0){
  //  changeImg();  
  //}
}



void keyPressed() {
  if (key == 32) {
    changeImg();
  }
}

void changeImg() {
  
  imgIndex++;
  img = loadImage(imageURL+titles[imgIndex%titles.length]+".jpg");
  img.resize(width, height);
  

  v.clear();

  generate();

  for (Vehicles i : v) {
    i.relocate();
  }
}

void generate(){
  for (int i = 0; i < width; i+=width/gridSize) {
    for (int j=0; j<height; j+=height/gridSize) {
      float bright = brightness(img.get(i, j));

      if (bright > threshold) {
        v.add(new Vehicles(i, j, circleSize, color(img.get(i, j))));
      }
    }
  }  
}
