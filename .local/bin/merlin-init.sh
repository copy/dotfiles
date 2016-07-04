#!/bin/sh

# Add PKG's:
ocamlfind list \
    | awk '{ print "PKG "$1 }'

# See https://github.com/the-lambda-church/merlin/wiki/Letting-merlin-locate-go-to-stuff-in-.opam
find $(opam config var share)/../ -name '*.cmt' -print0 \
    | xargs -0 -I{} dirname '{}' \
    | sort -u \
    | awk '{ print "S "$0"\nB "$0 }'
