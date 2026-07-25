#!/bin/bash

# Compiles with lualatex (engine set in ./.latexmkrc) and moves pdf results to output directory. If your compile time is long, it may be preferable to omit `latexmk -C` and `rm -f ./pdfa.xmpi` to preserve the intermediate files in the top-level directory.
latexmk
cp -v ./*.pdf ./output/
latexmk -C
rm -f ./pdfa.xmpi
