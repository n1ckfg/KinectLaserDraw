import peasy.PeasyCam;

PeasyCam cam;

float dotSize = 20;
Locator loc = new Locator(4);
ArrayList<Stroke> strokes;
Stroke newStroke;
boolean clicked = false;
boolean isDrawing = false;

void setup() {
  size(640, 480, P3D);
  cam =  new PeasyCam(this, width/2, height/2, 400, 50);
  strokes = new ArrayList<Stroke>();
  newStroke = new Stroke();
  setupKinect();
  setupOpenCV();
}

void draw() {
  updateKinect();
  updateOpenCV();
  
  background(0);
  image(rgbImg, 0, 0);
  
  lights();
  
  loc.run();
  
  if (clicked && !isDrawing) {
    isDrawing = true;
    newStroke.points.add(loc.cursor);
    newStroke.draw();
  } else if (clicked && isDrawing) {
    newStroke.points.add(loc.cursor);  
    newStroke.draw();
  } else if (!clicked && isDrawing) {
    isDrawing = false;
    strokes.add(newStroke);
    newStroke = new Stroke();
  }
    
  for (Stroke s : strokes) {
    s.draw();
  }
  
  surface.setTitle("" + frameRate);
}
