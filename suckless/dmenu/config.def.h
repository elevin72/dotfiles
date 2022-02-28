/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int colorprompt = 0;                /* -p  option; if 1, prompt uses SchemeSel, otherwise SchemeNorm */
static int centered = 1;                    /* -c option; centers dmenu on screen */
static int min_width = 500;                    /* minimum width when centered */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Ubuntu Nerd Font:style-Book,regular:size=12"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*                           fg         bg       */
	[SchemeNorm] =          { "#d5c4a1", "#3c3836" },
	[SchemeSel] =           { "#8ec07c", "#8f3f71" },
	[SchemeSelHighlight] =  { "#689d6a", "#8f3f71" },
	[SchemeNormHighlight] = { "#a89984", "#3c3836" },
	[SchemeOut] =           { "#cc241d", "#00ffff" },
	[SchemeHp] =            { "#fbf1c7", "#665c54" },
	[SchemeOutHighlight] =  { "#0000ff", "#00ffff" }
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 20;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static const unsigned int border_width = 3;
