FROM haskell:8

# After ntwrkguru/pandoc-docker by "Stephen Steiner <ntwrkguru@gmail.com>"
LABEL  maintainer="Chris Edsall <cje57@cam.ac.uk>"

# Install dependencies
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get update -y \
    && apt-get install -yqq --no-install-recommends \
       texlive-full \
       texlive-xetex \
       texlive-latex-extra \
       texlive-fonts-extra \
       texlive-bibtex-extra \
       fontconfig \
       lmodern \
       libghc-text-icu-dev \
       make \
       zip \
    && apt-get clean

# Install cabal and then pandoc + citeproc
RUN cabal update && cabal install pandoc pandoc-citeproc pandoc-crossref --force-reinstalls

WORKDIR /build

ENTRYPOINT ["pandoc"]
CMD ["--help"]
