FROM ghcr.io/eq19/grammar:latest

LABEL version="0.2.1"
LABEL repository="https://github.com/eq19/grammar"
LABEL homepage="https://github.com/eq19/grammar"

COPY LICENSE.txt README.md

COPY script /script
COPY providers /providers
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
