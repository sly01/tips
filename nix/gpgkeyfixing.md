```
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys <PUBKEY>
```
**Alternate Method**
```
gpg --keyserver pgpkeys.mit.edu --recv-key  PUBKEY
```
```
gpg -a --export PUBKEY | sudo apt-key add -
```
