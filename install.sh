#!/bin/bash

rm -rf flexipatch-finalizer/
rm -rf dwm-flexipatch/
rm -rf dmenu-flexipatch/
rm -rf slock-flexipatch/

git submodule update --init --recursive

chmod 755 flexipatch-finalizer/flexipatch-finalizer.sh

# Copy default headers
cp dwm-flexipatch/config{.def,}.h
cp dwm-flexipatch/patches{.def,}.h
cp dmenu-flexipatch/config{.def,}.h
cp dmenu-flexipatch/patches{.def,}.h
cp slock-flexipatch/patches{.def,}.h
cp slock-flexipatch/config{.def,}.h

# -------

# Enable some patches
for i in \
BAR_DWMBLOCKS_PATCH \
BAR_DWMBLOCKS_SIGUSR1_PATCH \
BAR_LTSYMBOL_PATCH \
BAR_STATUS_PATCH \
BAR_STATUSBUTTON_PATCH \
BAR_STATUSCMD_PATCH \
BAR_STATUS2D_PATCH \
BAR_SYSTRAY_PATCH \
BAR_TAGS_PATCH \
BAR_WINTITLE_PATCH \
BAR_TITLE_LEFT_PAD_PATCH \
BAR_ALPHA_PATCH \
BAR_STATUSALLMONS_PATCH \
BAR_STATUSCOLORS_PATCH \
BAR_STATUSPADDING_PATCH \
ATTACHASIDE_PATCH \
AUTOSTART_PATCH \
CYCLELAYOUTS_PATCH \
RESTARTSIG_PATCH \
ROTATESTACK_PATCH \
SELFRESTART_PATCH \
TAGOTHERMONITOR_PATCH \
VANITYGAPS_PATCH \
GRIDMODE_LAYOUT \
TILE_LAYOUT \
MONOCLE_LAYOUT \

do
  sed -i "s/^#define $i [01]/#define $i 1/" \
    dwm-flexipatch/patches.h
done

sed -i "s/^#\(XRENDER = -lXrender\)/\1/" \
  dwm-flexipatch/config.mk

sed -i "s/\(static const char *termcmd\[\]\).*/\1 = { \"xfce4-terminal\", NULL };/" \
  dwm-flexipatch/config.h

sed -i "s/\(static const unsigned int gappov\).*/\1 = 10;/" \
  dwm-flexipatch/config.h

#static const char *roficmd[] = { "rofi", "-show", "combi", "-show-icons", NULL };


./flexipatch-finalizer/flexipatch-finalizer.sh \
  -r -d ~/git/github/dwm/dwm-flexipatch/ \
  -o ~/git/github/dwm/dwm

cp dwm.desktop dwm/

cat <<EOF >> dwm/Makefile

post_install:
	cp dwm.desktop /usr/share/xsessions/dwm.desktop
EOF

# -------

for i in \
 ALPHA_PATCH \
 BORDER_PATCH \
 CASEINSENSITIVE_PATCH \
 CENTER_PATCH \
 COLOR_EMOJI_PATCH \
 CTRL_V_TO_PASTE_PATCH \
 FUZZYMATCH_PATCH \
 FUZZYHIGHLIGHT_PATCH \

do
  sed -i "s/^#define $i [01]/#define $i 1/" \
    dmenu-flexipatch/patches.h
done

./flexipatch-finalizer/flexipatch-finalizer.sh \
  -r -d ~/git/github/dwm/dmenu-flexipatch/ \
  -o ~/git/github/dwm/dmenu

# -------

for i in \
 ALPHA_PATCH \
 AUTO_TIMEOUT_PATCH \
 COLOR_MESSAGE_PATCH \
 DWM_LOGO_PATCH \
 QUICKCANCEL_PATCH \

do
  sed -i "s/^#define $i [01]/#define $i 1/" \
    slock-flexipatch/patches.h
done

sed -i "s/^#\(XINERAMA=-lXinerama\)/\1/" \
  slock-flexipatch/config.mk

sed -i "s/^#\(XINERAMAFLAGS = -DXINERAMA\)/\1/" \
  slock-flexipatch/config.mk

./flexipatch-finalizer/flexipatch-finalizer.sh \
  -r -d ~/git/github/dwm/slock-flexipatch/ \
  -o ~/git/github/dwm/slock

# -------

make -C dwm clean all
sudo make -C dwm install post_install

make -C dmenu clean all
sudo make -C dmenu install

make -C slock clean all
sudo make -C slock install
