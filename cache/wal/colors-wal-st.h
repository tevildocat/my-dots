const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#121418", /* black   */
  [1] = "#6A736F", /* red     */
  [2] = "#798377", /* green   */
  [3] = "#848A7C", /* yellow  */
  [4] = "#7B8282", /* blue    */
  [5] = "#9FA295", /* magenta */
  [6] = "#CAC5B4", /* cyan    */
  [7] = "#e8e5de", /* white   */

  /* 8 bright colors */
  [8]  = "#a2a09b",  /* black   */
  [9]  = "#6A736F",  /* red     */
  [10] = "#798377", /* green   */
  [11] = "#848A7C", /* yellow  */
  [12] = "#7B8282", /* blue    */
  [13] = "#9FA295", /* magenta */
  [14] = "#CAC5B4", /* cyan    */
  [15] = "#e8e5de", /* white   */

  /* special colors */
  [256] = "#121418", /* background */
  [257] = "#e8e5de", /* foreground */
  [258] = "#e8e5de",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
