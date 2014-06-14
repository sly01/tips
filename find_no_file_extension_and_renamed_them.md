find . -maxdepth 1 -type f ! -name “*.*” -exec sh -c ‘mv “$1” “$1”.md’ _ {} \;
