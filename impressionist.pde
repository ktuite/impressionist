PImage img;

void setup() {
  size(506, 746); 
  background(0, 0, 0);

  img = loadImage("http://cuteoverload.files.wordpress.com/2013/03/rqrdaw7.jpg?w=560&h=746");
  image(img, 0, 0);

  fill(255, 255, 255, 230);
  noStroke();
  rect(0, 0, width, height);
}

void draw() {
}


void mouseDragged() {
  //lots_of_squares();
  //speed_square();
  bubbles();
  //circle();
  //brushy();
  //colored_pencil();
  //paint_stroke();
}

void circle() {
  color c = img.get(mouseX, mouseY);
  stroke(c, 100);
  strokeWeight(20);
  line(mouseX, mouseY, mouseX + 20,  mouseY + 20);

}

void bubbles() {
  color c = img.get(mouseX, mouseY);
  fill(c, 50); // the 50 is an "alpha" value that makes the color kind of transparent... range: 0-255 
  stroke(255); // give it a white border!
  float radius = random(10, 40);
  float r_x = random(-20, 20);
  float r_y = random(-20, 20);
  for (int i = 0; i < 5; i++) {
    ellipse(mouseX + r_x, mouseY + r_y, radius, radius);
  }
}

void speed_square() {
  // move fast to make squares large
  float weight = dist(mouseX, mouseY, pmouseX, pmouseY);
  println("weight: " + weight);
  float s = random(5, weight);

  color c = img.get(mouseX, mouseY);
  fill(c);
  rect(mouseX, mouseY, s, s);
}

void lots_of_squares() {
  int s = 10;
  float weight = dist(mouseX, mouseY, pmouseX, pmouseY);

  for (int i = 0; i < weight; i++) {
    int x = mouseX + (int)random(-40, 40);
    int y = mouseY + (int)random(-40, 40);
    color c = img.get(x, y);
    fill(c);
    rect(x, y, 10, 10);
  }
}

void paint_stroke() {
  float weight = dist(mouseX, mouseY, pmouseX, pmouseY);
  color c = img.get(mouseX, mouseY);
  strokeWeight(weight);
  stroke(c);
  line(mouseX, mouseY, pmouseX, pmouseY);
}

void brushy() {
  int min_size = 5;
  float weight = dist(mouseX, mouseY, pmouseX, pmouseY);
  println("weight: " + weight);

  for (int i = 0; i < 10; i ++) {
    int radius = (int)weight;
    int ellipse_radius = (int)random(radius) + min_size;
    float mouse_offset_x = random(-20, 20);
    float mouse_offset_y = random(-20, 20);
    int x = mouseX + (int)mouse_offset_x;
    int y = mouseY + (int)mouse_offset_y;
    float width = weight/2;
    color c = img.get(x, y);
    float alph = 500/weight + 20;
    stroke(c, alph);
    strokeWeight(weight);
    line(mouseX + mouse_offset_x, mouseY + mouse_offset_y, pmouseX + mouse_offset_x, pmouseY + mouse_offset_y);
  }
}

void colored_pencil() {
  int min_size = 5;
  float weight = dist(mouseX, mouseY, pmouseX, pmouseY);
  println("weight: " + weight);
  for (int i = 0; i < 50; i ++) {
    int spread = (int)constrain(weight, 10, 70);
    if (i >= spread)
      break;

    int radius = (int)weight;
    int ellipse_radius = (int)random(radius) + min_size;
    float mouse_offset_x = random(-1 * spread, spread);
    float mouse_offset_y = random(-1 * spread, spread);
    int x = mouseX + (int)mouse_offset_x;
    int y = mouseY + (int)mouse_offset_y;
    color c = img.get(x, y);
    stroke(c, 155);
    line(mouseX + mouse_offset_x, mouseY + mouse_offset_y, pmouseX + mouse_offset_x, pmouseY + mouse_offset_y);
  }
}


color computeColor(int x, int y) {
  color c = img.get(x, y);
  float b = brightness(c);
  float h = hue(c);
  float s = saturation(c);

  int mode = 0;

  if (mode == 0) {
    colorMode(RGB);
  }
  else if (mode == 1) {
    colorMode(HSB);
    c = color(0, 0, b);
  }
  else if (mode == 2) {
    colorMode(HSB); // more saturated
    c = color(h, s + 40, b);
  }
  else if (mode == 3) {
    colorMode(HSB);
    if (h > 30) // only reddish stuff
      s = 0;
    c = color(h, s, b);
  }
  else if (mode == 4) {
    println("hue: " + h);
    colorMode(HSB);
    if (h > 60 || h < 30) // only greenish stuff
      s = 0;
    c = color(h, s, b);
  }
  else if (mode == 5) {
    println("hue: " + h);
    colorMode(HSB);
    if (h > 170 || h < 120) // only blueish stuff
      s = 0;
    c = color(h, s, b);
  }
  return c;
}

