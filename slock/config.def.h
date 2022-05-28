/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nogroup"; // use "nobody" for arch

static const char *colorname[NUMCOLS] = {
	[BACKGROUND] =  "#2d2d2d", /* after initialization */
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/* default message */
static const char * message = "Suckless: Software that sucks less.";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "6x10";


/* insert grid pattern with scale 1:1, the size can be changed with logosize */
static const int logosize = 75;
static const int logow = 12;   /* grid width and height for right center alignment*/
static const int logoh = 6;

static XRectangle rectangles[] = {
   /* x    y   w   h */
   { 0,    3,  1,  3 },
   { 1,    3,  2,  1 },
   { 0,    5,  8,  1 },
   { 3,    0,  1,  5 },
   { 5,    3,  1,  2 },
   { 7,    3,  1,  2 },
   { 8,    3,  4,  1 },
   { 9,    4,  1,  2 },
   { 11,   4,  1,  2 },
};


/* lock screen opacity */
static const float alpha = 0.9;

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* length of time (seconds) until */
static const int timeoffset = 60;

/* should [command] be run only once? */
static const int runonce = 0;

/* command to be run after [time] has passed */
static const char *command = "doas poweroff";








/* time in seconds to cancel lock with mouse movement */
static const int timetocancel = 4;
