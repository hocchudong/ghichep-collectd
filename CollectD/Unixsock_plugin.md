# Plugin Unixsock


## 1. Mô tả

Unixsock plugin mở một UNIX-socket để user có thể tương tác với collectd daemon. Việc tương tác với collectd daemon này giúp sử dụng các metric của collectd cho các ứng dụng khác, hoặc đưa thêm các giá trị khác vào collectd. 

## 2 Cách cấu hình

```sh
LoadPlugin unixsock
<Plugin unixsock>
    SocketFile "/var/run/collectd-unixsock"
    SocketGroup "collectd"
    SocketPerms "0770"
    DeleteSocket false
</Plugin>
```

## 3. Các lệnh sử dụng



Tham khảo:

[1] - https://collectd.org/documentation/manpages/collectd-unixsock.5.shtml
