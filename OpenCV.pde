import gab.opencv.*;

OpenCV opencv;
int thresh = 1;
ArrayList<Contour> contours;
PVector brightest = new PVector(0,0);

void setupOpenCV() { 
  opencv = new OpenCV(this, rgbImg);  
  contours = new ArrayList<Contour>();
}

void updateOpenCV() {
  opencv.loadImage(rgbImg);
  opencv.gray();
  opencv.threshold(thresh);
  contours = opencv.findContours();
  if (contours.size() > 0) {
    Contour contour = contours.get(0);
    brightest.x = (float) contour.getBoundingBox().getCenterX();
    brightest.y = (float) contour.getBoundingBox().getCenterY();
  }
}
