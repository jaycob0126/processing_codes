
PImage img;

void setup() {

  size(500, 500);

  img = loadImage("Thea PRC Small.jpg");
  //image(img, 0, 0, width, height);

  img.loadPixels();

  for (int j=0; j < img.height; j++) {
    for (int i=0; i < img.width; i++) {
      int index = (i + j*img.width)*4;
      color r = img.pixels[index];
      color g = img.pixels[index+1];
      color b = img.pixels[index+2];
      
      fill(r,g,b);
    }
  }
}

void draw() {
}
