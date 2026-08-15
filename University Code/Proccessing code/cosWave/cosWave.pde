void setup() {
  size(800, 400);
  noStroke();
}

float speed = 0;
int step = 8; // size + spacing

void draw() {
  // draw colored halves (covers the white background)
  fill(30, 30, 80);           // left: dark bluish
  rect(0, 0, width, height);


  // moving wave
  speed -= 0.5;
  for (int x = 0; x < width; x += step) {
    float wave = cos(radians(x) + speed) * 40;
    float yPos = height/2 + wave;
    fill(255);

    rect(x, yPos, step, step);
  }
}
