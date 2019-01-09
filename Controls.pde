void keyPressed() {
  if (keyCode == 33 || keyCode == 34) clicked = true;
}

void keyReleased() {
  if (keyCode == 33 || keyCode == 34) clicked = false;
  
  if (key == ' ') {
    strokes = new ArrayList<Stroke>();
    newStroke = new Stroke();
  }
}
