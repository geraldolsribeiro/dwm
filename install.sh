#!/bin/bash

# https://gist.github.com/palopezv/efd34059af6126ad970940bcc6a90f2e
# palopezv/dwm_config_pulseaudio.h

rm -rf flexipatch-finalizer/
rm -rf dwm-flexipatch/
rm -rf dmenu-flexipatch/
rm -rf slock-flexipatch/
rm -rf st-flexipatch/
rm -rf dwmblocks/

git submodule update --init --recursive

for repo in \
  dmenu-flexipatch \
  dwmblocks \
  dwm-flexipatch \
  flexipatch-finalizer \
  slock-flexipatch \
  st-flexipatch \

do
  pushd $repo || exit 1
  git checkout master
  git pull
  popd || exit 1
done

# ainda não sei como aplicar este patch para
# preservar as tags entre os restarts
if [ ! -f dwm-preserveonrestart-6.3.diff ]; then
 wget https://raw.githubusercontent.com/PhyTech-R0/dwm-phyOS/master/patches/dwm-6.3-patches/dwm-preserveonrestart-6.3.diff
fi

chmod 755 flexipatch-finalizer/flexipatch-finalizer.sh

# Copy default headers

#cp dwmblocks/config{.def,}.h

# ----------------------------------------------------------------------
# DWM
# ----------------------------------------------------------------------
cp dwm-flexipatch/config{.def,}.h
cp dwm-flexipatch/patches{.def,}.h
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

sed -i "s/^#\(XRENDER\)/\1/" \
  dwm-flexipatch/config.mk

# sed -i "s/^#\(PANGOINC\)/\1/" \
#   dwm-flexipatch/config.mk
#
# sed -i "s/^#\(PANGOLIB\)/\1/" \
#   dwm-flexipatch/config.mk

sed -i 's/\(static const char \*termcmd\[\] *= \).*/\1{ "xfce4-terminal", NULL };/' \
  dwm-flexipatch/config.h

sed -i 's/\(static const char \*fonts\[\] *= \).*/\1{ "Fira Code:style=Regular:size=12", "Material Design Icons Desktop:style=Regular:size=10" };/' \
  dwm-flexipatch/config.h

sed -i 's/\(static const char dmenufont\[\] *= \).*/\1 "Fira Code:style=Regular:size=14";/' \
  dwm-flexipatch/config.h

# dmenu grid: 2 columns x 10 lines
sed -i 's/\("dmenu_run",\)/\1\r"-g", "2",\r"-l", "10",/' \
  dwm-flexipatch/config.h


# https://www.nerdfonts.com/cheat-sheet

sed -i "s/\(static const unsigned int gappov\).*/\1 = 10;/" \
  dwm-flexipatch/config.h

#static const char *roficmd[] = { "rofi", "-show", "combi", "-show-icons", NULL };


./flexipatch-finalizer/flexipatch-finalizer.sh \
  -r -d ~/git/github/dwm/dwm-flexipatch/ \
  -o ~/git/github/dwm/dwm

git -C dwm apply ../volume-key.patch

cp dwm.desktop dwm/


# https://owl.eu.com/posts/debian-demystified-installing-bitmap-fonts.html
cat <<EOF > dwm-flexipatch/50-enable-siji.conf
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <selectfont>
    <acceptfont>
      <pattern>
        <patelt name="family"><string>siji</string></patelt>
      </pattern>
    </acceptfont>
  </selectfont>
</fontconfig>
EOF
# cp 50-enable-siji.conf /etc/fonts/conf.avail/50-enable-siji.conf

cat <<EOF >> dwm/Makefile

post_install:
	cp dwm.desktop /usr/share/xsessions/dwm.desktop
EOF


# ----------------------------------------------------------------------
# DMENU
# ----------------------------------------------------------------------
cp dmenu-flexipatch/config{.def,}.h
cp dmenu-flexipatch/patches{.def,}.h
for i in \
 ALPHA_PATCH \
 BORDER_PATCH \
 CASEINSENSITIVE_PATCH \
 CENTER_PATCH \
 COLOR_EMOJI_PATCH \
 CTRL_V_TO_PASTE_PATCH \
 FUZZYMATCH_PATCH \
 FUZZYHIGHLIGHT_PATCH \
 EMOJI_HIGHLIGHT_PATCH \
 PREFIXCOMPLETION_PATCH \
 GRID_PATCH \
 GRIDNAV_PATCH \

do
  sed -i "s/^#define $i [01]/#define $i 1/" \
    dmenu-flexipatch/patches.h
done

./flexipatch-finalizer/flexipatch-finalizer.sh \
  -r -d ~/git/github/dwm/dmenu-flexipatch/ \
  -o ~/git/github/dwm/dmenu

# ----------------------------------------------------------------------
# SLOCK
# ----------------------------------------------------------------------
cp slock-flexipatch/patches{.def,}.h
cp slock-flexipatch/config{.def,}.h
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

# ----------------------------------------------------------------------
# DWMBLOCKS
# ----------------------------------------------------------------------
cp blocks.h dwmblocks/

# sed -i "s|\(#define PATH(name) \).*|\1 \"/home/geraldo/bin/\" name|" \
#   dwmblocks/config.h

# ----------------------------------------------------------------------
# ST
# ----------------------------------------------------------------------
suto apt install -y libharfbuzz-dev
cp st-flexipatch/patches{.def,}.h
cp st-flexipatch/config{.def,}.h
for i in \
 ALPHA_PATCH \
 ALPHA_FOCUS_HIGHLIGHT_PATCH \
 BLINKING_CURSOR_PATCH \
 CLIPBOARD_PATCH \
 COPYURL_PATCH \
 LIGATURES_PATCH \
 VIM_BROWSE_PATCH \
 NETWMICON_PATCH \
 NEWTERM_PATCH \
 RIGHTCLICKTOPLUMB_PATCH \

do
  sed -i "s/^#define $i [01]/#define $i 1/" \
    st-flexipatch/patches.h
done

sed -i 's/\(static char \*font *= \).*/\1 "Fira Code:style=Regular:size=14";/' \
  st-flexipatch/config.h

sed -i "s/^#LIGATURES_/LIGATURES_/" st-flexipatch/config.mk

./flexipatch-finalizer/flexipatch-finalizer.sh \
  -r -d ~/git/github/dwm/st-flexipatch/ \
  -o ~/git/github/dwm/st

# ----------------------------------------------------------------------
# BUILD ALL
# ----------------------------------------------------------------------

make -C dwm clean all
sudo make -C dwm install post_install

make -C dmenu clean all
sudo make -C dmenu install

make -C slock clean all
sudo make -C slock install

make -C dwmblocks clean all
sudo make -C dwmblocks install

make -C st clean all
sudo make -C st install

sudo make -C scripts/ install
