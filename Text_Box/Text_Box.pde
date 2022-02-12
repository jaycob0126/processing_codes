TextBox gear1;
TextBox gear2;

void setup(){
  
  size(800, 400);
   
  gear1 = new TextBox(20, 20);
  gear2 = new TextBox(20, 55);
  gear1.borderWidth(100);
  gear2.borderWidth(100);
  gear1.padding(5, 20, 5, 20);
  gear2.padding(5, 20, 5, 20);
  gear1.backgroundColor(100, 100, 100, 100);
  gear2.backgroundColor(100, 100, 100, 100);
  
}

void draw(){
  background(255);
  
  fill(0);
  gear1.render();
  gear2.render();
  
  if(gear1.hover() || gear2.hover()){
    cursor(TEXT);
  }else{
   cursor(ARROW); 
  }
}


void keyPressed(){
  
  gear1.keyListener();
  gear2.keyListener();
  
}

void mouseClicked(){
  gear1.click();
  gear2.click();
}
