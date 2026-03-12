static const char norm_fg[] = "#e8e5de";
static const char norm_bg[] = "#121418";
static const char norm_border[] = "#a2a09b";

static const char sel_fg[] = "#e8e5de";
static const char sel_bg[] = "#798377";
static const char sel_border[] = "#e8e5de";

static const char urg_fg[] = "#e8e5de";
static const char urg_bg[] = "#6A736F";
static const char urg_border[] = "#6A736F";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
