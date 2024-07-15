float waveOffset = 0;

// Cloud positions and speeds
float cloud1X = 100;
float cloud2X = 300;
float cloud3X = 500;
float cloudSpeed1 = 0.5;
float cloudSpeed2 = 0.3;
float cloudSpeed3 = 0.7;

// Ship positions and offsets
float[] shipOffsets = new float[3];

// Person positions and speeds
float person1X;
float person2X;
float personSpeed = 5.0; // Speed of both persons

// Flags to indicate if persons have met
boolean personsMet = false;
float mouthMovement = 0;

void setup() {
  fullScreen();
  frameRate(30); // Set the frame rate to 30 FPS for smooth animation
  person1X = width; // Start Person1 at the right edge of the screen
  person2X = width; // Start Person2 at the right edge of the screen
  for (int i = 0; i < shipOffsets.length; i++) {
    shipOffsets[i] = random(0, 1000); // Initialize random offsets for ships
  }
}

void draw() {
  background(135, 206, 235); // Sky blue background

  // Draw ocean
  drawOcean();

  // Draw beach with texture
  drawBeach();

  // Draw lighthouse
  drawLighthouse(width * 0.9, height * 0.5);

  // Draw clouds
  drawCloud1();
  drawCloud2();
  drawCloud3();

  // Draw ships
  drawShip(width * 0.4, 0.65, 0);
  drawShip(width * 0.5, 0.65, 1);
  drawShip(width * 0.6, 0.65, 2);

  // Draw people
  drawPerson1();
  drawPerson2();

  // Update wave offset for animation
  waveOffset += 0.02;

  // Update cloud positions for animation
  updateCloudPositions();

  // Update Person positions
  updatePersonPositions();

  // Animate mouth movement if persons have met
  if (personsMet) {
    mouthMovement = sin(frameCount * 0.1) * 5;
  }
}

void drawOcean() {
  fill(70, 130, 180);
  beginShape();
  for (int x = 0; x <= width; x += 10) {
    float y = height * 0.5 + map(noise(x * 0.02, waveOffset), 0, 1, -20, 20);
    vertex(x, y);
  }
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}

void drawBeach() {
  loadPixels();
  for (int y = (int)(height * 0.75); y < height; y++) {
    for (int x = 0; x < width; x++) {
      float noiseValue = noise(x * 0.05, y * 0.05);
      color sandColor = lerpColor(color(238, 214, 175), color(210, 180, 140), noiseValue);
      pixels[x + y * width] = sandColor;
    }
  }
  updatePixels();
}

void drawLighthouse(float x, float y) {
  fill(255);
  rect(x - 10, y - 60, 20, 60);
  fill(255, 0, 0);
  rect(x - 15, y - 60, 30, 10);
  fill(255, 255, 0);
  ellipse(x, y - 65, 15, 15);
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

void updateCloudPositions() {
  cloud1X += cloudSpeed1;
  cloud2X += cloudSpeed2;
  cloud3X += cloudSpeed3;
  
  // Reset clouds to the left side when they go off-screen
  if (cloud1X > width + 100) {
    cloud1X = -100;
  }
  if (cloud2X > width + 100) {
    cloud2X = -100;
  }
  if (cloud3X > width + 100) {
    cloud3X = -100;
  }
}

void drawShip(float x, float relativeY, int index) {
  float y = height * relativeY + map(noise(x * 0.02, waveOffset + shipOffsets[index]), 0, 1, -20, 20);
  // Bagian bawah kapal
  fill(139, 69, 19); // Warna coklat
  beginShape();
  vertex(x - 60, y + 30);
  vertex(x + 60, y + 30);
  vertex(x + 40, y + 60);
  vertex(x - 40, y + 60);
  endShape(CLOSE);
  
  // Bagian tengah kapal
  fill(160, 82, 45); // Warna coklat lebih terang
  rect(x - 40, y - 20, 80, 40);

  // Tiang kapal
  fill(160, 82, 45);
  rect(x - 5, y - 80, 10, 100);

  // Layar kapal
  fill(255);
  triangle(x, y - 60, x + 60, y, x - 60, y);
  triangle(x, y - 40, x + 40, y, x - 40, y);

  // Bendera kapal
  fill(0);
  rect(x, y - 100, 50, 20);
  fill(255);
  ellipse(x, y - 100, 15, 15); // Gambar tengkorak sederhana

  // Jendela kapal
  fill(255);
  ellipse(x - 30, y + 30, 20, 20);
  ellipse(x, y + 30, 20, 20);
  ellipse(x + 30, y + 30, 20, 20);
}

void drawPerson1() {
  int y = height * 2 / 3 - 150; // Person1 in the bottom left corner, slightly higher
  pushMatrix();
  translate(person1X, y);
  scale(0.5); // Scale down the person
  noStroke();
  fill(#6B4723);
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
  fill(#537188);
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
  strokeWeight(4);
  noFill();
  arc(841.8, 590.2 + mouthMovement, 66.2, 26.9, radians(10), radians(170)); // Move mouth
  noStroke();
  fill(#6B4723);
  ellipse(841.5, 494.5, 143.1, 70.9);
  fill(#B31312);
  quad(790.2, 778.7, 841.5, 778.7, 835.6, 841.4, 784.8, 841.4);
  quad(841.5, 778.7, 891.2, 778.7, 896.5, 841.4, 843.3, 841.4);
  fill(#4285F4);  // Warna baju baru
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

void drawPerson2() {
  int y = height * 2 / 3 - 150; // Same height as Person1
  pushMatrix();
  translate(person2X, y);
  scale(0.5); // Scale down the person
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
  arc(841.8, 590.2 + mouthMovement, 66.2, 26.9, radians(0), radians(180), CHORD); // Move mouth
  noStroke();
  fill(#1E1A17);
  quad(757.5, 530.1, 925.6, 530.1, 908.6, 488.2, 774.5, 488.2);
  ellipse(841.5, 494.5, 143.1, 70.9);
  fill(#525FE1);
  quad(790.2, 778.7, 841.5, 778.7, 835.6, 841.4, 784.8, 841.4);
  quad(841.5, 778.7, 891.2, 778.7, 896.5, 841.4, 843.3, 841.4);
  fill(#34A853);  // Warna baju baru
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

void updatePersonPositions() {
  float center = width / 2;
  if (person1X > center - 50) { // Stop Person1 next to Person2
    person1X -= personSpeed;
  }
  if (person2X > center + 50) { // Stop Person2 next to Person1
    person2X -= personSpeed;
  }
  if (person1X <= center - 50 && person2X <= center + 50) {
    personsMet = true;
  }
}
