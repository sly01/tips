path=/Users/erkoc/Desktop/all/Works/tips/tools/indirilenler
echo "Paketler kontrol ediliyor. Lutfen bekleyiniz"
paket1="youtube-dl"
paket2="boxes"
if [ ! $(brew list | grep $paket1) ] && [ ! $(brew list | grep $paket2) ]
then
    brew install youtube-dl
    brew install boxes
else
    echo "Paketler zaten yuklu"
fi
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
           echo "Sarkilar Indirilmeye baslaniyor, lutfen bekleyiniz"
           sleep 3
           if [ $(echo $link | grep list | cut -d "&" -f2) ]
            then
                echo "Listelerde ki sarkilar indiriliyor"
                youtube-dl -cit  -x --audio-format mp3 $link > /dev/null
                /bin/mv *.mp3 $path
            else
                youtube-dl -o "$path/%(title)s.%(ext)s" -x --audio-format mp3 $link > /dev/null
            fi
            ;;
        2) ls "$path" | tr -d ' ' | nl -nrz -w2
            ;;
        3) break
            ;;
        *) echo "Yanlis bir secim girdiniz"
            ;;
    esac
done
