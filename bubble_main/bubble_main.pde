
Bubble[] b = new Bubble[200];

ArrayList<Effect> e;
int score;

void setup() {
  size(1500, 1000);

  for (int i=0; i<b.length; i++) {
    b[i] = new Bubble(random(width), height);
  }
  
  e = new ArrayList<Effect>();
}

void draw() {
  background(230);

  for (int i=0; i<b.length; i++) {
    b[i].grow();
    b[i].floating();
    b[i].render();
  }
  
  for(int i=0; i < e.size(); i++){
    e.get(i).update();
  }
  
  if(e.size() > 4){
    for(int i=0; i < e.size()-4; i++)
    {
      e.remove(i);
    }
  }
  
  fill(50);
  textSize(50);
  text(score, width/2, 50);
  
}

void mousePressed(){
  
  for (int i=0; i<b.length; i++) {
    b[i].pop(mouseX, mouseY);
    if(b[i].hit){
        e.add(new Effect(mouseX, mouseY, 20));
        b[i].hit = false;
        score++;
    }
  }
}
