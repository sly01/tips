## RESETTING THE ROOT(POSTGRES) PASSWORD FOR POSTGRESQL

1-**Stop postgresql service**

```
service postgresql stop
```

2-**Close the authentication system for root**

```
vi /etc/postgresq/pg_hba.conf
```

_Edit that line_

**local all all ident** --> **local all postgres trust**

3-**Start postgresql service**

```
service postgresql start
```

4-**Login postgres as a root of postgresql server**

```
su - postgres
```

```
psql -d template1 -U postgres
```

```
alter user postgres with password 'new_password';
```

5-**Revert the configuration**

```
vi /etc/postgresql/pg_hba.conf
```

_Edit that line again_

**local all postgres trust** --> **local all all ident**

6-**Restart postgresql service**

```
service postgresql restart
```
