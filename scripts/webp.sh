if which cwebp >/dev/null; then
    find 'assets/images/' -type f -name '*.png' | xargs -P 8 -I {} sh -c 'cwebp -q 90 $1 -o "${1%.png}.webp"' _ {} \;
    find 'assets/images/' -type f -name '*.png' -exec rm -rf {} \;
else
    echo "warning: WebP encoder tool (brew install webp) is not installed"
fi