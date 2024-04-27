FROM alpine:3.19 as base

RUN apk --update add --no-cache \
        build-base \
        git \
        python3 \
        pipx \
    ;


FROM base as build-base

RUN pipx install pyinstaller
# Requires above step to build the shared venv
RUN ~/.local/share/pipx/shared/bin/python -m pip install -U wheel
RUN apk --update add --no-cache \
        scons \
        patchelf \
        binutils \
    ;
RUN pipx install staticx


FROM build-base as build

RUN git clone --depth 1 https://github.com/yt-dlp/yt-dlp.git /yt-dlp
WORKDIR /yt-dlp

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
