Toggle menuToggle, blurToggle, edgeToggle, circleF1Toggle, circleF2Toggle, circleE1Toggle, circleE2Toggle;
Slider g, sf1, sf2, se1, se2, rslider, velSlider, dampingSlider, activeSlider, 
circularF1Slider, circularF2Slider, circularE1Slider, circularE2Slider;

final static color DEFAULTEDGE = 0x88888888;
final static color DEFAULTBAR = 0x88FFFFFF;

void initUI() {
  menuToggle = new Toggle(50, 30, 10, 10);
  sf1 = new Slider(50, 80, 400, 20);
  sf2 = new Slider(50, 130, 400, 20);
  se1 = new Slider(50, 180, 400, 20);
  se2 = new Slider(50, 230, 400, 20);
  g = new Slider(50, 280, 400, 20);
  rslider = new Slider(50, 330, 400, 20);
  velSlider = new Slider(50, 380, 400, 20);
  dampingSlider = new Slider(50, 430, 400, 20);
  activeSlider = new Slider(50, 480, 400, 20);
  blurToggle = new Toggle(50, 530, 20, 20);
  edgeToggle = new Toggle(200, 530, 20, 20);
  circleF1Toggle = new Toggle(50, 580, 20, 20);
  circleE1Toggle = new Toggle(200, 580, 20, 20);
  circleF2Toggle = new Toggle(500, 580, 20, 20);
  circleE2Toggle = new Toggle(700, 580, 20, 20);
  circularF1Slider = new Slider(50, 630, 400, 20);
  circularE1Slider = new Slider(50, 680, 400, 20);
  circularF2Slider = new Slider(500, 630, 400, 20);
  circularE2Slider = new Slider(500, 680, 400, 20);

  //  sf1.val = 0.2;
  //  sf2.val = 0.0;
  //  se1.val = 0.1;
  //  se2.val = 0.0;
  //  g.val = 0.001;
  //  rslider.val = 0.01;
  //  velSlider.val = 1.0;
  //  dampingSlider.val = 0.0;
  //  //activeSlider.val = activeFollowers/(float)followers.length;
  //  blurToggle.set = false;
  //  edgeToggle.set = true;
  //  circleFToggle.set = false;
  //  circleEToggle.set = false;
  //  circularFSlider.val = 0.0;
  //  circularESlider.val = 0.0;

  randomiseSettings();

  menuToggle.setLabel("Show menu");
  sf1.setLabel("Friend 1 stepsize");
  sf2.setLabel("Friend 2 stepsize");
  se1.setLabel("Enemy 1 stepsize");
  se2.setLabel("Enemy 2 stepsize");
  g.setLabel("Step to centre");
  rslider.setLabel("Odds of changing contacts");
  velSlider.setLabel("Velocity amplification");
  dampingSlider.setLabel("Velocity damping");
  activeSlider.setLabel("Active particles");
  blurToggle.setLabel("Blur-fading");
  edgeToggle.setLabel("Randomise on edges");
  circleF1Toggle.setLabel("Circular Friend 1");
  circleE1Toggle.setLabel("Circular Enemy 1");
  circleF2Toggle.setLabel("Circular Friend 2");
  circleE2Toggle.setLabel("Circular Enemy 2");
  circularF1Slider.setLabel("Circular Friend 1 Offset");
  circularE1Slider.setLabel("Circular Enemy 1 Offset");
  circularF2Slider.setLabel("Circular Friend 2 Offset");
  circularE2Slider.setLabel("Circular Enemy 2 Offset");
}

// In the vast majority of the cases, this leads to noise instead of interesting patterns
void randomiseSettings() {
  sf1.val = random(1);
  sf2.val = random(1);
  se1.val = random(1);
  se2.val = random(1);
  g.val = random(1);
  rslider.val = random(1);
  velSlider.val = random(1);
  dampingSlider.val = random(1);
  edgeToggle.set = random(1) > 0.5;

  circleF1Toggle.set = random(1) > 0.5;
  circleE1Toggle.set = random(1) > 0.5;
  circleF2Toggle.set = random(1) > 0.5;
  circleE2Toggle.set = random(1) > 0.5;

  circularF1Slider.val = random(1);
  circularE1Slider.val = random(1);
  circularF2Slider.val = random(1);
  circularE2Slider.val = random(1);
}

void drawUI() {
  if (saveNextFrame && !menuToggle.set) {
    saveFrame("###########.png");
    saveNextFrame = false;
  }
  menuToggle.draw();
  if (menuToggle.set) {
    sf1.draw(0, 10);
    sf2.draw(0, 10);
    se1.draw(0, 10);
    se2.draw(0, 10);
    g.draw(0, 0.1);
    rslider.draw(0, 0.1);
    velSlider.draw(0, 10);
    dampingSlider.draw();
    activeSlider.draw(0, totalFollowers);
    blurToggle.draw();
    edgeToggle.draw();
    circleF1Toggle.draw();
    circleE1Toggle.draw();
    circleF2Toggle.draw();
    circleE2Toggle.draw();
    circularF1Slider.draw(0, activeFollowers);
    circularE1Slider.draw(0, activeFollowers);
    circularF2Slider.draw(0, activeFollowers);
    circularE2Slider.draw(0, activeFollowers);
    text("Press 's' for a screenshot\n\nPress 'r' to randomise settings", 550, 80);
    if (saveNextFrame) {
      saveFrame("###########.png");
      saveNextFrame = false;
    }
  }
}

void UIclicked(int x, int y) {
  menuToggle.clicked(x, y);
  if (menuToggle.set) {
    sf1.clicked(x, y);
    sf2.clicked(x, y);
    se1.clicked(x, y);
    se2.clicked(x, y);
    g.clicked(x, y);
    rslider.clicked(x, y);
    velSlider.clicked(x, y);
    dampingSlider.clicked(x, y);
    activeSlider.clicked(x, y);
    blurToggle.clicked(x, y);
    edgeToggle.clicked(x, y);
    if (circleF1Toggle.clicked(x, y) || 
      circleE1Toggle.clicked(x, y) ||
      circleF2Toggle.clicked(x, y) || 
      circleE2Toggle.clicked(x, y) || 
      circularF1Slider.clicked(x, y) ||
      circularE1Slider.clicked(x, y) ||
      circularF2Slider.clicked(x, y) ||
      circularE2Slider.clicked(x, y)) {
      randomiseContacts();
    }
  }
}

void UIdragged(int x, int y) {
  if (menuToggle.set) {
    sf1.dragged(x, y);
    sf2.dragged(x, y);
    se1.dragged(x, y);
    se2.dragged(x, y);
    g.dragged(x, y);
    rslider.dragged(x, y);
    velSlider.dragged(x, y);
    dampingSlider.dragged(x, y);
    activeSlider.dragged(x, y);
    if (circularF1Slider.dragged(x, y) ||
      circularF2Slider.dragged(x, y) ||
      circularE1Slider.dragged(x, y) || 
      circularE2Slider.dragged(x, y)) {
      randomiseContacts();
    }
  }
}

void UIreleased(int x, int y) {
  if (menuToggle.set) {
    if (activeSlider.pressed) {
      activeSlider.pressed = false;
      activeFollowers = (int)(activeSlider.val*followers.length);
      randomiseContacts();
    }
  }
}

//==================================================================================
//==================================================================================

class Toggle {
  Rect r;
  boolean set;
  color edge, bar;
  String label;
  int direction;

  Toggle(float x, float y, float w, float h, color e, color b) {
    r = new Rect(x, y, x+w, y+h);
    edge = e;
    bar = b;
    set = false;
    direction = RIGHT;
  }

  Toggle(float x, float y, float w, float h) {
    r = new Rect(x, y, x+w, y+h);
    edge = DEFAULTEDGE;
    bar = DEFAULTBAR;
    set = false;
    direction = RIGHT;
  }

  Toggle(Rect r0) {
    r = new Rect(r0);
    edge = DEFAULTEDGE;
    bar = DEFAULTBAR;
    set = false;
    direction = RIGHT;
  }

  void setLabel(String n) {
    label = n;
  }

  boolean clicked(float x, float y) {
    if (r.overlaps(x, y)) {
      set = !set;
      return true;
    }
    return false;
  }

  void draw() {
    fill(bar);
    if (label != null) {
      switch(direction) {
      case UP:
        text(label, r.Min.x, r.Min.y-10);
        break;
      case RIGHT:
        text(label, r.Max.x+10, r.Min.y+10);
        break;
      case DOWN:
        text(label, r.Min.x, r.Max.y + 10);
        break;
      case LEFT:
        text(label, r.Min.x-textWidth(label)-10, r.Min.y+10);
        break;
      }
    } 
    if (!set) {
      fill(edge);
    } 
    rect((int)r.Min.x, (int)r.Min.y, (int)r.DX(), (int)r.DY());
  }

  void draw(PGraphics pg) {    
    pg.fill(bar);
    if (label != null) {
      switch(direction) {
      case UP:
        pg.text(label, r.Min.x, r.Min.y-10);
        break;
      case RIGHT:
        pg.text(label, r.Max.x+10, r.Min.y+10);
        break;
      case DOWN:
        pg.text(label, r.Min.x, r.Max.y + 10);
        break;
      case LEFT:
        pg.text(label, r.Min.x-textWidth(label)-10, r.Min.y+10);
        break;
      }
    } 
    if (!set) {
      pg.fill(edge);
    } 
    rect((int)r.Min.x, (int)r.Min.y, (int)r.DX(), (int)r.DY());
  }
}

class Slider {
  Rect r;
  int direction;
  color edge, bar;
  float val;
  boolean pressed;
  String label;

  Slider(float x, float y, float w, float h, int dir, color e, color b) {
    r = new Rect(x, y, x+w, y+h);
    direction = dir;
    edge = e;
    bar = b;
    pressed = false;
  }

  Slider(Rect r0, int dir, color e, color b) {
    r = new Rect(r0);
    direction = dir;
    edge = e;
    bar = b;
    pressed = false;
  }

  Slider(float x, float y, float w, float h, int dir) {
    r = new Rect(x, y, x+w, y+h);
    direction = dir;
    edge = DEFAULTEDGE;
    bar = DEFAULTBAR;
    pressed = false;
  }

  Slider(Rect r0, int dir) {
    r = new Rect(r0);
    direction = dir;
    edge = DEFAULTEDGE;
    bar = DEFAULTBAR;
    pressed = false;
  }

  Slider(float x, float y, float w, float h) {
    r = new Rect(x, y, x+w, y+h);
    direction = RIGHT;
    edge = DEFAULTEDGE;
    bar = DEFAULTBAR;
    pressed = false;
  }

  Slider(Rect r0) {
    r = new Rect(r0);
    direction = RIGHT;
    edge = DEFAULTEDGE;
    bar = DEFAULTBAR;
    pressed = false;
  }

  void setLabel(String n) {
    label = n;
  }

  boolean clicked(float x, float y) {
    pressed = r.overlaps(x, y);
    if (pressed) {
      if (direction == LEFT || direction == RIGHT) {
        if (direction == RIGHT) {
          x = x - r.Min.x;
        } 
        else {
          x = r.Max.x - x;
        }
        val = x/r.DX();
      }
      else if (direction == UP) {
        y = r.Max.y - y;
        val = y/r.DY();
      } 
      else {
        y = y - r.Min.y;
        val = y/r.DY();
      }
    }
    return pressed;
  }

  boolean dragged(float x, float y) {
    if (pressed) {
      if (direction == LEFT || direction == RIGHT) {
        if (direction == RIGHT) {
          x = x - r.Min.x;
        } 
        else {
          x = r.Max.x - x;
        }
        val = min(1.0, max(0.0, x/r.DX()));
      }
      else if (direction == UP) {
        y = r.Max.y - y;
        val = min(1.0, max(0.0, y/r.DY()));
      } 
      else {
        y = y - r.Min.y;
        val = min(1.0, max(0.0, y/r.DY()));
      }
      return true;
    }
    return false;
  }

  void draw(float offset, float factor) {
    noStroke();
    fill(edge);
    rect((int)r.Min.x, (int)r.Min.y, (int)r.DX(), (int)r.DY());
    fill(bar);
    switch(direction) {
    case RIGHT:
      rect((int)r.Min.x, (int)r.Min.y, (int)(r.DX()*val), (int)r.DY());
      break;
    case LEFT:
      rect((int)(r.Min.x + r.DX() * (1-val)), (int)r.Min.y, (int)(r.DX()*val), (int)r.DY());
      break;
    case UP:
      rect((int)r.Min.x, (int)(r.Min.y+r.DY()*(1-val)), (int)r.DX(), (int)(r.DY()*val));
      break;
    case DOWN:
      rect((int)r.Min.x, (int)r.Min.y, (int)r.DX(), (int)(r.DY()*val));
      break;
    }
    if (label != null) {
      text(label + "  " + ((val + offset)*factor), r.Min.x, r.Min.y-10);
    } 
    else {
      text(((val + offset)*factor), r.Min.x, r.Min.y-10);
    }
  }

  void draw() {
    draw(0, 1);
  }

  void draw(PGraphics pg, float offset, float factor) {
    pg.noStroke();
    pg.fill(edge);
    pg.rect((int)r.Min.x, (int)r.Min.y, (int)r.DX(), (int)r.DY());
    pg.fill(bar);
    switch(direction) {
    case RIGHT:
      pg.rect((int)r.Min.x, (int)r.Min.y, (int)(r.DX()*val), (int)r.DY());
      break;
    case LEFT:
      pg.rect((int)(r.Min.x+r.DX()*(1-val)), (int)r.Min.y, (int)(r.DX()*val), (int)r.DY());
      break;
    case UP:
      pg.rect((int)r.Min.x, (int)(r.Min.y+r.DY()*(1-val)), (int)r.DX(), (int)(r.DY()*val));
      break;
    case DOWN:
      pg.rect((int)(r.Min.x), (int)(r.Min.y), (int)(r.DX()), (int)(r.DY()*val));
      break;
    }
    if (label != null) {
      pg.text(label + "  " + ((val + offset)*factor), r.Min.x, r.Min.y-10);
    } 
    else {
      pg.text(((val + offset)*factor), r.Min.x, r.Min.y-10);
    }
  }

  void draw(PGraphics pg) {
    draw(pg, 0, 1);
  }
}

class Rect {
  PVector Min, Max;

  public Rect() {
    Min = new PVector();
    Max = new PVector();
  }

  public Rect(float xmin, float ymin, float xmax, float ymax) {
    if (xmin > xmax) {
      float t = xmax;
      xmax = xmin;
      xmin = t;
    }
    if (ymin > ymax) {
      float t = ymax;
      ymax = ymin;
      ymin = t;
    }
    Min = new PVector(xmin, ymin);
    Max = new PVector(xmax, ymax);
  }

  public Rect(Rect source) {
    Min = new PVector(source.Min.x, source.Min.y);
    Max = new PVector(source.Max.x, source.Max.y);
  }

  Rect intersect(Rect other) {
    float xmin = Min.x > other.Min.x ? Min.x : other.Min.x;
    float ymin = Min.y > other.Min.y ? Min.y : other.Min.y;
    float xmax = Max.x < other.Max.x ? Max.x : other.Max.x;
    float ymax = Max.y < other.Max.y ? Max.y : other.Max.y;
    if (xmax <= xmin || ymax <= ymin) {
      return new Rect(0, 0, 0, 0);
    }
    return new Rect(xmin, ymin, xmax, ymax);
  }

  public void add(PVector point) {
    Min.add(point);
    Max.add(point);
  }

  public void sub(PVector point) {
    Min.sub(point);
    Max.sub(point);
  }

  public void add(float x, float y) {
    Min.add(x, y, 0);
    Max.add(x, y, 0);
  }

  public void sub(float x, float y) {
    Min.sub(x, y, 0);
    Max.sub(x, y, 0);
  }

  public boolean overlaps(Rect other) {
    return Min.x < other.Max.x && Min.y <= other.Max.y && Max.x > other.Min.x && Max.y > other.Min.y;
  }

  public boolean overlaps(PVector point) {
    return point.x >= Min.x && point.x < Max.x && point.y >= Min.y && point.y < Max.y;
  }

  public boolean overlaps(float x, float y) {
    return x >= Min.x && x < Max.x && y >= Min.y && y < Max.y;
  }

  public float DX() {
    return Max.x - Min.x;
  }

  public float DY() {
    return Max.y - Min.y;
  }

  public void draw() {
    strokeWeight(3);
    stroke(240, 255);
    fill(30);
    rect((int)Min.x, (int)Min.y, (int)Max.x, (int)Max.y, 3);
  }
}

