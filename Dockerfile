FROM ghcr.io/eq19/grammar:latest

LABEL version="0.2.3"
LABEL homepage="https://eq19.github.io/grammar"
LABEL repository="https://github.com/eq19/grammar"

ENTRYPOINT ["/entrypoint.sh"]
