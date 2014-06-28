####To install the gpg

**Linux**

```
apt-get install gpg
```

**MacOs X**

```
brew install gpg
```
####To create a key 

*While creating key required information will be asked to fill to them. Like which algorithm you will , username and so on.*

```
gpg --gen-key
```
####List keys
```
gpg --list-keys
```
###Export the key
```
gpg --armor --export username@domain.com > mykey
```
*This mail address belongs to owner of the key that you have already specify generating key part.*


**You can see your key which is encrypted**

```
cat mykey
```

*Let's assume you send the key a person who wants to send a secret message using with your key.*

**First He/She needs to import your key like this**

```
gpg --import key
```

####To make a sure he/she can list the key if it is imported or not
```
gpg --list-keys
```

####To encrypt the message (while encrypting it will ask which key you will use enought to write id,mail or username owner of key)
```
gpg --out encryptedMessageFileName --encrypt fileNameWhichWillBeEncrypted
```
####Then assume you get the message which file name is encryptedMessageFileName

**It will ask to type your password for private key.**

```
gpg --output decryptedFile --decrypt encryptedMessageFileName
```

####That's all you can see the contents of file
```
cat decryptedFile
```