FROM racket/racket:8.5-full
RUN apt-get update && apt-get install -y xvfb git
# `resyntax` uses DrRacket for indenting, which requires a display, so we need to install it
# under `xvfb-run`.
# When/if this is closed, we can use racket-langserver instead (perhaps?):
# https://github.com/jeapostrophe/racket-langserver/issues/45
RUN xvfb-run raco pkg install --batch --auto --scope installation --binary-lib \
         "https://github.com/jackfirth/rebellion.git" \
         "https://github.com/jackfirth/resyntax.git" \
         "https://github.com/jackfirth/racket-package-resyntax-action.git#main"
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
