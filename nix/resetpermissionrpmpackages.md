#####Reset the permissions of the all installed RPM packages
```
for p in $(rpm -qa); do rpm --setperms $p; done
for p in $(rpm -qa); do rpm --setugids $p; done
```
