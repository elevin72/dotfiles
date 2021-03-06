/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>
/* appearance */
static const unsigned int borderpx = 3; /* border pixel of windows */
static const Gap default_gap = {.isgap = 1, .realgap = 10, .gappx = 10};
static const unsigned int snap = 32; /* snap pixel */
static const int showbar = 1;        /* 0 means no bar */
static const int topbar = 1;         /* 0 means bottom bar */
static const int splitstatus = 0;    /* 1 for split status items */
static const char *splitdelim = ";"; /* Character used for separating status */
/* static const char *fonts[]          = { "Ubuntu
 * :style=Regular:size=12:antialias=true:autohint=true", "UbuntuMono Nerd Font
 * Mono:style=Book:size=20:antialias=true:autohint=true" }; */
/* static const char *fonts[]          = { "Ubuntu Nerd
 * Font:style=Book:size=12:antialias=true:autohint=true", "Noto
 * Sans:style=Regular" }; */
/* static const char *fonts[]          = {"Noto Color Emoji:style=Regular","Noto
 * Sans:style=Regular" }; */
static const char *fonts[] = {
    "Ubuntu Nerd Font:style=Book:size=12:antialias=true:autohint=true",
    "Noto Color Emoji:style=Regular"};
static const char dmenufont[] = "Ubuntu Nerd Font:style=Book,regular:size=13";
static const char col_gray1[] = "#3c3836";
static const char col_gray2[] = "#83a598";
static const char col_gray3[] = "#d5c4a1";
static const char col_gray4[] = "#8ec07c";
static const char col_cyan[] = "#8f3f71";
static const char *colors[][3] = {
    /*               fg         bg         border   */
    [SchemeNorm] = {col_gray3, col_gray1, col_gray2},
    [SchemeSel] = {col_gray4, col_gray1, col_cyan},
};

/* tagging */
static const char *tags[] = {"  ", "  ","  ","  ", "  "," ﭮ  ", " 0 ", " 1 "," 2 "};
static const char *alttags[] = {"  ", "  ","  ","  ", "  "," ﭮ  ", " 0 ", " 1 "," 2 "}; // alt-decorations
static const char *tagsalt[] = {" 1 "," 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "}; // alt tags
static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    // the order of these attributes is defined in struct Rules
    /* class     instance  title           tags mask  isfloating
       isfakefullscreen  isterminal  noswallow   monitor */
    /* { "Gimp",    NULL,     NULL,           0,         1,            0, 0,
       0,       -1 }, */
    {"Brave", NULL, NULL, 1 << 1, 0, 0, 0, 0, -1},
    {"discord", NULL, NULL, 1 << 5, 0, 0, 0, 0, -1},
    {"St", NULL, NULL, 0, 0, 0, 0, 0, -1},
    {"Alacritty", NULL, NULL, 0, 0, 0, 1, 0, -1},
    {"zoom", NULL, NULL, 0, 0, 1, 0, 0, -1},
    {NULL, NULL, "Event Tester", 0, 0, 0, 0, 0, -1}, /* xev */
};
/* layout(s) */
static const float mfact = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;   /* number of clients in master area */
static const int resizehints =
    1; /* 1 means respect size hints in tiled resizals */

#include "layouts.c"
static const Layout layouts[] = {
    /* symbol     arrange function */
    {"",   tile },     /* first entry is default */
    {"﯑",   NULL },    /*no layout function means floating behavior */
    {"",   monocle},
    {"ﱖ",   grid }
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }
/* commands */
static char dmenumon[2] =
    "0"; /* component of dmenucmd, manipulated in spawn() */
static char priorityapps[] =
    "discord,brave,code,code-oss,thunar,pavucontrol,nvidia-settings,filelight,blueman-manager,steam,gnome-control-center"; /* Apps here get priority in dmenu */
static const char *dmenucmd[] = {
    "dmenu_run",
    "-m",
    dmenumon,
    "-c",
    "-hp",
    priorityapps,
    /*"-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan,
       "-sf", col_gray4,*/
    NULL};
static const char *termcmd[] = {"kitty", NULL};
static const char *browser[] = {"brave", NULL};
static const char *filebrowser[] = {"thunar", NULL};
static const char *discord[] = {"discord", NULL};
static const char *layoutmenu_cmd = "layoutmenu.sh";
static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = {"st", "-t",     scratchpadname,
                                      "-g", "120x34", NULL};

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_w,      spawn,          {.v = browser } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_v,      spawn,          {.v = filebrowser } },
	{ MODKEY,                       XK_s,      spawn,          {.v = discord } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_h,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_l,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,      setcfact,       {.f = +0.25} },
	{ MODKEY|ShiftMask,             XK_k,      setcfact,       {.f = -0.25} },
	/* { MODKEY|ShiftMask,             XK_o,      setcfact,       {.f =  0.00} }, */ //delete me
	{ MODKEY|ShiftMask,             XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,             XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_o,      incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_minus,  setgaps,        {.i = GAP_RESET } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = GAP_TOGGLE} },
	{ MODKEY,                       XK_n,      togglealttag,   {0} },
	/* { MODKEY,                       XK_p,      spawn,          SHCMD("sudo /home/eli/.local/bin/backlightToggle") }, */
	/* { Mod1Mask,                     XK_space, spawn,  SHCMD("keyboardToggle; kill -43 $(pidof dwmblocks)") }, */
	{ Mod1Mask,                     XK_space, spawn,  SHCMD("/home/eli/.local/bin/keyboardToggle; kill -43 $(pidof dwmblocks)") },
	{ 0,                            XK_Print, spawn,  SHCMD("/home/eli/.local/bin/screenshot") },
	{ 0,                            XF86XK_AudioLowerVolume, spawn,  SHCMD("pamixer --allow-boost -d 3; kill -44 $(pidof dwmblocks)") },
	{ 0,                            XF86XK_AudioRaiseVolume, spawn,  SHCMD("pamixer --allow-boost -i 3; kill -44 $(pidof dwmblocks)") },
	{ 0,                            XF86XK_AudioMute , spawn,  SHCMD("pamixer -t; kill -44 $(pidof dwmblocks)") },
	{ 0,                            XF86XK_MonBrightnessDown, spawn,  SHCMD("brightnessctl s 8%-") },
	{ 0,                            XF86XK_MonBrightnessUp, spawn,  SHCMD("brightnessctl s +8%") },
    { 0,                            XF86XK_Tools, spawn, SHCMD("gromit-mpx -a") }, // F9
    { MODKEY,                       XF86XK_Tools, spawn, SHCMD("killall gromit-mpx") },
	/* { MODKEY,                       XF86XK_MonBrightnessDown, spawn,  SHCMD("brightnessctl 8%-") }, */
	/* { MODKEY,                       XF86XK_MonBrightnessUp, spawn,  SHCMD("brightnessctl +8%") }, */
	{ 0,                            XF86XK_AudioMicMute, spawn,  SHCMD("pamixer --default-source -t") },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      spawn,          SHCMD("/home/eli/.local/bin/power") }
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function argument
     */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, layoutmenu, {0}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button1, sigdwmblocks, {.i = 1}},
    {ClkStatusText, 0, Button2, sigdwmblocks, {.i = 2}},
    {ClkStatusText, 0, Button3, sigdwmblocks, {.i = 3}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
