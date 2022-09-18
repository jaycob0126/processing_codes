PShader toon;

void setup() {
  size(800, 800, P3D);
  noStroke();
  fill(204);
  toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");
  toon.set("resolutionX", displayWidth);
  toon.set("resolutionY", displayHeight);
}

void draw() {
  
  shader(toon);
  background(0);

  translate(width/2, height/2);
  rectMode(CENTER);
  rect(0, 0, 400, 400);

}
