static const char norm_fg[] = "#e2e0e1";
static const char norm_bg[] = "#02141B";
static const char norm_border[] = "#9e9c9d";

static const char sel_fg[] = "#e2e0e1";
static const char sel_bg[] = "#9A5E63";
static const char sel_border[] = "#e2e0e1";

static const char urg_fg[] = "#e2e0e1";
static const char urg_bg[] = "#5A5E64";
static const char urg_border[] = "#5A5E64";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
