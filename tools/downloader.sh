path=/Users/erkoc/Desktop/all/Works/tips/tools/indirilenler

echo "Youtube Downloader Hosgeldiniz"
while true; do
    echo -e "1-Mp3 Indir\n2-Indirilenleri Listele\n3-Cikis Yap" | boxes
    read secim
    case $secim in
        1) if [ ! "$(head -n1 $0)" ]
           then
            echo "Lutfen indirilecek yerin yolunu veriniz"
            read path
            echo path="$path" | cat - $0 > temp && mv temp $0
           fi
           echo "Lutfen indirilecek linki giriniz"
           read link
           echo "Sarkilar Indirilmeye baslaniyor"
           youtube-dl -o "$path/%(title)s.%(ext)s" -x --audio-format mp3 $link > /dev/null
            ;;
        2) ls "$path" | tr -d ' ' | nl -nrz -w2
            ;;
        3) break
            ;;
    esac
done
