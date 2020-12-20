#### Installing s3cmd and configuration

```
sudo pip install s3cmd
```

##### For the first time you should configure

```
s3cmd --configure

it will be ask access key =
it will be ask secret key =
```

**To list the all buckets.**

```
s3cmd ls
```

**To list the specific bucket.**

```
s3cmd ls s3://bucket_name

s3cmd ls --recursive s3://bucket_name
```
