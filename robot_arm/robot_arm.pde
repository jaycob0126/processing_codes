Node root;
Node child1;
Node child2;

float a = 2;

void setup(){
  
  size(500, 500);
   
  root = new Node("root", width/2, height/2, 0);
  child1 = new Node(root, "child1", 80, 80, 0);
  child2 = new Node(child1, "child2", 0, 100, 0);
  
}

void draw(){
  background(255);
  
  root.setRotateZ(radians(a));
  child1.setRotateZ(radians(a));
  
  root.update();
  
  
  root.render();
  child1.render();
  child2.render();
}
