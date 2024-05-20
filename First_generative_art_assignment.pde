void setup() {
  size(800, 800);
  background(255);
  noLoop();
}

void drawTree(float startX, float startY, float initialAngle, float initialLength, float noiseOffset) {
  ArrayList<Branch> branches = new ArrayList<Branch>();
  branches.add(new Branch(startX, startY, initialAngle, initialLength, noiseOffset));

  while (!branches.isEmpty()) {
    Branch branch = branches.remove(branches.size() - 1);

    if (branch.length < 2) {
      continue;
    }

    float x2 = branch.x + cos(radians(branch.angle)) * branch.length;
    float y2 = branch.y + sin(radians(branch.angle)) * branch.length;

    float noiseValue = noise(branch.noiseOffset);
    color startColor = color(random(0, 255), random(0, 255), random(0, 255));
    color endColor = color(random(0, 255), random(0, 255), random(0, 255));
    stroke(lerpColor(startColor, endColor, noiseValue));

    strokeWeight(3);
    line(branch.x, branch.y, x2, y2);

    if (branch.length > 10) { // Control the number of branches
      branches.add(new Branch(x2, y2, branch.angle - 20, branch.length * 0.7, branch.noiseOffset + 0.1));
      branches.add(new Branch(x2, y2, branch.angle + 20, branch.length * 0.7, branch.noiseOffset + 0.2));
    }
  }
}



void draw() {
  background(255);

  int numTrees = 70;
  for (int i = 0; i < numTrees; i++) {
    float startX = random(0.1 * width, 0.9 * width);
    float startY = random(height);
    float initialAngle = random(-10, 10);
    float length = random(50, 100);
    float noiseOffset = random(1000);

    pushMatrix();
    translate(startX, startY);
    rotate(random(radians(initialAngle) + 20));
    drawTree(0, 0, -90, length, noiseOffset);
    popMatrix();
  }
}
