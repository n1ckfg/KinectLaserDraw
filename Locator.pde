class Locator {
  
  int numSamples = 16;
  ArrayList<PVector> samples;
  PVector cursor;
  float maxDist = 1000;
  
  Locator() {
    samples = new ArrayList<PVector>();
    cursor = new PVector(0,0,0);
  }
  
  Locator(int _numSamples) {
    numSamples = _numSamples;
    samples = new ArrayList<PVector>();
    cursor = new PVector(0,0,0);
  }
  
  void update() {
    float x = brightest.x;
    float y = brightest.y;
    float z = getZ(depthImg.pixels, brightest.x, brightest.y, depthImg.width);
    PVector newSample = new PVector(x, y, z);
    if (samples.size() > 1) {
      PVector lastSample = samples.get(samples.size()-1);
      if (PVector.dist(newSample, lastSample) < maxDist) {
        samples.add(newSample);
      } else {
        clicked = false;
      }
    } else {
      samples.add(newSample);
    }
    if (samples.size() > numSamples) samples.remove(0);
    
    PVector sum = new PVector(0,0,0);
    for (PVector p : samples) {
      sum.add(p);
    }
    cursor = sum.div((float) numSamples);
  }
  
  void draw() {
    pushMatrix();
    translate(loc.cursor.x, loc.cursor.y, loc.cursor.z);
    fill(255);
    noStroke(); 
    sphere(10);
    popMatrix();
  }
  
  void run() {
    update();
    draw();
  }

  int getLoc(float x, float y, int w) {
    return int(x) + int(y) * w;
  }
  
  color getColor(color[] px, float x, float y, int w) {
    return px[getLoc(x, y, w)];
  }
  
  float getZ(color[] px, float x, float y, int w) {
    return red(px[getLoc(x, y, w)]) * 2;
  }

  PVector getPos(PVector[] points, float x, float y, int w) {
    return points[getLoc(x, y, w)];
  }

  float rawDepthToMeters(int depthValue) {
    if (depthValue < 2047) {
      return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
    }
    return 0.0;
  }
}
