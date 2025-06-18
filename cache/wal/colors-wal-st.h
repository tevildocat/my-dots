const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#02141B", /* black   */
  [1] = "#5A5E64", /* red     */
  [2] = "#9A5E63", /* green   */
  [3] = "#757C83", /* yellow  */
  [4] = "#808289", /* blue    */
  [5] = "#9D9DA2", /* magenta */
  [6] = "#C1B9BD", /* cyan    */
  [7] = "#e2e0e1", /* white   */

  /* 8 bright colors */
  [8]  = "#9e9c9d",  /* black   */
  [9]  = "#5A5E64",  /* red     */
  [10] = "#9A5E63", /* green   */
  [11] = "#757C83", /* yellow  */
  [12] = "#808289", /* blue    */
  [13] = "#9D9DA2", /* magenta */
  [14] = "#C1B9BD", /* cyan    */
  [15] = "#e2e0e1", /* white   */

  /* special colors */
  [256] = "#02141B", /* background */
  [257] = "#e2e0e1", /* foreground */
  [258] = "#e2e0e1",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
