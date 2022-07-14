// Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    { "", "~/bin/sb_disk", 30, 0 },
    { "", "~/bin/sb_memory",  30, 0 },
    { "", "~/bin/sb_date",  5, 0 },
    { "", "~/bin/sb_volume",  5, 0 },
    { "", "~/bin/sb_battery",  5, 0 },
};

// sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char         delim[]  = "|";
static unsigned int delimLen = 5;

/*
 *
 * Sinal 0 significa nenhum sinal
static const Block blocks[] = {
	{"",         "time.sh",	     60,                     0},
	{"",         "brightness.sh",	 0,                      11},
};

 super + Up
    light -A 5 && pkill -RTMIN+11 dwmblocks
super + Down
    light -U 5 && pkill -RTMIN+11 dwmblocks
*/
