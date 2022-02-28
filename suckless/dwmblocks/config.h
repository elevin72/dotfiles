//Modify this file to change what commands output to your statusbar, and recompile using the make command.

static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
//	{"",	"weather",	3600,	0},
	{"",    "/home/eli/.local/bin/memory",	               15,      		1},
	{"",	"/home/eli/.local/bin/temp",                    5,          	2},
	{"",	"/home/eli/.local/bin/cpu",	                    5,          	3},
	{"",	"/home/eli/.local/bin/internet.sh",              5,          	4},
	{"",	"/home/eli/.local/bin/volume",	                0,          	10},
	{"",	"/home/eli/.local/bin/battery",	               15,          	11},
	{"",	"/home/eli/.local/bin/getKeyLayout",	            0,          	9},
	{"",    "/home/eli/.local/bin/myDate",				   10,      		5}
};

//Sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char *delim = "  |   ";

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
