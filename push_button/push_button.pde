boolean pushButton = false;
boolean prevPButtonState;
boolean ledState = false;

void setup() {
  size(300, 300);

  prevPButtonState = pushButton;
}

void draw() {
  
  textSize(100);
  textAlign(CENTER);

  if (mousePressed) {
    pushButton = true;
  } else {
    pushButton = false;
  }



  // Rising edge condition
  if(pushButton && prevPButtonState != pushButton){
    ledState = !ledState;
  }
  prevPButtonState = pushButton;



  if (ledState) {
    fill(20);
    background(255);
    text("ON", width/2, height/2+25);    
  } else {
    fill(255);
    background(60);
    text("OFF", width/2, height/2+25);
  }
  
  textSize(15);
  textAlign(LEFT);
  if(pushButton){
    text("Push Button State: closed", 10, 20);
  }else{
    text("Push Button State: open", 10, 20);
  }
}
