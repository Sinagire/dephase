public class oscillo {

  public oscillo (float xposd, float yposd, int height){
    oscillo = createGraphics(800*10,height);
    oscillo.beginDraw();
    oscillo.pushMatrix(); // To remember the initial state
    oscillo.pushMatrix();
    oscillo.endDraw();
    x_pos = xposd;
    y_pos = yposd;
  }


  public void record(float shift, float ave_y, float x, float s, float y_offset, float r){
    float yt = ave_y;
    osc_shift+=shift;
    oscillo.beginDraw();
    oscillo.popMatrix();
    oscillo.translate(shift,0);
    oscillo.fill(0,0);
    oscillo.circle(x, yt*s+y_offset, r);
    // x: the pointer's position
    // s: a scale factor, typically r1+r1+r2
    // r: the point size
    oscillo.pushMatrix();
    oscillo.endDraw();
  }

  public void show(){
    image(oscillo,-osc_shift,y_pos);
  }

  public void reset(){
    osc_shift=0;
    oscillo.beginDraw();
    oscillo.popMatrix();
    oscillo.popMatrix();
    oscillo.background(0,0);
    oscillo.pushMatrix();
    oscillo.pushMatrix();
    oscillo.endDraw();
  }
  


    private PGraphics oscillo;
    private float osc_shift;
    private float x_pos, y_pos;
}