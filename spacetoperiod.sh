#!/bin/bash
for i in *.mkv; do
  [[ "$i" = *\ * ]] && mv -nv -- "$i" "${i// /.}"
done
