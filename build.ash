#!/bin/ash

# Prepare
apk add git python3 scons g++ patchelf binutils
git clone https://github.com/yt-dlp/yt-dlp.git ~/yt-dlp
python3 -m venv ~/pyinstaller ~/staticx

# Build
source ~/pyinstaller/bin/activate
python3 -m pip install -U pyinstaller
python3 ~/yt-dlp/pyinst.py --name yt-dlp_linux-static
deactivate

# Make static
source ~/staticx/bin/activate
python3 -m pip install -U staticx
staticx ~/yt-dlp/dist/yt-dlp_linux-static ~/yt-dlp/dist/yt-dlp_linux-static_1
mv -f ~/yt-dlp/dist/yt-dlp_linux-static_1 ~/yt-dlp/dist/yt-dlp_linux-static
deactivate
