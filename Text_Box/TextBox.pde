class TextBox {

  /*
  *    Todo   
   *    - move text and color modifiers at constructor
   *    - Text highlighting
   *    - Fix alignmentY and justify when overflow
   *    - Fix blinker
   */
  /*-- strings --*/
  String value;
  String typedText = "";
  String blinkerType = "|";
  String blinker = "";
  char lastChar;

  /*-- sizes --*/
  float x, y, w, h, manualWidth, manualHeight;
  float textSize, textWidth, textHeight, lineHeight;
  float textOffsetX, textOffsetY;
  float paddingTop, paddingRight, paddingBottom, paddingLeft;
  float innerBoxWidth, innerBoxHeight;

  /*--- alignment ---*/
  int justify;
  int align;

  /*-- colors --*/
  color textColor;
  color backgroundColor;
  color borderColor;

  /*--- flags ---*/
  boolean focus = false;
  boolean click = false;
  int blinkerDelay = 30;
  int blinkerIndex = 0;

  /*--- states ---*/
  ArrayList lines;
  int blinkerX = 0;
  int blinkerY = 0;

  TextBox(float x, float y) {

    this.x = x;
    this.y = y;
    this.value="";
    this.textSize = 15;
    this.lineHeight = 0;

    this.paddingTop = 20;
    this.paddingRight = 20;
    this.paddingBottom = 20;
    this.paddingLeft = 20;

    this.lines = new ArrayList();

    textColor = color(0);
    backgroundColor = color(255);
    borderColor = color(10);
  }


  /*---------- Setters ---------- */
  void setTextSize(float size) {
    this.textSize = size;
  }

  void borderSize(float w, float h) {
    this.manualHeight = h;
    this.manualWidth = w;
  }

  void borderWidth(float w) {
    this.manualWidth = w;
  }

  void borderHeight(float h) {
    this.manualHeight = h;
  }

  void padding(float top, float right, float bottom, float left) {
    this.paddingTop = top;
    this.paddingRight = right;
    this.paddingBottom = bottom;
    this.paddingLeft = left;
  }

  void setLocation(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void justify(int type) {

    if (this.manualWidth <= 0) return;

    //type: LEFT, CENTER or RIGHT
    justify = type;
    float inBox = getInnerBoxWidth();
    
    switch(this.justify) {
    case RIGHT:
      textOffsetX = inBox;
      break;
    case CENTER:
      textOffsetX = inBox/2;
      break;
    default:
      textOffsetX = 0;
      break;
    }
  }

  void align(int type) {
    //type TOP, BOTTOM, CENTER, BASELINE
    //  align = type;

    //  float inBox = getInnerBoxHeight();
    //  switch(this.justify) {
    //  //case TOP:
    //  //  textOffsetY = ;
    //  //  break;
    //  case BOTTOM:
    //    textOffsetY = inBox;
    //    break;
    //  case CENTER:
    //    textOffsetY = inBox/2;
    //    break;
    //  default:
    //    textOffsetY = 0;
    //    break;
    //  }
  }
  void textColor(int r, int g, int b) {
    textColor = color(r, g, b);
  }

  void backgroundColor(int r, int g, int b, int a) {
    backgroundColor = color(r, g, b, a);
  }


  void setLineHeight(float h) {
    this.lineHeight = h;
  }

  /*---------- Getters ---------- */
  int getNumberOfLines() {   
    return lines.size()+1;
  }

  float getBorderWidth() {
    if (this.manualWidth <= 0) {
      return textWidth+paddingRight + paddingLeft;
    } else {
      return this.manualWidth + paddingRight + paddingLeft;
    }
  }

  float getBorderHeight() {

    if (this.manualHeight <= 0) {
      return textHeight+lineHeight*(getNumberOfLines()-1) + paddingBottom + paddingTop;
    } else {
      return this.manualHeight  + paddingBottom+paddingTop;
    }
  }

  float getInnerBoxWidth() {
    return getBorderWidth() - paddingRight - paddingLeft;
  }

  float getInnerBoxHeight() {
    return getBorderHeight() - paddingTop - paddingBottom;
  }


  /*---------- Helpers ---------- */
  void render() {

    renderBorder();

    renderText();

    onFocus();
  }

  void renderText() {

    renderBlinker();

    //store in lines list
    this.value = typedText+blinker;

    textSize(this.textSize);
    this.lineHeight = this.lineHeight>0?this.lineHeight:this.textHeight;
    textLeading(this.lineHeight );
    textHeight = textAscent()+textDescent();
    textWidth = textWidth(this.value);
    textAlign(justify, align);

    fill(textColor);

    clip(x+paddingLeft, y+paddingTop, getInnerBoxWidth(), getInnerBoxHeight());
    text(this.value, this.x+paddingLeft+textOffsetX, this.y+textAscent()+paddingTop+textOffsetY);
    noClip();
  }

  void renderBorder() {

    fill(backgroundColor);


    w = getBorderWidth();
    h = getBorderHeight();

    rect(x, y, w, h);
    checkIfClicked(x, y, w, h);
  }

  void renderBlinker() {

    blinkerIndex++;
    if (blinkerIndex >blinkerDelay && focus) {
      blinkerIndex = 0;
      if (blinker == this.blinkerType) {
        blinker= "";
      } else {
        blinker=this.blinkerType;
      }
    }
  }

  void checkIfClicked(float x, float y, float w, float h) {

    if (!click) return;

    if (mouseX >= x && mouseX <= x+w
      && mouseY >=y && mouseY <= y+h)
    {  
      focus = true;
    } else {
      blinker = " ";
      focus = false;
    }

    click = false;
  }

  void click() {
    click = true;
  }

  boolean hover() {
    if (mouseX >= x && mouseX <= x+w
      && mouseY >=y && mouseY <= y+h)
    {  
      return true;
    }
    
    return false;
  }

  void onFocus() {

    if (focus) {


      //overflow handling if justification is left
      if (checkOverflowX()) {
        justify(RIGHT);
      } else {
        justify(LEFT);
      }
    }
  }

  boolean checkOverflowX() {    
    return textWidth > getInnerBoxWidth();
  }

  void keyListener() {

    if (!focus) return;

    switch(key) {

    case '\n': //detects enter key
      typedText+="\n";      
      lines.add(this.value);
      blinkerX=0;
      blinkerY++;
      break;
    case 8: //detects backspace key
      int len = typedText.length();
      if (len <= 0) return;

      lastChar = typedText.charAt(len-1);

      if (lastChar == '\n') lines.remove(lines.size()-1);

      typedText = typedText.substring(0, len-1);
      break;

    case CODED:
      handleCodedKey(keyCode);
      break;

    default:

      String keyStroked =""+key ;

      //println(keyCode);

      //guard codes to only accept printable characters
      if (keyCode < 32) return;
      if (key==CODED) return;

      //if(cntrlOn & key==1){  
      //  println("select all");
      //  cntrlOn = false;
      //  return;
      //}

      typedText += keyStroked;
      blinkerX++;
      break;
    }
  }

  void handleCodedKey(int k) {
    switch(k) {
    case UP:
      moveBlinker(UP);
      break;
    case DOWN:

      moveBlinker(DOWN);

      println(blinkerX, blinkerY);

      break;
    case RIGHT:
      moveBlinker(RIGHT);

      break;
    case LEFT:
      moveBlinker(LEFT);


      break;
    }
  }

  void moveBlinker(int direction) {

    switch(direction) {
    case UP:

      blinkerY--;
      break;
    case DOWN:     

      blinkerY++;
      break;
    case RIGHT:

      blinkerX++;
      break;
    case LEFT:

      blinkerX--;
      break;
    }
  }
}
