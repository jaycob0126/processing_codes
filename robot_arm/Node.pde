class Node {

  Node parent;
  ArrayList<Node> children = new ArrayList<Node>();

  PMatrix3D localPos;
  PMatrix3D globalPos;
  PMatrix3D oldLoc;

  String name;


  Node(String name, float x, float y, float z) {
    localPos = new PMatrix3D(1, 0, 0, x, 0, 1, 0, y, 0, 0, 1, z, 0, 0, 0, 1);
    globalPos = localPos.get();

    this.name = name;
  }

  Node(Node parent, String name, float x, float y, float z) {  
    localPos = new PMatrix3D(1, 0, 0, x, 0, 1, 0, y, 0, 0, 1, z, 0, 0, 0, 1);
    this.parent = parent;
    parent.addChildNode(this);
    updateMatrix();
    this.name = name;
  }

  void addChildNode(Node n) {
    children.add(n);
  }

  void update() {

    updateMatrix();

    for (Node child : children) {
      child.update();
    }
  }

  void set(float x, float y, float z) {
    localPos.set(1, 0, 0, x, 0, 1, 0, y, 0, 0, 1, z, 0, 0, 0, 1);
  }

  void rotateZ(float a) {
    localPos.rotateZ(a);
  }
  
  void setRotateZ(float a) {
    
    float x = localPos.m03;
    float y = localPos.m13;
    float z = localPos.m23;
    localPos.reset();
    localPos.rotateZ(a);
    localPos.m03 = x;
    localPos.m13 = y;
    localPos.m23 = z;
  }

  void updateMatrix() {

    if (parent == null) {
      globalPos = localPos.get();
      return;
    }

    globalPos = parent.globalPos.get();
    globalPos.apply(localPos);
  }

  void render() {

    circle(globalPos.m03, globalPos.m13, 10);
  }
}
