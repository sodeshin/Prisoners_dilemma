import controlP5.*;

ControlP5 cp5;

int c =0;
int myst = 0;
int opst = 0;
boolean myflag = true;
boolean opflag = true;
boolean mylastflag = true;
boolean oplastflag = true;
boolean myeverflag = true;
boolean opeverflag = true;
int mypoint = 0;
int oppoint = 0;
boolean startflag = false;

int NUMBATTLE = 300;//fix
int[] PlotData = new int[NUMBATTLE];
int[] OpData = new int[NUMBATTLE];

void setup(){
  textSize(16);
  textAlign(RIGHT);
  size(800,700);
  background(200);
  frameRate(10);
  cp5 = new ControlP5(this);
  fill(255, 0, 0); 
  text("My strategy",100,40);
  
  
  cp5.addRadioButton("radio")
     .setPosition(50,50)
     .setItemWidth(30)
     .setItemHeight(30)
     .addItem("Cooperate", 0)
     .addItem("Defect", 1)
     .addItem("Tit For Tat", 2)
     .addItem("Random", 3)
     .addItem("Friedman", 4)
     .addItem("Grofman", 5)
     .addItem("Reverse Tit For Tat", 6)
     .setColorLabel(color(0))
     .activate(0);
     fill(0, 0, 255); 
     text("Opponent strategy",290,40);
  cp5.addRadioButton("radio2")
     .setPosition(200,50)
     .setItemWidth(30)
     .setItemHeight(30)
     .addItem("cooperate", 0)
     .addItem("defect", 1)
     .addItem("tit for tat", 2)
     .addItem("random", 3)
     .addItem("friedman", 4)
     .addItem("grofman", 5)
     .addItem("reverse tit for tat", 6)
     .setColorLabel(color(0))
     .activate(0);
  
  
  cp5.addButton("st")
    .setLabel("START")
    .setPosition(400,100)
    .setSize(100,30);
  cp5.addButton("re")
    .setLabel("RESET")
    .setPosition(400,150)
    .setSize(100,30);
    
    //graph
    for(int i=0; i<NUMBATTLE; i++)  // plotするデータの初期化
      {
        PlotData[i] = 0;
        OpData[i] = 0;
      }
  int positionX = 200;
  int positionY = 300;
  int Width = 450;
  int Height = 300;
  pushMatrix();  // 座標系の保存
  noFill();  // 塗りつぶしなし
  stroke(100);  // 枠線の色
 strokeWeight(3);  // 枠線の幅
  translate(positionX, positionY);  // 枠の左上の点を指定
  rect(0, 0, Width, Height);  // 枠の描画
  
    strokeWeight(1);  // メモリ線の幅
  for (int i=1; i<6; i++)  // メモリ線の描画
  {
    line(0, Height/6*i, Width, Height/6*i);  // 縦軸
    line(Width/6*i, 0, Width/6*i, Height);  // 横軸
  }
  
  stroke(0);
  fill(100);  // メモリ値の文字色
  // 縦軸のメモリ値
  textSize(16);  // 文字の大きさ
  textAlign(RIGHT);
  int j = 0;  // 縦軸の目盛りの最低値
  for (int i=6; i>=0;i--)  // メモリ戦の描画
  {
    text(j, -width/3*0.02, Height/6*i);  // 文字の描画
    j = j + 250;  //toriaezu
  }
  pushMatrix();  // 座標系の保存
  rotate(radians(-90));  // 座標軸を90度回転
  textAlign(CENTER);  // 文字の座標指定位置
  text("gain", -Height/2, -width/3*0.1-30);  // 縦軸ラベルの描画
  popMatrix();  // 保存した座標系の出力
  // 横軸のメモリ値
  textAlign(CENTER);  // 文字の座標指定位置
  //text("time", Width, Height*1.08);  // 文字の描画
  j = 0;  // 横軸の目盛りの最低値
  for(int i=0; i<=6; i++)
  {
    text(j, Width/6*i, Height*1.08);  // 文字の描画
    j = j + 50;  // 横軸の目盛りの更新
  }
  text("time", Width/2, Height*1.2);  // 横軸ラベルの描画
  popMatrix();  // 保存した座標系の出力
}

void draw(){
  mypoint = 0;
  oppoint = 0;
  myflag = true;
  opflag = true;
  mylastflag = true;
  oplastflag = true;
  myeverflag = true;
  opeverflag = true;
  if(startflag == true){
    for(int i = 0;i < NUMBATTLE; i++){
      
      mylastflag = myflag;
      oplastflag = opflag;
      if(!mylastflag)myeverflag = false;
      if(!oplastflag)opeverflag = false;
      if(myst == 0){//co
        myflag = true;
      }else if(myst == 1){//de
        myflag = false;
      }else if(myst == 2){//tft
        myflag = oplastflag;
      }else if(myst == 3){//random
        int k1 = int(random(100));
        if(k1 < 50){
          myflag = true;
        }
        else{
          myflag = false;
        }
      }else if(myst == 4){//fridman
        if(opeverflag)
        myflag = true;
        else
        myflag = false;
      }else if(myst == 5){//gro
        if(mylastflag != oplastflag){
          int k1 = int(random(7));
          if(k1 < 2)
            myflag = true;
          else
            myflag = false;
        }else{
          myflag = true;
        }
      }else if(myst == 6){//rtft
        if(i == 0)
        myflag = false;
        else
        myflag = oplastflag;
      }
      
      
      if(opst == 0){
        opflag = true;
      }else if(opst == 1){
        opflag = false;
      }else if(opst == 2){
        opflag = mylastflag;
      }else if(opst == 3){
        int k1 = int(random(100));
        if(k1 < 50){
          opflag = true;
        }
        else{
          opflag = false;
        }
      }else if(opst == 4){
        if(myeverflag)
        opflag = true;
        else
        opflag = false;
      }else if(opst == 5){//gro
        if(oplastflag != mylastflag){
          int k1 = int(random(7));
          if(k1 < 2)
            opflag = true;
          else
            opflag = false;
        }else{
          opflag = true;
        }
      }else if(opst == 6){//rtft
        if(i == 0)
        opflag = false;
        else
        opflag = mylastflag;
      }
    
  
      if(myflag == true && opflag == true){
        mypoint += 3;
        oppoint += 3;
      }else if(myflag == true && opflag == false){
        mypoint += 0;
        oppoint += 5;
      }else if(myflag == false && opflag == true){
        mypoint += 5;
        oppoint += 0;
      }else if(myflag == false && opflag == false){
        mypoint += 1;
        oppoint += 1;
      }
      PlotData[i] = mypoint;
      OpData[i] = oppoint;
    }
    plot(mypoint, oppoint);
    
    println(mypoint);
    println(oppoint);
    startflag = false;
  }
  
}

void plot(int myscore, int opscore){
    int positionX = 200;
    int positionY = 300;
    int Width = 450;
    int Height = 300;
    pushMatrix();  // 座標系の保存
    noFill();  // 塗りつぶしなし
  stroke(100);  // 枠線の色
  strokeWeight(3);  // 枠線の幅
  translate(positionX, positionY);  // 枠の左上の点を指定
  rect(0, 0, Width, Height);  // 枠の描画
  
    strokeWeight(1);  // メモリ線の幅
  for (int i=1; i<6; i++)  // メモリ線の描画
  {
    line(0, Height/6*i, Width, Height/6*i);  // 縦軸
    line(Width/6*i, 0, Width/6*i, Height);  // 横軸
  }
  
  stroke(0);
  fill(100);  // メモリ値の文字色
  // 縦軸のメモリ値
  textSize(16);  // 文字の大きさ
  textAlign(RIGHT);
  int j = 0;  // 縦軸の目盛りの最低値
  for (int i=6; i>=0;i--)  // メモリ戦の描画
  {
    text(j, -width/3*0.02, Height/6*i);  // 文字の描画
    j = j + 250;  //toriaezu
  }
  pushMatrix();  // 座標系の保存
  rotate(radians(-90));  // 座標軸を90度回転
  textAlign(CENTER);  // 文字の座標指定位置
  text("gain", -Height/2, -width/3*0.1-30);  // 縦軸ラベルの描画
  popMatrix();  // 保存した座標系の出力
  textAlign(CENTER);  // 文字の座標指定位置
  //text("time", Width, Height*1.08);  // 文字の描画
  j = 0;  // 横軸の目盛りの最低値
  for(int i=0; i<=6; i++)
  {
    text(j, Width/6*i, Height*1.08);  // 文字の描画
    j = j + 50;  // 横軸の目盛りの更新
  }
  text("time", Width/2, Height*1.2);  // 横軸ラベルの描画
  for(int i=0; i<300-1; i++)
  {
    stroke(255, 0, 0); 
    line((i/300.0)*450, 300 - PlotData[i]/1500.0 * 300,((i+1)/300.0)*450, 300 - PlotData[i+1]/1500.0 * 300);
    
    stroke(0, 0, 255); 
    line((i/300.0)*450, 300 - OpData[i]/1500.0 * 300,((i+1)/300.0)*450, 300 - OpData[i+1]/1500.0 * 300);
  }
  fill(255, 0, 0); 
  text(myscore, 480, 300 - myscore/1500.0 * 300);
  fill(0, 0, 255); 
  text(opscore, 480, 300 - opscore/1500.0 * 300);
    //popMatrix();  
  stroke(0);  // 線の色を戻す
  popMatrix();  // 保存した座標系の出力
  
}

void radio(int theC) 
{
  switch(theC) 
  {
    case(0):
      myst=0;
      break;
    case(1):
      myst=1;
      break;
    case(2):
      myst=2;
      break;
    case(3):
      myst=3;
      break;
    case(4):
      myst=4;
      break;
    case(5):
      myst=5;
      break;
    case(6):
      myst=6;
      break;
  }
} 

void radio2(int theC) 
{
  switch(theC) 
  {
    case(0):
      opst=0;
      break;
    case(1):
      opst=1;
      break;
    case(2):
      opst=2;
      break;
    case(3):
      opst=3;
      break;
    case(4):
      opst=4;
      break;
    case(5):
      opst=5;
      break;
    case(6):
      opst=6;
      break;
  }
} 

void st(){
  startflag = true;
  //exit();
}
void re(){
  fill(0);
  background(200);
  textSize(16);  // 文字の大きさ
  textAlign(RIGHT);
  fill(255, 0, 0); 
  text("My strategy",100,40);
  fill(0, 0, 255); 
  text("Opponent strategy",290,40);
  
    int positionX = 200;
    int positionY = 300;
    int Width = 450;
    int Height = 300;
    pushMatrix();  // 座標系の保存
    noFill();  // 塗りつぶしなし
  stroke(100);  // 枠線の色
  strokeWeight(3);  // 枠線の幅
  translate(positionX, positionY);  // 枠の左上の点を指定
  rect(0, 0, Width, Height);  // 枠の描画
  
    strokeWeight(1);  // メモリ線の幅
  for (int i=1; i<6; i++)  // メモリ線の描画
  {
    line(0, Height/6*i, Width, Height/6*i);  // 縦軸
    line(Width/6*i, 0, Width/6*i, Height);  // 横軸
  }
  
  stroke(0);
  fill(100);  // メモリ値の文字色
  // 縦軸のメモリ値
  textSize(16);  // 文字の大きさ
  textAlign(RIGHT);
  int j = 0;  // 縦軸の目盛りの最低値
  for (int i=6; i>=0;i--)  // メモリ戦の描画
  {
    text(j, -width/3*0.02, Height/6*i);  // 文字の描画
    j = j + 250;  //toriaezu
  }
  pushMatrix();  // 座標系の保存
  rotate(radians(-90));  // 座標軸を90度回転
  textAlign(CENTER);  // 文字の座標指定位置
  text("gain", -Height/2, -width/3*0.1-30);  // 縦軸ラベルの描画
  popMatrix();  // 保存した座標系の出力
  // 横軸のメモリ値
  textAlign(CENTER);  // 文字の座標指定位置
  //text("time", Width, Height*1.08);  // 文字の描画
  j = 0;  // 横軸の目盛りの最低値
  for(int i=0; i<=6; i++)
  {
    text(j, Width/6*i, Height*1.08);  // 文字の描画
    j = j + 50;  // 横軸の目盛りの更新
  }
  text("time", Width/2, Height*1.2);  // 横軸ラベルの描画
  popMatrix();  // 保存した座標系の出力
}





