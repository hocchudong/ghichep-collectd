Trong Graphite, người dùng thường để tên của các máy collectd client bắt đầu bằng tiền tố "collectd".

<img src="http://i.imgur.com/uVDibIx.png">

Tiền tố này có thể thay đổi được theo ý muốn của người dùng.

Để thay đổi tiền tố này, bước thứ nhất người dùng nên stop dịch vụ collectd

```sh
service collectd stop
```
Sau đó người dùng vào file collectd.conf trên collectd server để sửa plugin write_graphite.

```sh
vi /etc/collectd/collectd.conf
```

```sh
<Plugin write_graphite>
<Node "graphing">
        Host "localhost"
        Port "2003"
        Protocol "tcp"
        LogSendErrors true
                Prefix "Testing"
                StoreRates true
                AlwaysAppendDS false
                EscapeCharacter "_"
        </Node>
</Plugin>
```
Ở đây, tôi để graphite là "Testing"
Sau đó người dùng start lại dịch vụ collectd.

```sh
service collectd start
```

<img src="http://i.imgur.com/TcYFhMy.png">
Chú ý: pattern của [colletcd] trong file storage-schemas.conf nên giống với prefix trong plugin writen-graphite

```sh
[collectd]
pattern = ^Testing.*
retentions = 10s:1d,1m:7d,10m:1y
```

Nguồn:

https://community.rackspace.com/products/f/25/t/6800