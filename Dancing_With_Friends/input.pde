void mousePressed() {
  UIclicked(mouseX, mouseY);
}

void mouseDragged() {
  UIdragged(mouseX, mouseY);
}

void mouseReleased() {
  UIreleased(mouseX, mouseY);
}

void keyPressed() {
  if (key == ' ') {
    menuToggle.set = !menuToggle.set;
  } 
  else if (key == 's' || key == 'S') {
    saveNextFrame = true;
  }
  else if (key == 'r' || key == 'R') {
    randomiseSettings();
  }
}

