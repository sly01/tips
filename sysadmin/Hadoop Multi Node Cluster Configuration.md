    Hadoop Multi Node Cluster Configuration

Master = cloud1(10.12.0.13)
Slaves = cloud(2,3,4,5,6,7,8)

Step-1

    Adding a dedicated Hadoop system user(for all machines)

$ sudo addgroup hadoop
$ sudo adduser --ingroup hadoop hduser

Step-2

    Configuring SSH-Hadoop requires SSH access to manage its nodes

```
hduser@cloud1:~$ su - hduser
hduser@ucloud1:~$ ssh-keygen -t rsa -P ""
Generating public/private rsa key pair.
Enter file in which to save the key (/home/hduser/.ssh/id_rsa):
Created directory '/home/hduser/.ssh'.
Your identification has been saved in /home/hduser/.ssh/id_rsa.
Your public key has been saved in /home/hduser/.ssh/id_rsa.pub.
The key fingerprint is:
9b:82:ea:58:b4:e0:35:d7:ff:19:66:a6:ef:ae:0e:d2 hduser@ubuntu
The key's randomart image is:
[...snipp...]
hduser@cloud1:~$
	You have to enable SSH access to your local and other machine with this newly created key.
hduser@cloud1:~$ cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
hduser@cloud1:~$ ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@cloud(2,3,4,5,6,7,8)
```

Step-3

    Downloading hadoop from nearest server and extracting.

$ cd /usr/local
$ wget ftp://ftp.itu.edu.tr/Mirror/Apache/hadoop/common/hadoop-1.2.1/hadoop-1.2.1.tar.gz
$ sudo tar xzf hadoop-1.2.1.tar.gz
$ sudo mv hadoop-1.0.3 hadoop

Step-4

    Configurating of owner and permissions of files.

$ sudo chown -R hduser:hadoop hadoop
$ sudo chmod 755(it depence on your choice)

Step-5

    Configure the directory where Hadoop will store its data files.

$ sudo mkdir -p /home/hadoopFiles/tmp /home/hadoopFiles/dfs
$ sudo chown hduser:hadoop /home/hadoopFiles

# ...and if you want to tighten up security, chmod from 755 to 750...

$ sudo chmod 750 /home/hadoopFiles

Step-6

    Configuration of hadoop

Part A

/conf/masters(on all machines)
cloud1
/conf/slaves(on all machines)
cloud2
cloud3
cloud4
cloud5
cloud6
cloud7
cloud8

Part B

/conf/hadoop-env.sh(all machines)
edit export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre

Part C

/conf/core-site.xml(all machines)

<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
<property>
                <name>hadoop.tmp.dir</name>
                <value>/home/hadoopFiles/tmp</value>
                <description>A base for other temporary directories.</description>
</property>

<property>
  <name>fs.default.name</name>
  <value>hdfs://10.12.0.13:54310</value>
  <description>The name of the default file system.  A URI whose
  scheme and authority determine the FileSystem implementation.  The
  uri's scheme determines the config property (fs.SCHEME.impl) naming
  the FileSystem implementation class.  The uri's authority is used to
  determine the host, port, etc. for a filesystem.</description>
</property>
</configuration>

Part D

/conf/hdfs-site.xml(all machines)

<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
<property>
                <name>dfs.name.dir</name>
                <value>/home/hadoopFiles/dfs</value>
</property>

<property>
  <name>dfs.replication</name>
  <value>7</value>
  <description>Default block replication.
  The actual number of replications can be specified when the file is created.
  The default is used if replication is not specified in create time.
  </description>
</property>
</configuration>

Part E

/conf/mapred-site.xml(all machines)

<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<!-- Put site-specific property overrides in this file. -->

<configuration>
<property>
  <name>mapred.job.tracker</name>
  <value>10.12.0.13:54311</value>
  <description>The host and port that the MapReduce job tracker runs
  at.  If "local", then jobs are run in-process as a single map
  and reduce task.
  </description>
</property>
</configuration>

Step-7

    Formatting the HDFS filesystem via the NameNode.

hduser@cloud1:/usr/local/hadoop$ bin/hadoop namenode -format
... INFO dfs.Storage: Storage directory /home/hadoopFiles/tmp/dfs/name has been successfully formatted.
hduser@cloud1:/usr/local/hadoop$

Step-8
Starting the multi-node cluster
Starting the cluster is performed in two steps.
We begin with starting the HDFS daemons: the NameNode daemon is started on master, and DataNode daemons are started on all slaves (here: master and slave)
Then we start the MapReduce daemons: the JobTracker is started on master, and TaskTracker daemons are started on all slaves (here: master and slave).

Part A

    HDFS Daemons
```
hduser@cloud1:/usr/local/hadoop$ bin/start-dfs.sh
starting namenode, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-namenode-cloud1.out
cloud2: starting datanode, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-datanode-cloud2.out
cloud3: starting datanode, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-datanode-cloud3.out
cloud4: starting datanode, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-datanode-cloud4.out
cloud5: starting datanode, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-datanode-cloud5.out
cloud6: starting datanode, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-datanode-cloud6.out
cloud7: starting datanode, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-datanode-cloud7.out
cloud8: starting datanode, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-datanode-cloud8.out
master: starting secondarynamenode, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-secondarynamenode-cloud1.out
hduser@master:/usr/local/hadoop$
```

```
On cloud(2,3,4,5,6,7,8), you can examine the success or failure of this command by inspecting the log file logs/hadoop-hduser-datanode-cloud(2,3,4,5,6,7,8).log.
Example output:
... INFO org.apache.hadoop.dfs.Storage: Storage directory /home/hadoopFiles/tmp/dfs/data is not formatted.
... INFO org.apache.hadoop.dfs.Storage: Formatting ...
... INFO org.apache.hadoop.dfs.DataNode: Opened server at 50010
... INFO org.mortbay.util.Credential: Checking Resource aliases
... INFO org.mortbay.http.HttpServer: Version Jetty/5.1.4
... INFO org.mortbay.util.Container: Started org.mortbay.jetty.servlet.WebApplicationHandler@17a8a02
... INFO org.mortbay.util.Container: Started WebApplicationContext[/,/]
... INFO org.mortbay.util.Container: Started HttpContext[/logs,/logs]
... INFO org.mortbay.util.Container: Started HttpContext[/static,/static]
... INFO org.mortbay.http.SocketListener: Started SocketListener on 0.0.0.0:50075
... INFO org.mortbay.util.Container: Started org.mortbay.jetty.Server@56a499
... INFO org.apache.hadoop.dfs.DataNode: Starting DataNode in: FSDataset{dirpath='/home/hadoopFiles/tmp/dfs/data/current'}
... INFO org.apache.hadoop.dfs.DataNode: using BLOCKREPORT_INTERVAL of 3538203msec
```
At this point, the following Java processes should run on cloud1

hduser@cloud1:/usr/local/hadoop$ jps
14799 NameNode
15314 Jps
14880 DataNode
14977 SecondaryNameNode
hduser@cloud1:/usr/local/hadoop$
(the process IDs don’t matter of course)

…and the following on cloud(2,3,4,5,6,7,8).

hduser@cloud(2,3,4,5,6,7,8):/usr/local/hadoop$ jps
15183 DataNode
15616 Jps
hduser@slave:/usr/local/hadoop$

Part B

    MapReduce Daemons
```
hduser@cloud1:/usr/local/hadoop$ bin/start-mapred.sh
starting jobtracker, logging to /usr/local/hadoop/bin/../logs/hadoop-hadoop-jobtracker-cloud1.out
cloud2: starting tasktracker, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-tasktracker-cloud2.out
cloud3: starting tasktracker, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-tasktracker-cloud3.out
cloud4: starting tasktracker, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-tasktracker-cloud4.out
cloud5: starting tasktracker, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-tasktracker-cloud5.out
cloud6: starting tasktracker, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-tasktracker-cloud6.out
cloud7: starting tasktracker, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-tasktracker-cloud7.out
cloud8: starting tasktracker, logging to /usr/local/hadoop/bin/../logs/hadoop-hduser-tasktracker-cloud8.out
hduser@cloud1:/usr/local/hadoop$

On slave, you can examine the success or failure of this command by inspecting the log file logs/hadoop-hduser-tasktracker-cloud(2,3,4,5,6,7,8).log. Example output:

... INFO org.mortbay.util.Credential: Checking Resource aliases
... INFO org.mortbay.http.HttpServer: Version Jetty/5.1.4
... INFO org.mortbay.util.Container: Started org.mortbay.jetty.servlet.WebApplicationHandler@d19bc8
... INFO org.mortbay.util.Container: Started WebApplicationContext[/,/]
... INFO org.mortbay.util.Container: Started HttpContext[/logs,/logs]
... INFO org.mortbay.util.Container: Started HttpContext[/static,/static]
... INFO org.mortbay.http.SocketListener: Started SocketListener on 0.0.0.0:50060
... INFO org.mortbay.util.Container: Started org.mortbay.jetty.Server@1e63e3d
... INFO org.apache.hadoop.ipc.Server: IPC Server listener on 50050: starting
... INFO org.apache.hadoop.ipc.Server: IPC Server handler 0 on 50050: starting
... INFO org.apache.hadoop.mapred.TaskTracker: TaskTracker up at: 50050
... INFO org.apache.hadoop.mapred.TaskTracker: Starting tracker tracker_slave:50050
... INFO org.apache.hadoop.ipc.Server: IPC Server handler 1 on 50050: starting
... INFO org.apache.hadoop.mapred.TaskTracker: Starting thread: Map-events fetcher for all reduce tasks on tracker_slave:50050
```
At this point, the following Java processes should run on cloud1…
```
hduser@cloud1:/usr/local/hadoop$ jps
16017 Jps
14799 NameNode
15686 TaskTracker
14880 DataNode
15596 JobTracker
14977 SecondaryNameNode
hduser@cloud1:/usr/local/hadoop$
(the process IDs don’t matter of course)

…and the following on cloud(2,3,4,5,6,7,8).
hduser@cloud(2,3,4,5,6,7,8):/usr/local/hadoop$ jps
15183 DataNode
15897 TaskTracker
16284 Jps
hduser@cloud(2,3,4,5,6,7,8):/usr/local/hadoop$
```
Or just type /bin/start-all.sh (to start the all services)

Step-9

    Stopping the multi-node cluster
```
hduser@cloud1:/usr/local/hadoop$ bin/stop-mapred.sh
hduser@cloud1:/usr/local/hadoop$ bin/stop-dfs.sh
OR
hduser@cloud1:/usr/local/hadoop$ bin/stop-all.sh
```

```
In .bashrc added PATH=$PATH:/usr/local/hadoop/bin
For starting and stopping command services you can just type start-all.sh,stop-all.sh,start-dfs.sh,stop-dfs.sh,start-mapred.sh,stop-mapred.sh those all commands which are in /usr/local/hadoop/bin/
```
Step-10
Testing the system.(on cloud1)
hadoop dfsadmin -report (detail system report)
hadoop jar /usr/local/hadoop/hadoop-examples-1.2.1.jar pi 10 10 (MapReduce Job testing)
hadoop dfs -h (all possible commands here)

Hadoop disable safemode

hadoop dfsadmin -safemode leave
