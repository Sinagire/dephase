public class PhaserList extends ArrayList<Phaser>{

  public PhaserList(float xd, float yd, float r1d, float r2d, float omegad, float sigmad){
    x = xd;
    y = yd;
    r1 = r1d;
    r2 = r2d;
    len = 0;
    lenShow = -1;
    oscillo = createGraphics(800*10,int((r1d+r2d)*2));
    oscillo.beginDraw();
    oscillo.pushMatrix(); // To remember the initial state
    oscillo.pushMatrix();
    oscillo.endDraw();
    omega = omegad;
    theta = 0;
    sigma = sigmad;
    inf = false;
    axis_x = false;
    axis_y = false;
  }
  
  public void average() {
    Iterator<Phaser> iter = iterator();
    ave_x = 0;
    ave_y = 0;
    if (inf == true){
      float damp = theta / omega / sigma;
      ave_x = +cos(theta) * exp(-(damp * damp)/2.0);
      ave_y = -sin(theta) * exp(-(damp * damp)/2.0);
      return;
    }
    int count = 0;
    while(iter.hasNext()){
      count++;
      Phaser p = iter.next();
      float theta = p.theta();
      ave_x += +cos(theta);
      ave_y += -sin(theta);
      if (count == get_lenShow()) break;
    }
    ave_x /= count;
    ave_y /= count;
  }
  
  public void flip(){
    Iterator<Phaser> iter = iterator();
    while(iter.hasNext()){
      Phaser p = iter.next();
      p.flip();
    }
    theta = -theta;
  }
  
  public void advance(float speed){
    Iterator<Phaser> iter = iterator();
    while(iter.hasNext()){
      Phaser p = iter.next();
      p.advance(speed);
    }
    theta += omega * speed;
  }
  
  public void tgl_axis_x(){
    Iterator<Phaser> iter = iterator();
    while(iter.hasNext()){
      Phaser p = iter.next();
      p.tgl_axis_x();
    }
    axis_x = (axis_x ? false : true);

  }
  
  public void tgl_axis_y(){
    Iterator<Phaser> iter = iterator();
    while(iter.hasNext()){
      Phaser p = iter.next();
      p.tgl_axis_y();
    }
    axis_y = (axis_y ? false : true);
  }
  
  public boolean tgl_inf(){
    if (inf) {inf = false;}
    else {inf = true;}
    return inf;
  }
  
  public boolean tglRotate(){
    if (flagRotate) {flagRotate = false;}
    else {flagRotate = true;}
    return flagRotate;
  }
  
  public void show(){
    float t = 0;
    if(flagRotate) t = theta;
    Iterator<Phaser> iter = pl.iterator();
    int count = 0;
    while(iter.hasNext()){
      count++;
      Phaser p = iter.next();
      p.show(t);
      if (count == get_lenShow()) break;
    }
  }
  
  public void decrease(int i){
    lenShow = get_lenShow() - i;
    if (lenShow <= 0) lenShow = 1;
  }
  
  public void increase(int i){
    lenShow = get_lenShow() + i;
    if (lenShow > len) lenShow = len;
  }
  
  public void setLenShow(int l){
    if (0 < l && l <= len) lenShow = l; 
  }
  
  public void showAverage(){
    float t = 0;
    if (flagRotate) {t = theta;}
    pushMatrix();
    translate(x,y);
    rotate(t);
    fill(0,0);
    stroke(255,0,0);
    strokeWeight(2);
    circle(0,0,r1*2);
    fill(255,0,0);
    circle(ave_x*r1,ave_y*r1,r2);
    if (axis_x) line(-r1,0,r1,0);
    if (axis_y) line(0,-r1,0,r1);
    popMatrix();
  }
  
  
  public void oscillo_show(float shift){
    float yt = ave_y;
    //if (flagRotate) yt = ave_x * sin(theta) + ave_y * cos(theta); 
    osc_shift+=shift;
    oscillo.beginDraw();
    oscillo.popMatrix();
    oscillo.translate(shift,0);
    oscillo.fill(0,0);
    oscillo.circle(x-r1-r2, yt*r1+r1+r2, r2);
    oscillo.pushMatrix();
    oscillo.endDraw();
    image(oscillo,-osc_shift,y-r1-r2);
  }
  
  public void reset(){
    Iterator<Phaser> iter = iterator();
    while(iter.hasNext()){
      Phaser p = iter.next();
      p.set(0);
    }
    oscillo_reset();
    theta = 0;
  }
  
  public void oscillo_reset(){
    osc_shift=0;
    oscillo.beginDraw();
    oscillo.popMatrix();
    oscillo.popMatrix();
    oscillo.background(0,0);
    oscillo.pushMatrix();
    oscillo.pushMatrix();
    oscillo.endDraw();
  }
  
  public void oscillo_show(){
    oscillo_show(0.5);
  }
  
  public boolean add(Phaser p){
    len++;
    return super.add(p);
  }
  
  public int get_lenShow(){
    if (lenShow > 0) return lenShow;
    return len;
  };
    
    private float x, y;
    private float r1, r2;
    private float ave_x, ave_y;
    private PGraphics oscillo;
    private float osc_shift;
    private int len, lenShow;
    private float omega, theta, sigma;
    private boolean inf;
    private boolean flagRotate;
    private boolean axis_x, axis_y;
}
