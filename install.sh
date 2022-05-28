#!/bin/bash

rm -rf dwm-flexipatch/
rm -rf flexipatch-finalizer/

git submodule update --init --recursive

# Copy default headers
cp dwm-flexipatch/patches{.def,}.h
cp dwm-flexipatch/config{.def,}.h

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
MONOCLE_LAYOUT
do
  sed -i "s/^#define $i [01]/#define $i 1/" \
    dwm-flexipatch/patches.h
done

sed -i "s/^#\(XRENDER = -lXrender\)/\1/" \
  dwm-flexipatch/config.mk

sed -i "s/\(static const char *termcmd\[\]\).*/\1 = { \"xfce4-terminal\", NULL };/" \
  dwm-flexipatch/config.h


#static const char *roficmd[] = { "rofi", "-show", "combi", "-show-icons", NULL };

# make -C dwm-flexipatch/ clean all
# sudo make -C dwm-flexipatch/ install

chmod 755 flexipatch-finalizer/flexipatch-finalizer.sh
./flexipatch-finalizer/flexipatch-finalizer.sh \
  -r -d ~/git/github/dwm/dwm-flexipatch/ \
  -o ~/git/github/dwm/dwm

cp dwm.desktop dwm/

cat <<EOF >> dwm/Makefile

post_install:
	cp dwm.desktop /usr/share/xsessions/dwm.desktop
EOF

make -C dwm clean all
sudo make -C dwm install post_install
