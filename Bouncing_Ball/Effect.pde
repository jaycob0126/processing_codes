
class Effect{
  
  float x, y;
  
  int spillCount;
  
  ArrayList<Spill> s;
  
  Effect(float x, float y, int spillCount){
    
    this.x = x;
    this.y = y;
    
    this.spillCount = (int)random(3, spillCount);
    
    s = new ArrayList<Spill>();
    
    for(int i=0; i<spillCount; i++){
      s.add(new Spill(x, y, random(1, 10), color(random(255), random(255), random(255))));
    }
    
  }
  
  Effect(float x, float y, int spillCount, float strength){
    
    this.x = x;
    this.y = y;
    
    this.spillCount = (int)random(3, spillCount);
    
    s = new ArrayList<Spill>();
    
    for(int i=0; i<spillCount; i++){
      s.add(new Spill(x, y, strength*random(2, 15), color(random(150))));
    }
    
  }

  void play(){
    
    for(int i=0; i<s.size(); i++){
      s.get(i).update();
      s.get(i).render();
      
      if(!s.get(i).alive){
        s.remove(i);
      }
    }    
  }

      
}
