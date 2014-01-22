void initFollowers(int t) {
  followers = new Follower[t];
  for (int i = 0; i < followers.length; i++) {
    float angle = random(TAU);
    float r = random(min(width, height)/2);
    followers[i] = new Follower(r*cos(angle)+width/2, r*sin(angle)+height/2);
    //followers[i] = new Follower(random(width), random(height));
  }
  randomiseContacts();
}

void randomiseContacts() {
  for (int i = 0; i < activeFollowers; i++) {
    randomiseContact(i);
  }
}

void randomiseContact(int i) {
  Follower f = followers[i];
  int j = 0;
  int k = 0;
  int l = 0;
  int m = 0;
  int offsetF1 = (int)(circularF1Slider.val * activeFollowers);
  int offsetF2 = (int)(circularF2Slider.val * activeFollowers);
  int offsetE1 = (int)(circularE1Slider.val * activeFollowers);
  int offsetE2 = (int)(circularE2Slider.val * activeFollowers);

  if (circleF1Toggle.set) {
    j = (i + activeFollowers + offsetF1) % activeFollowers;
  } 
  else {
    do {
      j = (int)random(activeFollowers);
    } 
    while (i == j);
  }

  if (circleF2Toggle.set) {
    k = (i + activeFollowers + offsetF2) % activeFollowers;
  } 
  else {
    do {
      k = (int)random(activeFollowers);
    } 
    while (i == k || j == k);
  }

  if (circleE1Toggle.set) {
    l = (i + activeFollowers + offsetE1) % activeFollowers;
  } 
  else {
    do {
      l = (int)random(activeFollowers);
    } 
    while (i == l || j == l || k == l);
  }

  if (circleE2Toggle.set) {
    m = (i + activeFollowers + offsetE2) % activeFollowers;
  } 
  else {
    do {
      m = (int)random(activeFollowers);
    } 
    while (i == m || j == m || k == m || l == m);
  }

  f.friend = followers[j];
  f.friend2 = followers[k];
  f.enemy = followers[l];
  f.enemy2 = followers[m];
}

class Follower {
  float x, vx, y, vy;
  Follower friend, friend2, enemy, enemy2;

  Follower(float _x, float _y) {
    x = _x;
    y = _y;
    vx = vy = 0;
  }

  void stepTo(float tx, float ty, float stepsize) {
    float angle = atan2(ty - y, tx - x);
    vx += stepsize*cos(angle);
    vy += stepsize*sin(angle);
  }

  void stepTo(Follower f, float stepsize) {
    stepTo(f.x, f.y, stepsize);
  }

  void stepToFraction(float tx, float ty, float fraction) {
    x = (x*(1-fraction) + tx*fraction);
    y = (y*(1-fraction) + ty*fraction);
  }

  void stepToFraction(Follower f, float fraction) {
    stepToFraction(f.x, f.y, fraction);
  }

  void dampVelocity(float damping) {
    vx *= damping;
    vy *= damping;
  }

  void applyVelocity(float factor) {
    x += vx*factor;
    y += vy*factor;
  }
}

