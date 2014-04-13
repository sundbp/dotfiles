#!/bin/bash
echo "Total git blame stats for HEAD in $(pwd)"
git ls-tree -r HEAD | grep -v '\.csv' | gsed -re 's/^.{53}//' | while read filename; do file "$filename";done | \
grep -E ': .*text' | cut -f 1 -d ':' | xargs -n1 git blame --line-porcelain | grep "author "| \
sort | uniq -c | sort -nr
