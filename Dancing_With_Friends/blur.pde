//These filters all work on the pixel array. Instead we are going to blur/fade the COUNTING array, which is much easier,
//and requires less computation.
/*
void blur(int[] s, int[] t, int w, int h) {
 int ym1ofs = (h-2) * w;
 int yofs = (h-1) * w;
 int yp1ofs = 0;
 for (int y=h; y-->0;) {
 int xm1ofs = w-2;
 int xofs = w-1;  
 int xp1ofs = 0;
 for (int x=w; x-->0;) {
 t[yofs+xofs] =
 (((((s[yofs + xofs] & 0x0000FF) << 2) + 
 (s[yofs+xp1ofs] & 0x0000FF) + 
 (s[yofs+xm1ofs] & 0x0000FF) + 
 (s[ym1ofs+xofs] & 0x0000FF) + 
 (s[yp1ofs+xofs] & 0x0000FF)) >>> 3)  & 0xFF) +
 (((((s[yofs + xofs] & 0x00FF00) << 2) + 
 (s[yofs+xp1ofs] & 0x00FF00) + 
 (s[yofs+xm1ofs] & 0x00FF00) + 
 (s[ym1ofs+xofs] & 0x00FF00) + 
 (s[yp1ofs+xofs] & 0x00FF00))  >>> 3)  & 0xFF00) +
 (((((s[yofs + xofs] & 0xFF0000) << 2) + 
 (s[yofs+xp1ofs] & 0xFF0000) + 
 (s[yofs+xm1ofs] & 0xFF0000) + 
 (s[ym1ofs+xofs] & 0xFF0000) + 
 (s[yp1ofs+xofs] & 0xFF0000)) >>> 3)  & 0xFF0000) +
 0xFF000000;
 xm1ofs = xofs;
 xofs = xp1ofs;
 xp1ofs++;
 }
 ym1ofs = yofs;
 yofs = yp1ofs;
 yp1ofs += w;
 }
 }
 
 void fade(int[]s, int[]t, int mul, int shift) {
 for (int i = 0; i < s.length; i++) {
 int r = (((s[i] & 0xFF0000)*mul) >> shift) & 0xFF0000;
 int g = (((s[i] & 0xFF00)*mul) >> shift) & 0xFF00;
 int b = (((s[i] & 0xFF)*mul) >> shift) & 0xFF;
 t[i] = 0xFF000000 + r + g + b;
 }
 }
 
 
 
 // dilate according to max brightness per channel, diamond shape
 void dilate(int[] s, int[] t, final int w, final int h) {
 int ym1ofs = (h-2) * w;
 int yofs = (h-1) * w;
 int yp1ofs = 0;
 int xm1ofs, xofs, xp1ofs, r, g, b;
 for (int y=h; y-->0;) {
 xm1ofs = w-2;
 xofs = w-1;
 xp1ofs = 0;
 for (int x=w; x-->0;) {
 
 if ((s[yofs+xofs] & 0x000000FF) > (s[yofs+xp1ofs] & 0x000000FF)) { b = s[yofs+xofs] & 0x000000FF; }
 else { b = s[yofs+xp1ofs] & 0x000000FF; }
 if (b < (s[yofs+xm1ofs] & 0x000000FF)) { b = s[yofs+xm1ofs] & 0x000000FF; }
 if (b < (s[yp1ofs+xofs] & 0x000000FF)) { b = s[yp1ofs+xofs] & 0x000000FF; }
 if (b < (s[ym1ofs+xofs] & 0x000000FF)) { b = s[ym1ofs+xofs] & 0x000000FF; }
 
 if ((s[yofs+xofs] & 0x0000FF00) > (s[yofs+xp1ofs] & 0x0000FF00)) { g = s[yofs+xofs] & 0x0000FF00; }
 else { g = s[yofs+xp1ofs] & 0x0000FF00; }
 if (g < (s[yofs+xm1ofs] & 0x0000FF00)) { g = s[yofs+xm1ofs] & 0x0000FF00; }
 if (g < (s[yp1ofs+xofs] & 0x0000FF00)) { g = s[yp1ofs+xofs] & 0x0000FF00; }
 if (g < (s[ym1ofs+xofs] & 0x0000FF00)) { g = s[ym1ofs+xofs] & 0x0000FF00; }
 
 if ((s[yofs+xofs] & 0x00FF0000) > (s[yofs+xp1ofs] & 0x00FF0000)) { r = s[yofs+xofs] & 0x00FF0000; }
 else { r = s[yofs+xp1ofs] & 0x00FF0000; }
 if (r < (s[yofs+xm1ofs] & 0x00FF0000)) { r = s[yofs+xm1ofs] & 0x00FF0000; }
 if (r < (s[yp1ofs+xofs] & 0x00FF0000)) { r = s[yp1ofs+xofs] & 0x00FF0000; }
 if (r < (s[ym1ofs+xofs] & 0x00FF0000)) { r = s[ym1ofs+xofs] & 0x00FF0000; }
 t[yofs+xofs] = 0xFF000000 + r + g + b;
 xm1ofs = xofs;
 xofs = xp1ofs;
 xp1ofs++;
 }
 ym1ofs = yofs;
 yofs = yp1ofs;
 yp1ofs += w;
 }
 }
 */

void blur(int[] s, int[] t, int w, int h) {
  int ym1ofs = (h-2) * w;
  int yofs = (h-1) * w;
  int yp1ofs = 0;
  for (int y=h; y-->0;) {
    int xm1ofs = w-2;
    int xofs = w-1;  
    int xp1ofs = 0;
    for (int x=w; x-->0;) {
      t[yofs+xofs] =
        ((s[yofs + xofs] * 32) + 
        (s[yofs + xp1ofs] + s[yofs + xm1ofs] + s[ym1ofs + xofs] + s[yp1ofs + xofs]) * 31 +
        (s[ym1ofs + xp1ofs] + s[yp1ofs + xp1ofs] + s[ym1ofs + xm1ofs] + s[yp1ofs + xm1ofs]) * 25 ) >>>  8;
      xm1ofs = xofs;
      xofs = xp1ofs;
      xp1ofs++;
    }
    ym1ofs = yofs;
    yofs = yp1ofs;
    yp1ofs += w;
  }
}

void fade(int[]s, int[]t, int mul, int shift) {
  for (int i = 0; i < s.length; i++) {
    t[i] = (s[i]*mul) >> shift;
  }
}

