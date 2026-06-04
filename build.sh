#!/bin/bash

# Compiles with lualatex and moves pdf results to output directory. If your compile time is long, it may be preferable to omit `latexmk -C` and `rm ./pdfa.xmpi` to preserve the intermediate files in the top-level directory.
latexmk -lualatex
cp -v *.pdf ./output/
latexmk -C
rm ./pdfa.xmpi