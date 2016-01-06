**Collectd** cung cấp một kho plugin để người dùng có thể sử dụng, người dùng có thể cấu hình trong file collectd.conf để lấy các thông số mà họ muốn. Sau khi **collectd** thu thập được dữ liệu nó sẽ truyền vào **Graphite**, **Graphite** thể hiện những thông số này dưới dạng biểu đồ.

<img src="http://i.imgur.com/VNIrykz.png">

#### 1. Memory Plugin

Để collectd có thể thu thập được dữ liệu về bộ nhớ vật lý, người dùng phải uncomment dòng LoadPlugin memory trong file collectd.conf
```sh
  vi /etc/collectd/collectd.conf
```
<img src="http://i.imgur.com/24GmsHg.png">

Memory plugin thu thập thông tin về bộ nhớ  vật lý của máy. Biểu đồ trên giao diện web của Graphite thể hiện thông tin về:
- buffered
- cached
- free
- used

Để kiểm tra các thông số này trên máy ubuntu có thể dùng lệnh: free, top...

<img src="http://i.imgur.com/kbAXm7Z.png">

<img src="http://i.imgur.com/Axkj33J.png">

Note: used trong biểu đồ là used của memory sau khi trừ đi buffered và cached.



#### 2. df Plugin

Để collectd có thể thể dữ liệu về disk free, người dùng phải cấu hình trong file collectd.conf , uncomment LoadPlugin df

```sh
  vi /etc/collectd/collectd.conf
```

<img src= "http://i.imgur.com/nLCHlao.png">

df plugin thu thập thông tin về việc sử dụng hệ thống file. Ví dụ trong một phân vùng, người dùng đã sử dụng hết bao nhiêu không gian và bao nhiêu không gian có sẵn để sử dụng.

Trên mỗi phân vùng người dùng có thể thấy các thông số:
- free
- reserved
- used

Để kiểm tra trên máy ubuntu ổ đĩa đã được sử dụng bao nhiêu và còn trống bao nhiêu sử dụng lệnh df

<img src="http://i.imgur.com/CLotJjQ.png">

Trong đó total = free + reserved + used 

Để collectd có thể thu thập dữ liệu từ tất cả các file hệ thống, người dùng cấu hình trên file collectd.conf như sau:
```sh
<Plugin "df">
  IgnoreSelected true
</Plugin>
```

Để collectd chỉ có thê lấy dữ liệu từ phân vùng ext3, cấu hình trong file collectd.conf như sau:
```sh 
<Plugin "df">
  FSType "ext3"
</Plugin>
```

Để collectd chỉ có thể lấy dữ liệu từ một phân vùng, cấu hình trong file collectd.conf:
```sh
<Plugin "df">
  # ở đây người dùng có thể thay đổi phân vùng để lấy dữ liệu
  Device "/dev/hda1"
  MountPoint "/home"
  FSType "ext3"
  IgnoreSelected false
  ReportInodes false
  # Only in Version 4 since 4.9
  #ReportReserved false
</Plugin>
```

#### 3. Disk Plugin

Tương tự như memory and df plugin, người dùng uncomment LoadPlugin disk trong file collectd.conf để collectd có thể lấy thông tin về ổ đĩa.

```sh
  vi /etc/collectd/collectd.conf
```

<img src="http://i.imgur.com/nLCHlao.png">

Disk plugin thu thập thông tin về thống kê hiệu suất của ổ đĩa. Trên mỗi phân vùng, người dùng có thể nhìn thấy tốc độ đọc ghi của:

- merged (Operations/s)
- octets (Bytes/s)
- operation (Operations/s)
- time (Seconds/s)

Khi copy một file sang máy ubuntu, có thể thấy sự thay đổi trong octets, còn thông số trong merged, operation và time hầu như không có sự thay đổi.

<img src ="http://i.imgur.com/dThlyYR.png">

Để collectd có thể lấy dữ liệu từ sda, cấu hình trong file collectd.conf:

```sh
<Plugin "disk">
  # có thể that sda= sdb nếu như máy có nhiều ổ đĩa
  Disk "sda"
  Disk "/^hd/"
  IgnoreSelected false
</Plugin>
```
