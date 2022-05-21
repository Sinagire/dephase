public class Phaser {
  public Phaser(float xd, float yd, float r1d, float r2d, float omegad, boolean s){
    x = xd;
    y = yd;
    r1 = r1d;
    r2 = r2d;
    omega = omegad;
    theta = 0;
    axis_x = false;
    axis_y = false;
    flagShow = s;
  }
  public Phaser(float xd, float yd, float r1d, float r2d, float omegad){
    this(xd,yd,r1d,r2d,omegad,true);
  }

  public Phaser(float xd, float yd, float r1d, float r2d) {
    this(xd, yd, r1d, r2d, 1.0);
  }
  
  public void set(float t){
    theta = t;
  }

  public void advance(float time) {
    theta += omega * time;
  }
  
  public float theta(){
    return theta;
  }
  
  public void flip(){
    theta = -theta;
  }

  public void show(float angle) {
    if (!flagShow) return;
    pushMatrix();
    translate(x,y);
    rotate(angle);
    if (axis_x) show_axis_x();
    if (axis_y) show_axis_y();
    //float t = omega * time;
    fill(0, 0);
    stroke(0);
    strokeWeight(2);
    circle(0, 0, r1*2);
    fill(0);
    circle(r1*cos(theta), -r1*sin(theta), r2);
    popMatrix();
  }
  
  public void show(){
    show(0);
  }
  
  public void show_axis_x(){
    stroke(255,128,128);
    strokeWeight(1);
    line(-r1,0,r1,0);
  }
  
  public void show_axis_y(){
    stroke(128,255,128);
    strokeWeight(1);
    line(0,-r1,0,r1);
  }
  
  public boolean tgl_axis_x(){
    if (axis_x) {axis_x = false;}
    else {axis_x = true;}
    return axis_x;
  }
  
  public boolean tgl_axis_y(){
    if (axis_y) {axis_y = false;}
    else {axis_y = true;}
    return axis_y;
  }



  private float r;
  private float x, y;
  private float r1, r2;
  private float omega;
  private float theta;
  private boolean axis_x, axis_y;
  private boolean flagShow;
}
