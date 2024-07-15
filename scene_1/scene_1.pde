int t = 1;
boolean mouthOpen = false;
int cloud1X = -150;
int cloud2X = -180;
int cloud3X = -120;
int person2X;
boolean person2Stopped = false;
boolean mouthAnimationStarted = false;
boolean person1MouthOpen = false;
boolean person2MouthOpen = false;

void setup() {
  fullScreen();
  background(#C2E6E8);
  frameRate(30); // Increase frame rate for smoother movement
  person2X = width / 2 + 100; // Mengatur posisi awal person2 di samping person1
}

void draw() {
  if ((t > 0) && (t <= 1350)) {
    scene1();
  }
  t++;
  if (t == 1351) {
    exit();
  }
}

void scene1() {
  scene_1();
  drawCloud1();
  drawCloud2();
  drawCloud3();
  drawPerson1();
  drawPerson2();
  
  // Update cloud positions
  cloud1X += 2;
  cloud2X += 1;
  cloud3X += 3;
  
  // Reset cloud positions to loop them
  if (cloud1X > width) {
    cloud1X = -180;
  }
  if (cloud2X > width) {
    cloud2X = -200;
  }
  if (cloud3X > width) {
    cloud3X = -160;
  }
  
  // Update mouth animation if started
  if (mouthAnimationStarted && frameCount % 15 == 0) {
    person1MouthOpen = !person1MouthOpen;
    person2MouthOpen = !person2MouthOpen;
  }
  
  // Update person2 position
  if (!person2Stopped) {
    person2X -= 5;
    if (person2X <= 500) { // Menyesuaikan nilai agar person2 berhenti di posisi yang diinginkan
      person2Stopped = true;
      mouthAnimationStarted = true; // Start mouth animation when person2 stops
    }
  }
}

void scene_1() {
  background(135, 206, 235);  // Sky blue

  // Draw sun
  noStroke();
  fill(255, 204, 0);  // Yellow
  ellipse(width/2, height/3, 150, 150);

  // Draw sea
  fill(0, 105, 148);  // Sea blue
  rect(0, height/2, width, height/3);

  // Draw beach
  fill(237, 201, 175);  // Sand color
  rect(0, height * 2/3, width, height/3);

  // Draw palm trees
  drawPalmTree(width/4, height * 2/3);
  drawPalmTree(3 * width/4, height * 2/3);
}

void drawPalmTree(float x, float y) {
  // Draw trunk
  fill(139, 69, 19);  // Brown color
  rect(x, y - 100, 20, 100);
  
  // Draw leaves
  fill(34, 139, 34);  // Green color
  ellipse(x + 10, y - 120, 80, 30);
  ellipse(x - 20, y - 110, 80, 30);
  ellipse(x + 40, y - 110, 80, 30);
  ellipse(x + 10, y - 90, 80, 30);
}

void drawCloud1() {
  int y = 150;
  fill(255);  // White
  noStroke();
  
  // Main body of the cloud
  ellipse(cloud1X, y, 180, 100);
  ellipse(cloud1X + 60, y + 20, 120, 80);
  ellipse(cloud1X - 60, y + 20, 120, 80);
  ellipse(cloud1X, y - 30, 140, 90);
  ellipse(cloud1X + 90, y - 10, 100, 60);
  ellipse(cloud1X - 90, y - 10, 100, 60);
}

void drawCloud2() {
  int y = 120;
  fill(255);  // White
  noStroke();
  
  // Main body of the cloud
  ellipse(cloud2X, y, 200, 110);
  ellipse(cloud2X + 70, y + 30, 140, 90);
  ellipse(cloud2X - 70, y + 30, 140, 90);
  ellipse(cloud2X, y - 40, 160, 100);
  ellipse(cloud2X + 100, y - 20, 120, 70);
  ellipse(cloud2X - 100, y - 20, 120, 70);
}

void drawCloud3() {
  int y = 250;
  fill(255);  // White
  noStroke();
  
  // Main body of the cloud
  ellipse(cloud3X, y, 160, 90);
  ellipse(cloud3X + 50, y + 20, 110, 70);
  ellipse(cloud3X - 50, y + 20, 110, 70);
  ellipse(cloud3X, y - 20, 130, 80);
  ellipse(cloud3X + 80, y - 10, 90, 50);
  ellipse(cloud3X - 80, y - 10, 90, 50);
}

void drawPerson1() {
  int x = 400, y = height * 2 / 3 - 20;
  pushMatrix();
  translate(x, y);
  noStroke();
  fill(#6B4723);
  ellipse(841.5 - x, 551 - y, 206.9, 194.6);
  fill(#FFD581);
  ellipse(841.5 - x, 569 - y, 171.8, 161.6);
  rect(820 - x, 645.1 - y, 43.1, 51.7);
  ellipse(751.7 - x, 569 - y, 27.2, 36);
  ellipse(932 - x, 569 - y, 27.2, 36);
  quad(768.4 - x, 704.9 - y, 780.3 - x, 716.7 - y, 746.8 - x, 750.4 - y, 734.7 - x, 739 - y);
  ellipse(742.7 - x, 742.5 - y, 30, 20.7);
  quad(902.8 - x, 716.8 - y, 914.8 - x, 704.9 - y, 948.3 - x, 737.8 - y, 936.4 - x, 750.4 - y);
  ellipse(941.8 - x, 742.5 - y, 30, 20.7);
  rect(803.9 - x, 811.4 - y, 21.5, 45.2);
  rect(853.3 - x, 812 - y, 21.5, 45.2);
  fill(#537188);
  ellipse(811.3 - x, 857.1 - y, 38.1, 17.7);
  ellipse(867.2 - x, 857.1 - y, 38.1, 17.7);
  fill(#F1F1F1);
  ellipse(805.1 - x, 556.6 - y, 29.8, 35.3);
  ellipse(881.6 - x, 556.6 - y, 29.8, 35.3);
  fill(#1E1A17);
  ellipse(805.1 - x, 559.1 - y, 19.1, 22.6);
  ellipse(881.6 - x, 559.1 - y, 19.1, 22.6);
  fill(#DDAD4D);
  ellipse(841.5 - x, 576.8 - y, 22.4, 12.7);
  stroke(#1E1A17);
  strokeWeight(4);
  noFill();
  if (person1MouthOpen) {
    arc(841.8 - x, 590.2 - y, 66.2, 26.9, radians(0), radians(180), OPEN);
  } else {
    arc(841.8 - x, 590.2 - y, 66.2, 26.9, radians(0), radians(180), CHORD);
  }
  noStroke();
  fill(#6B4723);
  ellipse(841.5 - x, 494.5 - y, 143.1, 70.9);
  fill(#B31312);
  quad(790.2 - x, 778.7 - y, 841.5 - x, 778.7 - y, 835.6 - x, 841.4 - y, 784.8 - x, 841.4 - y);
  quad(841.5 - x, 778.7 - y, 891.2 - x, 778.7 - y, 896.5 - x, 841.4 - y, 843.3 - x, 841.4 - y);
  fill(#2B2A4C);
  quad(784.8 - x, 679.8 - y, 898.3 - x, 679.8 - y, 878 - x, 663.4 - y, 805.1 - x, 663.4 - y);
  rect(784.8 - x, 678.8 - y, 113.5, 107.9);
  quad(785.8 - x, 678.8 - y, 785.8 - x, 724.7 - y, 775.4 - x, 735.7 - y, 750.9 - x, 711.1 - y);
  quad(897.3 - x, 678.8 - y, 897.3 - x, 724.7 - y, 907.8 - x, 735.7 - y, 932 - x, 711.1 - y);
  fill(#F6F6F6);
  quad(805.1 - x, 662.4 - y, 784.8 - x, 679.8 - y, 838.8 - x, 676 - y, 838.8 - x, 676 - y);
  quad(878 - x, 662.4 - y, 898.3 - x, 679.8 - y, 838.8 - x, 676 - y, 838.8 - x, 676 - y);
  fill(#FFD581);
  triangle(878 - x, 662.4 - y, 805.1 - x, 662.4 - y, 838.8 - x, 676 - y);
  popMatrix();
}

void drawPerson2() {
  int y = 200 * 2 / 3 - 100;
  pushMatrix();
  translate(person2X, y);
  noStroke();
  fill(#1E1A17);
  ellipse(841.5, 551, 206.9, 194.6);
  fill(#FFD581);
  ellipse(841.5, 569, 171.8, 161.6);
  rect(820, 645.1, 43.1, 51.7);
  ellipse(751.7, 569, 27.2, 36);
  ellipse(932, 569, 27.2, 36);
  quad(768.4, 704.9, 780.3, 716.7, 746.8, 750.4, 734.7, 739);
  ellipse(742.7, 742.5, 30, 20.7);
  quad(902.8, 716.8, 914.8, 704.9, 948.3, 737.8, 936.4, 750.4);
  ellipse(941.8, 742.5, 30, 20.7);
  rect(803.9, 811.4, 21.5, 45.2);
  rect(853.3, 812, 21.5, 45.2);
  fill(#F86F03);
  ellipse(811.3, 857.1, 38.1, 17.7);
  ellipse(867.2, 857.1, 38.1, 17.7);
  fill(#F1F1F1);
  ellipse(805.1, 556.6, 29.8, 35.3);
  ellipse(881.6, 556.6, 29.8, 35.3);
  fill(#1E1A17);
  ellipse(805.1, 559.1, 19.1, 22.6);
  ellipse(881.6, 559.1, 19.1, 22.6);
  fill(#DDAD4D);
  ellipse(841.5, 576.8, 22.4, 12.7);
  stroke(#1E1A17);
  strokeWeight(2);
  fill(#F1F1F1);
  if (person2MouthOpen) {
    arc(841.8, 590.2, 66.2, 26.9, radians(0), radians(180), OPEN);
  } else {
    arc(841.8, 590.2, 66.2, 26.9, radians(0), radians(180), CHORD);
  }
  noStroke();
  fill(#1E1A17);
  quad(757.5, 530.1, 925.6, 530.1, 908.6, 488.2, 774.5, 488.2);
  ellipse(841.5, 494.5, 143.1, 70.9);
  fill(#525FE1);
  quad(790.2, 778.7, 841.5, 778.7, 835.6, 841.4, 784.8, 841.4);
  quad(841.5, 778.7, 891.2, 778.7, 896.5, 841.4, 843.3, 841.4);
  fill(#FFA41B);
  quad(784.8, 679.8, 898.3, 679.8, 878, 663.4, 805.1, 663.4);
  rect(784.8, 678.8, 113.5, 107.9);
  quad(785.8, 678.8, 785.8, 724.7, 775.4, 735.7, 750.9, 711.1);
  quad(897.3, 678.8, 897.3, 724.7, 907.8, 735.7, 932, 711.1);
  fill(#F6F6F6);
  quad(805.1, 662.4, 784.8, 679.8, 838.8, 676, 838.8, 676);
  quad(878, 662.4, 898.3, 679.8, 838.8, 676, 838.8, 676);
  fill(#FFD581);
  triangle(878, 662.4, 805.1, 662.4, 838.8, 676);
  popMatrix();
}
