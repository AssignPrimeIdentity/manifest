FROM ghcr.io/eq19/grammar:0.2.4

LABEL version="0.2.4"
LABEL homepage="https://eq19.github.io/grammar"
LABEL repository="https://github.com/eq19/grammar"

ENTRYPOINT ["/entrypoint.sh"]
