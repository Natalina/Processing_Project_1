//The GPL License (GPL)

//Copyright (c) 2013 Natalia Lieskovska

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
