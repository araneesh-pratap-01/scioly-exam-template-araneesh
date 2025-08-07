#!/bin/bash

latexmk -lualatex
cp -v *.pdf ./output/
