//The GPL License (GPL)

//Copyright (c) 2013 Natalia Lieskovska

Ball ball[]=new Ball[30];
Maxim maxim;
AudioPlayer player_gunshot;
AudioPlayer player_ballon_boom;
AudioPlayer player_birds;
PImage bg;
PImage target;
PFont f;
boolean game_started=false;
boolean pause_game_bool=true;
int start_time_seconds;
int start_time_minutes;


void setup() {
  size(1000, 400);
  frameRate(40);
  stroke(0);
  strokeWeight(1);
  smooth();
  bg=loadImage("candy4.jpg");
  target=loadImage("target-red.png");
  for (int i=0; i<ball.length; i++) {
    ball[i]=new Ball();
  }
  f=createFont("SansSerif", 32, true);
  textFont(f, 32);
  message_show("Kill all the balls");
  maxim=new Maxim(this);
  player_gunshot=maxim.loadFile("explosion.wav");
  player_gunshot.volume(0.1);
  player_gunshot.setLooping(false);
  player_ballon_boom=maxim.loadFile("balloon_burst4.wav");
  player_ballon_boom.volume(0.5);
  player_ballon_boom.setLooping(false);
  player_birds=maxim.loadFile("birds.wav");
  player_birds.volume(2);
  player_birds.setLooping(true);
  player_birds.play();
}

void draw() {
  if (pause_game_bool) {
    noCursor();
    image(bg, 0, 0, width, height);
    int deleted_count=0;
    for (int i=0; i<ball.length; i++) {
      ball[i].move(); 
      if (ball[i].deleted_bool) {
        deleted_count++;
      }
    }
    image(target, mouseX-20, mouseY-20);
    score_show(deleted_count*50);
    time_show();
    if (deleted_count>=ball.length) {
      message_show("You won!");
    }
  }
}
void mousePressed() {
  if (game_started) {
//     player_gunshot=maxim.loadFile("explosion.wav");
//     player_gunshot.cue(0);
     player_gunshot.play();
   }
  if (!game_started) {
    game_started=true;
    start_time_seconds=second();
    start_time_minutes=minute();
  }
  pause_game_bool=true;
  for (int i=0; i<ball.length; i++) {
    if (dist(mouseX, mouseY, ball[i].xpos, ball[i].ypos)<20) {
      ball[i].deleted_bool=true;
      player_ballon_boom.cue(0);
      player_ballon_boom.play();
    }
  }
}



class Ball {
  int xpos;
  int ypos;
  color ballColor;
  float speedx;
  float speedy;
  boolean deleted_bool=false; 
  int boom_loop=0;

  Ball() {
    xpos=int(random(0, width));
    ypos=int(random(0, height));
    speedx=random(3, 7);
    speedy=random(3, 7);
    int r=int(random(0, 255));
    int g=int(random(0, 255));
    int b=int(random(0, 255));
    ballColor=color(r, g, b);
  }
  void display() {
    fill(ballColor);
    ellipse(xpos, ypos, 40, 40);
  }
  void move() {
    if (!deleted_bool) {
      ypos+=speedy;
      if (ypos>height || ypos<0) {
        speedy*=-1;
      }

      xpos+=speedx;
      if (xpos>width || xpos<0) {
        speedx*=-1;
      }
      display();
    }
    else if (boom_loop<90) {
      boom();
    }
  }

  void boom() {
    for (int i=0; i<10; i++) {
      int tx=xpos+int(random(-40, 40));
      int ty=ypos+int(random(-40, 40));
      int tx2=tx+int(random(-15, 15));
      int ty2=ty+int(random(-15, 15));
      int tx3=tx2+int(random(-15, 15));
      int ty3=ty2+int(random(-15, 15));
      int r=int(random(0, 255));
      int g=int(random(0, 100));
      fill(r, g, 0);
      triangle(tx, ty, tx2, ty2, tx3, ty3);
      boom_loop++;
    }
  }
}


void message_show(String message) {
  pause_game_bool=false;
  background(0);
  fill(255);
  text(message, width/2-textWidth(message)/2, height/2);
}
void score_show(int score) {
  fill(0, 0, 0, 60);
  rect(width-200, 0, width, height/8);
  fill(255, 255, 0);
  String score_str="Score: "+score;
  text(score_str, width-textWidth(score_str)-(200-textWidth(score_str))/2, 40);
}

void time_show() {
  fill(0, 0, 0, 60);
  rect(0, 0, 200, height/8);
  fill(255, 255, 0);
  int seconds=second()-start_time_seconds;
  if (seconds<0) seconds+=60;
  int minutes=minute()-start_time_minutes;
  if (minutes<0) minutes+=60;
  String extra_zero_seconds=""; 
  if (seconds<10) extra_zero_seconds="0";
  String extra_zero_minutes=""; 
  if (minutes<10) extra_zero_minutes="0";
  String time_str="Time: "+extra_zero_minutes+minutes+":"+extra_zero_seconds+seconds;
  text(time_str, 200-textWidth(time_str)-(200-textWidth(time_str))/2, 40);
}
