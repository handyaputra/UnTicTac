//import processing.sound.*;
import ddf.minim.*;

Minim minim;

AudioSample round;
AudioSample in;
AudioSample done;
AudioPlayer bgm;

//SoundFile file;

PImage back, home;
int score = 0;
boolean start = false;
int nClicks = 0;
boolean[] checked = new boolean[9];
boolean odd = true;
char[] image = new char[9];

String state = "q0";

void setup() {
  size(500, 1000);
  keyPressed();
  
  minim = new Minim(this);
  round = minim.loadSample("circle.mp3", 128);
  in = minim.loadSample("in.mp3", 128);
  bgm  = minim.loadFile("bgm2.wav");
  done = minim.loadSample("done.mp3", 128);
  
  bgm.loop();
  
  back = loadImage("background_play.jpg");
  home = loadImage("home.jpg");
}

void stop() {
  round.close();
  minim.stop();
  super.stop();
}

void draw() {
  if (!start) {
    reset();
  }
  else {
    background(back);
    strokeWeight(1);
    stroke(100);
    fill(0);
    
    textSize(20);
    color(0);
    text("Wins: " + score, 10, 22);
    
    stroke(0);
    strokeWeight(10);
    line(175, 150, 175, 650);
    line(325, 150, 325, 650);
    line(20, 325, 480, 325);
    line(20, 475, 480, 475);
    
    noFill();
    stroke(255,0,0,150);
    ellipse(100,750,70,70);
    textSize(30);
    text("You",150,760);
    
    strokeWeight(10);
    stroke(100, 200, 0);
    line(290, 710, 340, 785);
    line(340, 710, 290, 785);
    text("CPU", 350, 760);
   
    for (int i = 0; i < 9; i++) {
      if (checked[i]) {
        switch(i) {
        case 0:  
          if (image[0] == 'X') cross(0);
          else circle(0);
          break;
        case 1:  
          if (image[1] == 'X') cross(1);
          else circle(1);
          break;
        case 2:  
          if (image[2] == 'X') cross(2);
          else circle(2);
          break;
        case 3:  
          if (image[3] == 'X') cross(3);
          else circle(3);
          break;
        case 4:  
          if (image[4] == 'X') cross(4);
          else circle(4);
          break;
        case 5:  
          if (image[5] == 'X') cross(5);
          else circle(5);
          break;
        case 6:  
          if (image[6] == 'X') cross(6);
          else circle(6);
          break;
        case 7:  
          if (image[7] == 'X') cross(7);
          else circle(7);
          break;
        case 8:  
          if (image[8] == 'X') cross(8);
          else circle(8);
          break;
        }
      }
    }
    
    if (state == "draw" || state == "lose") {
      stroke(255);
      strokeWeight(1);
      textSize(20);
      text("Game Selesai! Tekan ENTER", 125, 100);
    }
    
    finalCheck();
    if (state != "lose" && !odd){
      computePlay();
    }
  }
}

void keyPressed() {
  if (keyCode == ENTER){
    start = !start;
    in.trigger();
    println(state);
  }      
}

void reset() {
  background(home);
  strokeWeight(1);
  stroke(100);

  for (int i = 0; i < 9; i++) {
    checked[i] = false;
    image[i] = ' ';
  }
  
  if (state == "draw" || state == "lose") {
    if (state == "lose"){
      score--;
    }
    state = "q0";
  }
  
  odd = true;
  nClicks = 0;
}

void pcTurn(int n){
  cross(n);
  nClicks++;
  checked[n] = true;
  image[n] = 'X';
  odd = !odd;
}

void computePlay() {
  if (image[0] == 'X') {
    if (image[1] == 'X' && !checked[2]) {
      pcTurn(2);
      return;
    }
    if (image[2] == 'X' && !checked[1]) {
      pcTurn(1);
      return;
    }
    if (image[4] == 'X' && !checked[8]) {
      pcTurn(8);
      return;
    }
    if (image[8] == 'X' && !checked[4]) {
      pcTurn(4);
      return;
    }
    if (image[3] == 'X' && !checked[6]) {
      pcTurn(6);
      return;
    }
    if (image[6] == 'X' && !checked[3]) {
      pcTurn(3);
      return;
    }
  }
  
  if(image[1] == 'X') {
    if (image[2] == 'X' && !checked[0]) {
      pcTurn(0);
      return;
    }
    if (image[4] == 'X' && !checked[7]) {
      pcTurn(7);
      return;
    }
    if (image[7] == 'X' && !checked[4]) {
      pcTurn(4);
      return;
    }
  }
  
  if(image[2] == 'X') {
    if (image[4] == 'X' && !checked[6]) {
      pcTurn(6);
      return;
    }
    if (image[6] == 'X' && !checked[4]) {
      pcTurn(4);
      return;
    }
    if (image[5] == 'X' && !checked[8]) {
      pcTurn(8);
      return;
    }
    if (image[8] == 'X' && !checked[5]) {
      pcTurn(5);
      return;
    }
  }
  
  if(image[3] == 'X') {
    if (image[4] == 'X' && !checked[5]) {
      pcTurn(5);
      return;
    }
    if (image[5] == 'X' && !checked[4]) {
      pcTurn(4);
      return;
    }
    if (image[6] == 'X' && !checked[0]) {
      pcTurn(0);
      return;
    }
  }
  
  if(image[4] == 'X') {
    if (image[5] == 'X' && !checked[3]) {
      pcTurn(3);
      return;
    }
    if (image[6] == 'X' && !checked[2]) {
      pcTurn(2);
      return;
    }
    if (image[7] == 'X' && !checked[1]) {
      pcTurn(1);
      return;
    }
    if (image[8] == 'X' && !checked[0]) {
      pcTurn(0);
      return;
    }
  }
  
  if(image[5] == 'X') {
    if (image[8] == 'X' && !checked[2]) {
      pcTurn(2);
      return;
    }
  }
  
  if(image[6] == 'X') {
    if (image[7] == 'X' && !checked[8]) {
      pcTurn(8);
      return;
    }
    if (image[8] == 'X' && !checked[7]) {
      pcTurn(7);
      return;
    }
  }
  
  if(image[7] == 'X') {
    if (image[8] == 'X' && !checked[6]) {
      pcTurn(6);
      return;
    }
  }

  if (image[0] == 'O') {
    if (image[1] == 'O' && !checked[2]) {
      pcTurn(2);
      return;
    }
    if (image[2] == 'O' && !checked[1]) {
      pcTurn(1);
      return;
    }
    if (image[4] == 'O' && !checked[8]) {
      pcTurn(8);
      return;
    }
    if (image[8] == 'O' && !checked[4]) {
      pcTurn(4);
      return;
    }
    if (image[3] == 'O' && !checked[6]) {
      pcTurn(6);
      return;
    }
    if (image[6] == 'O' && !checked[3]) {
      pcTurn(3);
      return;
    }
  }

  if (image[1] == 'O') {
    if (image[2] == 'O' && !checked[0]) {
      pcTurn(0);
      return;
    }
    if (image[4] == 'O' && !checked[7]) {
      pcTurn(7);
      return;
    }
    if (image[7] == 'O' && !checked[4]) {
      pcTurn(4);
      return;
    }
  }

  if (image[2] == 'O') {
    if (image[4] == 'O' && !checked[6]) {
      pcTurn(6);
      return;
    }
    if (image[6] == 'O' && !checked[4]) {
      pcTurn(4);
      return;
    }
    if (image[5] == 'O' && !checked[8]) {
      pcTurn(8);
      return;
    }
    if (image[8] == 'O' && !checked[5]) {
      pcTurn(5);
      return;
    }
  }

  if (image[3] == 'O') {
    if (image[4] == 'O' && !checked[5]) {
      pcTurn(5);
      return;
    }
    if (image[5] == 'O' && !checked[4]) {
      pcTurn(4);
      return;
    }
    if (image[6] == 'O' && !checked[0]) {
      pcTurn(0);
      return;
    }
  }

  if (image[4] == 'O') {
    if (image[5] == 'O' && !checked[3]) {
      pcTurn(3);
      return;
    }
    if (image[6] == 'O' && !checked[2]) {
      pcTurn(2);
      return;
    }
    if (image[7] == 'O' && !checked[1]) {
      pcTurn(1);
      return;
    }
    if (image[8] == 'O' && !checked[0]) {
      pcTurn(0);
      return;
    }
  }

  if (image[5] == 'O') {
    if (image[7] == 'O' && !checked[8]) {
      pcTurn(8);
      return;
    }
    if (image[8] == 'O' && !checked[2]) {
      pcTurn(2);
      return;
    }
  }

  if (image[6] == 'O') {
    if (image[7] == 'O' && !checked[8]) {
      pcTurn(8);
      return;
    }
    if (image[8] == 'O' && !checked[7]) {
      pcTurn(7);
      return;
    }
  }

  if (image[7] == 'O') {
    if (image[5] == 'O' && !checked[8]) {
      pcTurn(8);
      return;
    }
    if (image[8] == 'O' && !checked[6]) {
      pcTurn(6);
      return;
    }
  }
  
  if(image[0] == 'X') {
    if(!checked[1] && !checked[2]) {
      pcTurn(2);
      return;
    }
    if(!checked[3] && !checked[6]) {
      pcTurn(6);
      return;
    }
    if(!checked[4] && !checked[8]) {
      pcTurn(8);
      return;
    }
  }
  
  if(image[2] == 'X') {
    if(!checked[0] && !checked[1]) {
      pcTurn(8);
      return;
    }
    if(!checked[4] && !checked[6]) {
      pcTurn(6);
      return;
    }
    if(!checked[5] && !checked[8]) {
      pcTurn(8);
      return;
    }
  }
  
  if(image[6] == 'X') {
    if(!checked[0] && !checked[3]) {
      pcTurn(0);
      return;
    }
    if(!checked[2] && !checked[4]) {
      pcTurn(2);
      return;
    }
    if(!checked[7] && !checked[8]) {
      pcTurn(8);
      return;
    }
  }
  
  if(image[8] == 'X') {
    if(!checked[0] && !checked[4]) {
      pcTurn(0);
      return;
    }
    if(!checked[2] && !checked[5]) {
      pcTurn(2);
      return;
    }
    if(!checked[6] && !checked[7]) {
      pcTurn(6);
      return;
    }
  }
  
  if (!checked[4]) {
    pcTurn(4);
    return;
  }
  
  if(image[0] == 'O') {
    if(!checked[5] && !checked[6] && image[7] == 'O') {
      pcTurn(8);
      return;
    }
  }
  
  if(image[2] == 'O') {
    if(!checked[5] && !checked[8] && image[7] == 'O') {
      pcTurn(8);
      return;
    }
    if(!checked[0] && !checked[1] && image[3] == 'O') {
      pcTurn(0);
      return;
    }
    if(!checked[0] && !checked[1]) {
      pcTurn(1);
      return;
    }
    if(!checked[5] && !checked[8]) {
      pcTurn(5);
      return;
    }
    if(!checked[4] && !checked[6]) {
      pcTurn(4);
      return;
    }
  }

  for (int i = 0; i < 8; i++) {
    if (!checked[i]) {
      pcTurn(i);
      return;
    }
  }
}

void finalCheck() {
  if ((image[0] == 'X' && image[1] == 'X' && image[2] == 'X') ||
    (image[0] == 'X' && image[4] == 'X' && image[8] == 'X') ||
    (image[0] == 'X' && image[3] == 'X' && image[6] == 'X') ||
    (image[1] == 'X' && image[4] == 'X' && image[7] == 'X') ||
    (image[2] == 'X' && image[4] == 'X' && image[6] == 'X') ||
    (image[2] == 'X' && image[5] == 'X' && image[8] == 'X') ||
    (image[3] == 'X' && image[4] == 'X' && image[5] == 'X') ||
    (image[6] == 'X' && image[7] == 'X' && image[8] == 'X') ||
   
    (image[0] == 'O' && image[1] == 'O' && image[2] == 'O') ||
    (image[0] == 'O' && image[4] == 'O' && image[8] == 'O') ||
    (image[0] == 'O' && image[3] == 'O' && image[6] == 'O') ||
    (image[1] == 'O' && image[4] == 'O' && image[7] == 'O') ||
    (image[2] == 'O' && image[4] == 'O' && image[6] == 'O') ||
    (image[2] == 'O' && image[5] == 'O' && image[8] == 'O') ||
    (image[3] == 'O' && image[4] == 'O' && image[5] == 'O') ||
    (image[6] == 'O' && image[7] == 'O' && image[8] == 'O')) {
      
      state = "lose";
    } else if (nClicks == 9){
        state = "draw";
    }
}

void circle(int box) {
  int x1 = 0, x2 = 0, y1 = 0, y2 = 0;
  switch(box) {
  case 0: 
    x1 = 20; 
    y1 = 150; 
    x2 = 175; 
    y2 = 325;
    break;
  case 1: 
    x1 = 175; 
    y1 = 150; 
    x2 = 325; 
    y2 = 325;
    break;
  case 2: 
    x1 = 325; 
    y1 = 150; 
    x2 = 475; 
    y2 = 325;
    break;
  case 3: 
    x1 = 20; 
    y1 =  315; 
    x2 = 175; 
    y2 = 485;
    break;
  case 4: 
    x1 = 175; 
    y1 = 315; 
    x2 = 325; 
    y2 = 485;
    break;
  case 5: 
    x1 = 325; 
    y1 = 315; 
    x2 = 475; 
    y2 = 485;
    break;
  case 6: 
    x1 = 20; 
    y1 = 475; 
    x2 = 175; 
    y2 = 650;
    break;
  case 7: 
    x1 = 175; 
    y1 = 475; 
    x2 = 325; 
    y2 = 650;
    break;
  case 8: 
    x1 = 325; 
    y1 = 475; 
    x2 = 475; 
    y2 = 650;
    break;
  }
  strokeWeight(10);
  stroke(220, 0, 0);  
  noFill();
  ellipse(x1 + (x2 - x1) / 2, y1 + (y2 - y1) / 2, 75, 75);
}

void cross(int box) {
  int x1 = 0, x2 = 0, y1 = 0, y2 = 0;
  switch(box) {
  case 0: 
    x1 = 20; 
    y1 = 150; 
    x2 = 175; 
    y2 = 325;
    break;
  case 1: 
    x1 = 175; 
    y1 = 150; 
    x2 = 325; 
    y2 = 325;
    break;
  case 2: 
    x1 = 325; 
    y1 = 150; 
    x2 = 475; 
    y2 = 325;
    break;
  case 3: 
    x1 = 20; 
    y1 =  315; 
    x2 = 175; 
    y2 = 485;
    break;
  case 4: 
    x1 = 175; 
    y1 = 315; 
    x2 = 325; 
    y2 = 485;
    break;
  case 5: 
    x1 = 325; 
    y1 = 315; 
    x2 = 475; 
    y2 = 485;
    break;
  case 6: 
    x1 = 20; 
    y1 = 475; 
    x2 = 175; 
    y2 = 650;
    break;
  case 7: 
    x1 = 175; 
    y1 = 475; 
    x2 = 325; 
    y2 = 650;
    break;
  case 8: 
    x1 = 325; 
    y1 = 475; 
    x2 = 475; 
    y2 = 650;
    break;
  }
  strokeWeight(10);
  stroke(100, 200, 0);
  line(x1 + 50, y1 + 50, x2 - 50, y2 - 50);
  line(x2 - 50, y1 + 50, x1 + 50, y2 - 50);
}

void myTurn(int n){
  checked[n] = true;
  image[n] = 'O';
  odd = !odd;
  nClicks++;
  round.trigger();
  println(state);
}

void mouseClicked() {
 if (state == "q0") {
   state = "q";
 }
 if (start && state != "lose" && (nClicks % 2) == 0) {
    if (mouseX > 20 && mouseX < 175) {
      if (mouseY > 150 && mouseY < 325) {
        if (!checked[0]) {
          state += "2";
          myTurn(0);
        }
      }
      if (mouseY > 325 && mouseY < 475) {
        if (!checked[3]) {
          state += "3";
          myTurn(3);
        }
      }
      if (mouseY > 475 && mouseY < 650) {
        if (!checked[6]) {
          state += "2";
          myTurn(6);
        }
      }
    }
    if (mouseX > 175 && mouseX < 325) {
      if (mouseY > 150 && mouseY < 325) {
        if (!checked[1]) {
          state += "3";
          myTurn(1);
        }
      }
      if (mouseY > 325 && mouseY < 475) {
        if (!checked[4]) {
          state += "1";
          myTurn(4);
        }
      }
      if (mouseY > 475 && mouseY < 650) {
        if (!checked[7]) {
          state += "3";
          myTurn(7);
        }
      }
    }
    if (mouseX > 325 && mouseX < 475) {
      if (mouseY > 150 && mouseY < 325) {
        if (!checked[2]) {
          state += "2";
          myTurn(2);
        }
      }
      if (mouseY > 325 && mouseY < 475) {
        if (!checked[5]) {
          state += "3";
          myTurn(5);
        }
      }
      if (mouseY > 475 && mouseY < 650) {
        if (!checked[8]) {
          state += "2";
          myTurn(8);
        }
      }
    }
    
    //if(nClicks != 10) {
    //  println(state);
    //}
  }
}
