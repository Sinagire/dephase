public class ButtonList extends ArrayList<Button>{
  public ButtonList(){
  }
  
  public void show(){
    Iterator<Button> iter = iterator();
    while(iter.hasNext()){
      Button b = iter.next();
      b.show();
    }
  }
  
  public int regionIndex(float x, float y){
    int count = 0;
    Iterator<Button> iter = iterator();
    while(iter.hasNext()){
      Button b = iter.next();
      if(b.inRegion(x, y)) return count;
      count++;
    }
    return -1;
  }
}
