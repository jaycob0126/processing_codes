class Sliders {

  String title;

  Sliders parent;
  ArrayList<Slider> children;

  float x, y, w, h;
  float localX, localY;

  //states
  boolean hidden = false;
  boolean prevButtonState = false;
  boolean windowDragging = false;

  float prevMouseX, prevMouseY;
  Sliders(String title, float x, float y) {
    this.title = title;
    this.x = x+25;
    this.y = y+45;
    this.localX=0;
    this.localY=0;

    children = new ArrayList<Slider>();
  }

  Sliders(String title) {
    this.title = title;
    this.x = 25;
    this.y = 45;
    this.localX=0;
    this.localY=0;

    children = new ArrayList<Slider>();
  }

  Slider addSlider(String title, float step, float min, float max) {
    Slider s = new Slider(title, step, min, max);
    addChild(s);

    return children.get(children.size()-1);
  }

  Slider addSlider(String title, float step, float min, float max, float def) {
    Slider s = new Slider(title, step, min, max, def);
    addChild(s);

    return children.get(children.size()-1);
  }
  void addChild(Slider c) {
    if (this.children.size() == 0) {
      c.x = this.x;
      c.y = this.y;
      c.parent = this;
      children.add(c);
      return;
    }

    c.y = this.y;

    for (Sliders child : children) {
      c.localY += child.h;
      c.y += c.localY;
      c.x = this.x;
    }
    c.parent = this;
    children.add(c);
  }

  void render() {
    fill(200, 200, 200, 230);
    rectMode(CORNER);
    if (!hidden) {
      rect(x-20, y-20, w+40, h+20);
    }
    fill(50);
    rect(x-20, y-40, w+40, 20);
    fill(200, 0, 0);
    circle(x+w+10, y-30, 15);
    fill(255);
    textSize(12);
    text(title, x-10, y-25);

    if (!hidden) {
      for (Sliders c : children) {
        c.render();
        c.update();
      }
    } else {
    }

    this.update();
  }

  void update() {
    h = 0;
    w = 0;

    for (Sliders c : children) {

      //adjust the width to the longest slider
      if (w < c.w) {
        w=c.w;
      }
      if (hidden) {
        h = 0;
      } else {
        h += c.h;
      }
    }


    moveWindow();
    toggleHide();
  }

  void moveWindow() {
    float deltaX = mouseX - prevMouseX;
    float deltaY = mouseY - prevMouseY;

    if (mouseX > x-20 && mouseX < x+w+20
      && mouseY > y-40 && mouseY < y-20 
      && mousePressed) {
      windowDragging = true;
    } else if (mousePressed) {
    } else {
      windowDragging = false;
    }

    edgeDetect(deltaX, deltaY);

    prevMouseX = mouseX;
    prevMouseY = mouseY;
  }

  void toggleHide() {
    if (mouseX > x+w && mouseX < x+w+20
      && mouseY > y-40 && mouseY < y-20 
      && mousePressed && !prevButtonState) {
      hidden = !hidden;
    }
    prevButtonState = mousePressed;
  }

  void edgeDetect(float deltaX, float deltaY) {
    //edge detection code

    if (windowDragging) {
      x += deltaX;
      y += deltaY;

      if (x < 20) {
        x = 20.1;
      }
      if (x + w +20 > width) {
        x = width-w-20.1;
      }

      if (y < 40) {
        y = 40.1;
      }

      if (y + h > height) {
        y = height-h - 0.1;
      }
    }
  }
}

//Class for slider button and controls
class Slider extends Sliders {

  //values
  float step, min, max, value;

  //slide
  float slideW, slideH, slideL;
  float slideX, slideY;
  color slideColor = color(0, 10, 200);
  color slideColorHover = color(250, 0, 0);
  color slideAnimColor;

  //spacing
  float lineSpacing = 15;

  //states
  boolean hover = false;
  boolean pressed = false;
  boolean dragged = false;

  Slider(String title, float step, float min, float max) {
    super(title, 0, 0);

    this.slideW = 15;
    this.slideH = 15;
    this.slideL = 150;
    this.h = 40;
    this.w = slideL;

    this.value = min;
    this.title = title;
    this.min = min;
    this.step = step;
    this.max = max;
  }

  Slider(String title, float step, float min, float max, float def) {
    super(title, 0, 0);

    this.slideW = 15;
    this.slideH = 15;
    this.slideL = 150;
    this.h = 40;
    this.w = slideL;

    if (def == 0) {
      this.value = min;
    } else {
      this.value = def;
    }
    this.title = title;
    this.min = min;
    this.step = step;
    this.max = max;
  }

  void setValue(float x) {
    this.value = x;
  }

  void update() {
    slideX = this.x+map(value, min, max, 0, slideL);
    slideY = this.y + lineSpacing;
    this.w = slideL;

    x = parent.x;
    y = parent.y+localY;

    checkHover(mouseX, mouseY);
    checkMouseDrag();
    dragSlider();
    prevMouseX = mouseX;

    if (value > max) {
      value = max;
    }
    if (value < min) {
      value = min;
    }
  }

  void render() {
    fill(20);
    textSize(12);
    text(this.title + " " + value, this.x, this.y);

    stroke(230);
    line(this.x, this.y + lineSpacing, this.x+slideL, this.y+lineSpacing); 

    noStroke();
    fill(slideAnimColor);
    rectMode(CENTER);
    ellipse(slideX, slideY, slideW, slideH);

    textSize(10);
    fill(0);
  }

  void checkHover(float x, float y) {

    if (x < slideX + slideW/2 && x > slideX-slideW/2
      && y < slideY + slideH/2 && y > slideY - slideH/2) {
      slideAnimColor = slideColorHover;
      hover = true;
    } else {
      slideAnimColor = slideColor;
      hover = false;
    }
  }

  void checkMouseDrag() {
    if (hover && mousePressed) {
      pressed = true;
    } else if (mousePressed) {
    } else {
      pressed = false;
    }

    if (abs(mouseX-prevMouseX) != 0 && pressed) {
      dragged = true;
    } else {
      dragged = false;
    }
  }

  void dragSlider() {
    if (!dragged) return;

    if (mouseX > slideX+slideL*step/(max-min)) {
      value+=step;
    }
    if (mouseX < slideX-slideL*step/(max-min)) {
      value-=step;
    }
  }
}
