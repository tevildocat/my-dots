const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0a0e0f", /* black   */
  [1] = "#2B5B64", /* red     */
  [2] = "#20636E", /* green   */
  [3] = "#486D74", /* yellow  */
  [4] = "#217886", /* blue    */
  [5] = "#4C7B83", /* magenta */
  [6] = "#2A95A2", /* cyan    */
  [7] = "#a5c2c5", /* white   */

  /* 8 bright colors */
  [8]  = "#738789",  /* black   */
  [9]  = "#2B5B64",  /* red     */
  [10] = "#20636E", /* green   */
  [11] = "#486D74", /* yellow  */
  [12] = "#217886", /* blue    */
  [13] = "#4C7B83", /* magenta */
  [14] = "#2A95A2", /* cyan    */
  [15] = "#a5c2c5", /* white   */

  /* special colors */
  [256] = "#0a0e0f", /* background */
  [257] = "#a5c2c5", /* foreground */
  [258] = "#a5c2c5",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
