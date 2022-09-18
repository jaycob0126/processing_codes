
PImage img;
String imgName = "Thea PRC Medium.jpg";
//String ASCII = "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\\|()1{}[]?-_+~<>i!lI;:,\"^`'.    ";
String ASCII = "@%#*+=-:.   ";

void setup() {

  size(800, 800);

  img = loadImage(imgName);
}

void draw() {
  background(0);
  img.loadPixels();

  float scaleX = width / img.width;
  float scaleY = height / img.height;
  
  String sequence;
  
  for (int j=0; j < img.height; j++) {
    for (int i=0; i < img.width; i++) {
      int index = (i + j*img.width);
      float r = red(img.pixels[index]);
      float g = green(img.pixels[index]);
      float b = blue(img.pixels[index]);

      float ave = (r + g + b)/3;
      float mapAscii = map(ave, 0, 255, 0, ASCII.length()-1);

      noStroke();
      text(ASCII.charAt(int(mapAscii)), i*scaleX, j*scaleY);
    }
  }

  noLoop();
}
