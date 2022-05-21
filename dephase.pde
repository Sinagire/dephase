import java.util.Iterator;

int ssize = 400;
boolean png=false;

float temp=0;
float time=0;
float default_speed = 0.1;
float speed;
int tgl=0;
int rs = 1; //ring scale
String num;

PhaserList pl;
ButtonList bl = new ButtonList();

void settings(){
  size(960/2, 540/2, P2D);
}

void setup(){
  //frameRate(30);
  speed = default_speed;
  float s = float(width)/960;
  int N=10*rs;
  int M=4*rs;
  float r1_pl=75*s;
  float r2_pl=10*s;
  float r1=40*s/rs;
  float r2=12*s/rs;
  float margin=14*s/rs;
  float m  = r1 + margin;
  float m2 = 2 * r1 + margin;
  float lm = 0.5 * (width - N * 2 * r1 - (N - 1) * margin); //left margin
  float bm = 0.5 * (height - margin * M - 2 * r1 * M - 2 * r1_pl); //bottom margin
  float y2 = margin * M + 2 * r1 * M; // higher edge of lower part 
  float sigma = 20.0;
  pl = new PhaserList(width-r1_pl-lm, height-bm-r1_pl,r1_pl,r2_pl,1.0, sigma);
  for (int j=0; j<M; j++){
    for (int i=0; i<N; i++){
      pl.add(new Phaser(lm+r1+m2*i,m+m2*j,r1,r2, 1.0+randomGaussian()/sigma));
    }
  }
  //pl.setLenShow(N*M/2);
  pl.setLenShow(1);
  num=str(pl.get_lenShow());
  //additional rotors
  for (int i=0; i<2000; i++){
    pl.add(new Phaser(0,0,0,0, 1.0+randomGaussian()/10.0,false));
  }
  float wx = 2*r1_pl;
  float wy = r1_pl - margin;
  int textSize = int(36*s);
  float bx1=lm;
  float bx2=lm+wx+margin;
  float bx3=lm+2*(wx+margin);
  float bx4=lm+3*(wx+margin);
  float by1=margin+y2;
  float by2=margin+y2+margin+wy;
  bl.add(new Button(bx1,by1,wx,wy,"Initialize",textSize));
  bl.add(new Button(bx1,by2,wx,wy,"Pause",textSize));
  bl.add(new Button(bx2,by1,wx,wy,"Axes",textSize));
  bl.add(new Button(bx2,by2,wx,wy,"Flip",textSize));
  bl.add(new Button(bx3,by1,(wx-margin)/2,wy,"+",textSize));
  bl.add(new Button(bx3+wx/2+margin/2,by1,(wx-margin)/2,wy,"-",textSize));
  bl.add(new Button(bx3,by2,wx,wy,"Rotate",textSize));
  bl.add(new Button(bx4,by1,wx,wy,num,textSize));
  bl.add(new Button(bx4,by2,wx,wy,"Exit",textSize));
}

void draw(){
  background(255);
  bl.show();
  pl.advance(speed);
  pl.show();
  pl.average();
  pl.showAverage();
  if (speed == 0){
    pl.oscillo_show(0);
  }
  else{
    pl.oscillo_show();
  }
  //pl.get(0).show(time);
  time += speed;
    
  if (png){
    saveFrame("mov3/test#####.png");
    if (time >= 200 * PI){
      exit();
    }
  }
}

void mouseReleased(){
  int i = bl.regionIndex(mouseX, mouseY);
  switch(i){
    case 0:
      pl.reset();
      break;
    case 1:
      if (speed == 0){
        speed = default_speed;
        bl.get(i).changeText("Pause");
      }
      else{
        speed = 0;
        bl.get(i).changeText("Play");
      }
      break;
    case 2:
      pl.tgl_axis_x();
      pl.tgl_axis_y();
      break;
    case 3:
      pl.flip();
      break;
    case 4:
      pl.increase(pl.get_lenShow() < 50 ? 1 : 10);
      bl.get(7).changeText(str(pl.get_lenShow()));
      break;
    case 5:
      pl.decrease(pl.get_lenShow() <= 50 ? 1 : 10);
      bl.get(7).changeText(str(pl.get_lenShow()));
      break;
    case 6:
      if (pl.tglRotate()){
        bl.get(6).changeText("Rest");
      }
      else{
        bl.get(6).changeText("Rotate");
      }
      break;
    case 7:
      boolean t = pl.tgl_inf();
      if(t) {bl.get(7).changeText("\u221E");}
      else {bl.get(7).changeText(str(pl.get_lenShow()));}
      break;
    case 8:
      exit();
      break;
  }
}
