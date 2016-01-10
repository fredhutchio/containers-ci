#!/bin/sh
set -e

#    --include-in-header src/simple-small.css \

pandoc \
    -t revealjs \
    --standalone \
    --variable transition="fade" \
    --smart \
    -o "$2" \
    $1

sed -e "s_reveal.js/css/reveal.min.css_reveal.js/css/reveal.css_" \
    -e "s_reveal.js/js/reveal.min.js_reveal.js/js/reveal.js_" \
    -e "s_simple.css_black.css_" \
    -i "$2"
