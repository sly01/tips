path=/Users/erkoc/Desktop/all/Works/tips/tools/indirilenler
echo "Dependencyler kontrol ediliyor. Lutfen bekleyiniz"
paket1="youtube-dl"
paket2="boxes"
if [ ! $(brew list | grep $paket1) ] && [ ! $(brew list | grep $paket2) ]
then
    brew install youtube-dl
    brew install boxes
else
    echo "Paketler zaten yuklu moruk :)"
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
           if [ $(echo $link | grep list | cut -d "&" -f2) ]
            then
                youtube-dl -cit -o "$path/%(title)s.%(ext)s" -x --audio-format mp3 $link 
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
