# Plugin Exec


## 1. Mô tả

Exec plugin để thực thi một script được viết sẵn. Có 2 cách để thực thi script sủ dụng plugin này:
 - `Exec`
    Plugin sẽ thực thi sript tuần tự theo từng lần một, và thực hiện lại khi kết thúc script.

 - `NotificationExec`
 	Plugin sẽ thực thi script mỗi khi nhận được một cảnh báo từ collectd daemon. Cảnh báo được nhận vào như `STDIN`. Không giống như `Exec`, việc thực thi script sẽ không diễn ra tuần tự, nên có thể thực thi script đồng thời nếu nhận được nhiều thông báo một lúc.

## 2 Cách cấu hình

Cấu hình theo `NotificationExec`

```sh
LoadPlugin exec
<Plugin exec>
 NotificationExec "nobody:nogroup" "/usr/lib/collectd/notify.sh"
</Plugin>
```

Nội dung file `/usr/lib/collectd/notify.sh`:

```
#!/bin/sh 

#echo "blah" >> /var/log/collectd/notification.log
#!/bin/sh 
while read x y 
  do  case "$x$y" in 
            '') exec logger -t $severity -p user."$severity";; 
         #   '') echo collectd${severity+" $severity" -p user."$severity"} >> /var/log/collectd/notification.log
            Severity:WARNING) severity=warning;; 
            Severity:OKAY)    severity=notice;; 
            Severity:FAILURE) severity=err;; 
      esac 
  done 
```

Khi nhận được cảnh báo, plugin này sẽ thực thi script `notify.sh` để ghi log cảnh báo vào `/var/log/syslog`.

Nội dung cảnh báo:
```
Jul  3 04:20:58 localhost collectd warning: Host compute1, plugin memory type memory (instance used): Data source "value" is currently 1299722240.000000. That is above the warning threshold of 1200000000.000000.
```

Tham khảo:

[1] - https://collectd.org/wiki/index.php/Plugin:Exec

[2] - https://collectd.org/documentation/manpages/collectd-exec.5.shtml
