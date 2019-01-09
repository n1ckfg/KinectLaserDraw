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
  
  int getLoc(float x, float y, int w) {
    return int(x) + int(y) * w;
  }
  
  color getColor(color[] px, float x, float y, int w) {
    return px[getLoc(x, y, w)];
  }
  
  float getZ(color[] px, float x, float y, int w) {
    return red(px[getLoc(x, y, w)]) * 2;
  }

  void run() {
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
  
}
