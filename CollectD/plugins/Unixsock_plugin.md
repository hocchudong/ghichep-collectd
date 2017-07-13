# Plugin Unixsock


## 1. Mô tả

- Unixsock plugin mở một UNIX-socket để user có thể tương tác với collectd daemon, giúp sử dụng các metric của collectd cho các ứng dụng khác, hoặc đưa thêm các giá trị khác vào collectd. 
- Phiên bản OS sử dụng là Ubuntu 14.04.5, kernel 4.4.0-79-generic.
- Phiên bản collectd sử dụng là collectd 5.5.3.1.

## 2. Cách cấu hình

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

`collectdctl getval Identifier`

`collectdctl listval`

`collectd putval Identifier [OptionList] Valuelist`

`collectdctl putnotif [OptionList] message=Message`

`collectdctl flush [timeout=Timeout] [plugin=Plugin [...]] [identifier=Ident [...]]`



Tham khảo:

[1] - https://collectd.org/documentation/manpages/collectd-unixsock.5.shtml
