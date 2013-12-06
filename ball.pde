//The GPL License (GPL)

//Copyright (c) 2013 Natalia Lieskovska

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
