// Variabel untuk posisi awan
int cloud1X = -150;
int cloud2X = -180;
int cloud3X = -120;

float waveOffset = 0;
float boatX;
float boatY;

void setup() {
  fullScreen();
  smooth();
  boatX = width * 0.5;
  boatY = height * 0.6;
}

void draw() {
  background(135, 206, 235); // Warna langit biru muda

  // Gambar awan
  drawCloud1();
  drawCloud2();
  drawCloud3();
  
  // Update posisi awan
  cloud1X += 1;
  cloud2X += 1;
  cloud3X += 1;

  // Reset posisi awan saat keluar dari layar
  if (cloud1X > width + 150) cloud1X = -150;
  if (cloud2X > width + 180) cloud2X = -180;
  if (cloud3X > width + 120) cloud3X = -120;

  // Gambar laut
  drawSea();

  // Gambar kapal yang mengikuti ombak
  float waveHeight = map(sin(boatX * 0.05 + waveOffset), -1, 1, height * 0.8, height * 0.85);
  drawShip(boatX, waveHeight);

  // Update pergerakan laut
  waveOffset += 0.05;
}

// Fungsi untuk menggambar awan 1
void drawCloud1() {
  int y = 150;
  fill(255);  // Warna putih
  noStroke();
  
  // Badan utama awan
  ellipse(cloud1X, y, 180, 100);
  ellipse(cloud1X + 60, y + 20, 120, 80);
  ellipse(cloud1X - 60, y + 20, 120, 80);
  ellipse(cloud1X, y - 30, 140, 90);
  ellipse(cloud1X + 90, y - 10, 100, 60);
  ellipse(cloud1X - 90, y - 10, 100, 60);
}

// Fungsi untuk menggambar awan 2
void drawCloud2() {
  int y = 120;
  fill(255);  // Warna putih
  noStroke();
  
  // Badan utama awan
  ellipse(cloud2X, y, 200, 110);
  ellipse(cloud2X + 70, y + 30, 140, 90);
  ellipse(cloud2X - 70, y + 30, 140, 90);
  ellipse(cloud2X, y - 40, 160, 100);
  ellipse(cloud2X + 100, y - 20, 120, 70);
  ellipse(cloud2X - 100, y - 20, 120, 70);
}

// Fungsi untuk menggambar awan 3
void drawCloud3() {
  int y = 250;
  fill(255);  // Warna putih
  noStroke();
  
  // Badan utama awan
  ellipse(cloud3X, y, 160, 90);
  ellipse(cloud3X + 50, y + 20, 110, 70);
  ellipse(cloud3X - 50, y + 20, 110, 70);
  ellipse(cloud3X, y - 20, 130, 80);
  ellipse(cloud3X + 80, y - 10, 90, 50);
  ellipse(cloud3X - 80, y - 10, 90, 50);
}

void drawSea() {
  fill(0, 100, 200);
  beginShape();
  for (float x = 0; x <= width; x += 10) {
    float y = map(sin(x * 0.01 + waveOffset), -1, 1, height * 0.8, height * 0.85);
    vertex(x, y);
  }
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}

void drawShip(float x, float y) {
  // Faktor skala untuk memperbesar kapal
  float scale = 3.0;

  // Bagian bawah kapal
  fill(139, 69, 19); // Warna coklat
  beginShape();
  vertex(x - 60 * scale, y + 30 * scale);
  vertex(x + 60 * scale, y + 30 * scale);
  vertex(x + 40 * scale, y + 60 * scale);
  vertex(x - 40 * scale, y + 60 * scale);
  endShape(CLOSE);
  
  // Bagian tengah kapal
  fill(160, 82, 45); // Warna coklat lebih terang
  rect(x - 40 * scale, y - 20 * scale, 80 * scale, 40 * scale);

  // Tiang kapal
  fill(160, 82, 45);
  rect(x - 5 * scale, y - 80 * scale, 10 * scale, 100 * scale);

  // Layar kapal
  fill(255);
  triangle(x, y - 60 * scale, x + 60 * scale, y, x - 60 * scale, y);
  triangle(x, y - 40 * scale, x + 40 * scale, y, x - 40 * scale, y);

  // Bendera kapal
  fill(0);
  rect(x, y - 100 * scale, 50 * scale, 20 * scale);
  fill(255);
  ellipse(x, y - 100 * scale, 15 * scale, 15 * scale); // Gambar tengkorak sederhana

  // Jendela kapal
  fill(255);
  ellipse(x - 30 * scale, y + 30 * scale, 20 * scale, 20 * scale);
  ellipse(x, y + 30 * scale, 20 * scale, 20 * scale);
  ellipse(x + 30 * scale, y + 30 * scale, 20 * scale, 20 * scale);
}
