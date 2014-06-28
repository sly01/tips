```
gpg --keyserver pgpkeys.mit.edu --recv-key  PUBKEY
```
```
gpg -a --export PUBKEY | sudo apt-key add -
```