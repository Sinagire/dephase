public class Button {
  public Button(float xd, float yd, float wxd, float wyd, String t, int ts) {
    x = xd;
    y = yd;
    wx = wxd;
    wy = wyd;
    text = t;
    textSize = ts;
  }
  public Button(float xd, float yd, float wxd, float wyd) {
    this(xd, yd, wxd, wyd, "", 14);
  }

  public void show() {
    fill(192);
    stroke(0);
    strokeWeight(1);
    rect(x, y, wx, wy);
    fill(0);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(text, x+wx*0.5, y+wy*0.4);
  }
  
  public void changeText(String t){
    text = t;
  }
  
  public boolean inRegion(float xd, float yd){
    return ( x < xd && xd < x + wx
    && y < yd && yd < y + wy);
  }

  private float x, y, wx, wy;
  private String text;
  private int textSize;
}
