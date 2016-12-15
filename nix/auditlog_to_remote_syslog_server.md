```
vi /etc/audisp/plugins.d/syslog.conf 
# This file controls the configuration of the
# syslog plugin. It simply takes events and writes
# them to syslog.
 
active = yes
direction = out
path = builtin_syslog
type = builtin 
args = LOG_INFO
format = string
 
vi /etc/syslog.conf or /etc/rsyslog.conf
 
#audit log
$ModLoad imfile
$InputFileName /var/log/audit/audit.log
$InputFileTag tag_audit_log:
$InputFileStateFile audit_log
$InputFileSeverity info
$InputFileFacility local6
$InputRunFileMonitor
#local6.* @<10.170.147.247>

Then restart rsyslog and auditd restart
systemctl restart rsyslog 
service auditd restart
```
