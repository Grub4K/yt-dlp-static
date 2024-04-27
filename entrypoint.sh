#!/bin/ash

set -e

source ~/.local/share/pipx/venvs/pyinstaller/bin/activate
python -m devscripts.install_deps
python -m devscripts.make_lazy_extractors
python devscripts/update-version.py --origin Grub4K/yt-dlp-static "$(date -u +"%H%M%S")"
python -m bundle.pyinstaller --name yt-dlp_static
deactivate

source ~/.local/share/pipx/venvs/staticx/bin/activate
staticx /yt-dlp/dist/yt-dlp_static /build/yt-dlp_static_1
deactivate
mv -f /build/yt-dlp_static_1 /build/yt-dlp_static
chmod +rx /build/yt-dlp_static
