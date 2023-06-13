if which cwebp >/dev/null
which identify >/dev/null
then
    for input in assets/images/*.png; do
        if [[ ! -e $input ]];
            then continue;
        fi
        echo $input
        size=(`identify -format '%w %h' "$input"`)
        echo $size
        fileName="${input##*/}"
        echo $fileName
        for i in 1.0 1.5 2.0 3.0 4.0; do
            outputPath="${input%/*}"
            if [ $i != 1.0 ]; then
                outputPath+="/${i}x"
            fi
            echo $outputPath
            mkdir -p $outputPath
            outputFile="$outputPath/${fileName%.*}.webp"
            echo "outputFile: $outputFile"
            width=$(echo "$((size[0]/4)) $i" | awk '{print $1 * $2}')
            height=$(echo "$((size[1]/4)) $i" | awk '{print $1 * $2}')
            echo "outputSize: {$width,$height}"
            cwebp -q 90 -resize $width $height -mt "$input" -o "$outputFile"
        done
        rm "$input"
    done
else
    echo "warning: WebP encoder and ImageMagick tool are not installed. To install, please run 'brew install webp imagemagick'"
fi