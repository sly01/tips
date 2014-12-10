####To get screenshot in i3wm

**First install scrot package which is for capturing screen**

```
sudo apt-get install scrot
```

**Then configure i3wm config in ~/.i3/config**

*Add this line*
```
bindsym $mod+x exec scrot
```

**This means that when you press $mod key this is generally would be "alt and x". It will take the screenshot on the home directory of user.**
