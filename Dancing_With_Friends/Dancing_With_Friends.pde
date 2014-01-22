// Based on this algorithm:
// http://community.wolfram.com/groups/-/m/t/122095

import java.util.Arrays;

int activeFollowers, totalFollowers;

Follower[] followers;
int[] blurFilter;
boolean saveNextFrame;

void setup() {
  size(1280, 720);
  frameRate(60);
  activeFollowers = 2000;
  totalFollowers = 10000;
  initUI();
  initFollowers(totalFollowers);
  activeSlider.val = activeFollowers/(float)followers.length;

  background(0);
  loadPixels();

  blurFilter = new int[width*height];

  saveNextFrame = false;
  noSmooth();
}

final static int wf = 4;
final static int hf = 3;
void draw() {
  int maxCount = 0;
  swarm(followers, activeFollowers);
  if (!blurToggle.set) {
    Arrays.fill(blurFilter, 0);
  }

  // We want to set the brightness according to Follower density per pixel
  // and we can have thousands of Followers overlapping in one pixel.
  // Using FPM, we first we add 0x100 per Follower to every pixel
  for (int i = 0; i < activeFollowers; i++) {
    Follower f = followers[i];
    int x = (int)f.x;
    int y = (int)f.y;
    if (x >= 0 && x < width && y >= 0 && y < height) {
      int c = blurFilter[x + width*y] + 0x100;
      blurFilter[x + width*y] = c;

      //also keep count maximum value of the blurField, to normalise later on.
      if (c > maxCount) {
        maxCount = c;
      }
    }
  }

  // Linear scaling of brightness doensn't work - we want to be able to distinguish from 1 to 100000 Followers
  float mv = 1/sqrt(sqrt(maxCount));
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int v = blurFilter[x + y*width];
      if (v > 0) {
        v = (int)(0xFF*sqrt(sqrt(v))*mv);
        pixels[x + y*width] = 0xFF000000 + v*0x10101;
      }
    }
  }
  updatePixels();

  // By blurring over time, both the path and the density of the Followers
  // is easier to distinguish
  if (blurToggle.set) {
    blur(blurFilter, pixels, width, height);
    fade(pixels, blurFilter, 15, 4);
    //arrayCopy(pixels, blurFilter);
  }
  Arrays.fill(pixels, 0xFF000000);

  drawUI();
}


void swarm(Follower[] flwrs, int imax) {
  for (int i = 0; i < imax; i++) {
    Follower f = flwrs[i];
    f.stepTo(f.enemy, 10*(-se1.val));
    f.stepTo(f.enemy2, 10*(-se2.val));
    f.stepTo(f.friend, 10*(sf1.val));
    f.stepTo(f.friend2, 10*sf2.val);
  }
  for (int i = 0; i < imax; i++) {
    Follower f = flwrs[i];
    f.stepToFraction(width/2, height/2, 0.1*g.val);
    f.applyVelocity(velSlider.val*10);
    f.dampVelocity(dampingSlider.val);

    if (edgeToggle.set) {
      if (random(1) < rslider.val*0.1 || f.x < 0 || f.x >= width || f.y < 0 || f.y >= height) {
        randomiseContact(i);
      }
    } 
    else {
      if (random(1) < rslider.val*0.1) {
        randomiseContact(i);
      }

      if (f.x < 0) {
        f.x += width;
      } 
      else if (f.x >= width) {
        f.x -= width;
      }

      if (f.y < 0) {
        f.y += height;
      } 
      else if (f.y >= height) {
        f.y -= height;
      }
    }
  }
}

