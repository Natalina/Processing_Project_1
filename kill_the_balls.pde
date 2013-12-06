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
