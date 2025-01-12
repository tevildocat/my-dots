static const char norm_fg[] = "#a5c2c5";
static const char norm_bg[] = "#0a0e0f";
static const char norm_border[] = "#738789";

static const char sel_fg[] = "#a5c2c5";
static const char sel_bg[] = "#20636E";
static const char sel_border[] = "#a5c2c5";

static const char urg_fg[] = "#a5c2c5";
static const char urg_bg[] = "#2B5B64";
static const char urg_border[] = "#2B5B64";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
