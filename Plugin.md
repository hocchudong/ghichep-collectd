###Mục lục

[Mở đầu](#modau)

[1. Memory Plugin](#memory)
- [1.1 Mô tả](#motamemory)
- [1.2 Cách cấu hình](#cauhinhmemory)
- [1.3 Minh họa](#minhhoamemory)

[2. df Plugin](#df)
- [2.1 Mô tả](#motadf)
- [2.2 Cách cấu hình](#cauhinhdf)
- [2.3 Minh họa](#minhhoadf)
- [2.4 Mở rộng](#morongdf)

[3. Disk Plugin](#disk)
- [3.1 Mô tả](#motadisk)
- [3.2 Cách cấu hình](#cauhinhdisk)
- [3.3 Minh họa](#minhhoadisk)
- [3.4 Mở rộng](#morongdisk)

[4. Interface Plugin](#interface)
- [4.1 Mô tả](#motainterface)
- [4.2 Cách cấu hình](#cauhinhinterface)
- [4.3 Minh họa](#minhhoainterface)
- [4.4 Mở rộng](#moronginterface)

<a name="modau"></a>

#### Mở đầu

**Collectd** cung cấp một kho plugin để người dùng có thể sử dụng, người dùng có thể cấu hình trong file collectd.conf để lấy các thông số mà họ muốn. Sau khi **collectd** thu thập được dữ liệu nó sẽ truyền vào **Graphite**, **Graphite** thể hiện những thông số này dưới dạng biểu đồ.

<img src="http://i.imgur.com/VNIrykz.png">



<a name="memory"></a>
#### 1. Memory Plugin.
<a name="motamemory"></a>
##### 1.1 Mô tả.

Memory plugin thu thập thông tin về bộ nhớ  vật lý của máy ví dụ như cached, free, used và buffered.

<a name="cauhinhmemory"></a>
##### 1.2 Cách cấu hình.

Để collectd có thể thu thập được dữ liệu về bộ nhớ vật lý, người dùng phải uncomment dòng LoadPlugin memory trong file collectd.conf
```sh
  vi /etc/collectd/collectd.conf
```
<img src="http://i.imgur.com/24GmsHg.png">

<a name="minhhoamemory"></a>
##### 1.3 Minh họa

<img src ="http://i.imgur.com/4EC16cX.png">

Biểu đồ trên giao diện web của Graphite thể hiện thông tin về:
- buffered (1)
- cached (2)
- free (3)
- used (4)

Để kiểm tra các thông số này trên máy ubuntu có thể dùng lệnh: free, top...

<img src="http://i.imgur.com/69ceHgf.png">


Note: used (4) trong biểu đồ là used (a) của memory khi người dùng sử dụng lệnh free sau khi trừ đi buffered(b) và cached(a).


<a name="df"></a>
#### 2. df Plugin.

<a name="motadf"></a>
##### 2.1 Mô tả.

df plugin thu thập thông tin về việc sử dụng hệ thống file. Ví dụ trong một phân vùng, người dùng đã sử dụng hết bao nhiêu không gian và bao nhiêu không gian có sẵn để sử dụng.

<a name="cauhinhdf"></a>
##### 2.2 Cách cấu hình.

Để collectd có thể thể dữ liệu về disk free, người dùng phải cấu hình trong file collectd.conf , uncomment LoadPlugin df

```sh
  vi /etc/collectd/collectd.conf
```

<img src= "http://i.imgur.com/nLCHlao.png">

<a name="minhhoadf"></a>
##### 2.3 Minh họa.

<img src="http://i.imgur.com/aK998kV.png">

1: thể hiện thông số của thư mục dev

2: thể hiện thông số của thư mục root

3: thể hiện thông số của thư mục run

4: thể hiện thông số của thư mục /run/lock

5: thể hiện thông số của thư mục /run/shm

6: thể hiện thông số của thư mục /run/user 

7: thể hiện thông số của thư mục /sys/fs/cgroup

Trên mỗi thư mụcngười dùng có thể thấy các thông số:
- free (1.1)
- reserved (1.2)
- used (1.3)

Trong đó total = free + reserved + used 

Để kiểm tra trên máy ubuntu ổ đĩa đã được sử dụng bao nhiêu và còn trống bao nhiêu sử dụng lệnh **df -m** để dữ liệu hiển thị dưới dạng MB.

<img src="http://i.imgur.com/WSQt0AQ.png">



<a name="morongdf"></a>
##### 2.4 Mở rộng.

Để collectd có thể thu thập dữ liệu từ tất cả các file hệ thống, người dùng cấu hình trên file collectd.conf như sau:
```sh
<Plugin "df">
  IgnoreSelected true
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

<a name="disk"></a>
#### 3. Disk Plugin.

<a name="motadisk"></a>
##### 3.1 Mô tả.

Disk plugin thu thập thông tin hiệu suất của ổ đĩa.

<a name="cauhinhdisk"></a>
##### 3.2 Cách cấu hình.

Tương tự như memory and df plugin, người dùng uncomment LoadPlugin disk trong file collectd.conf để collectd có thể lấy thông tin về ổ đĩa.

```sh
  vi /etc/collectd/collectd.conf
```

<img src="http://i.imgur.com/nLCHlao.png">

<a name="minhhoadisk"></a>
##### 3.3 Minh họa.

<img src="http://i.imgur.com/6AotRFJ.png">

1: thể hiện thông số của ổ đĩa sda

2: thể hiện thông số của phân vùng sda1 trên sda

3: thể hiện thông số của phân vùng sda2 trên sda

4: thể hiện thông số của phân vùng sda5 trên sda

5: thể hiện thông số của ổ đĩa sdb

6: thể hiện thông số của phân vùng sdb1 trên sdb

Trên mỗi phân vùng, người dùng có thể nhìn thấy tốc độ đọc ghi của:

- merged (Operations/s) (1.1)
- octets (Bytes/s) (1.2)
- operation (Operations/s) (1.3)
- time (Seconds/s) (1.4)

<a name="morongdisk"></a>
##### 3.4 Mở rộng.

Để collectd có thể lấy dữ liệu từ sda, cấu hình trong file collectd.conf:

```sh
<Plugin "disk">
  # có thể thay sda= sdb nếu như máy có nhiều ổ đĩa
  Disk "sda"
  Disk "/^hd/"
  IgnoreSelected false
</Plugin>
```

Nếu người dùng muốn collectd thu thập dữ liệu từ tất cả các ổ trong trường hợp máy có nhiều ổ, chỉ cần uncomment dòng LoadPlugin disk trong file collectd.conf mà không cần phải cấu hình gì khác thêm.

Khi copy một file sang máy ubuntu, có thể thấy sự thay đổi trong octets, còn thông số trong merged, operation và time hầu như không có sự thay đổi.

Khi để speed là unlimited, tốc độ viết trong octets tăng mạnh, sau đó để giới hạn speed, tốc độ viết vẫn tăng nhưng tăng ít hơn. 



<img src ="http://i.imgur.com/gyeGfmy.png">



<img src="http://i.imgur.com/8N4EIIL.png">


<img src="http://i.imgur.com/vIZuwRX.png">


<a name="interface"></a>
[4. Interface Plugin](#interface)
- [3.1 Mô tả](#motainterface)
- [3.2 Cách cấu hình](#cauhinhinterface)
- [3.3 Minh họa](#minhhoainterface)
- [3.4 Mở rộng](#moronginterface)


#### 4. Interface Plugin

<a name="motainterface"></a>
##### 4.1 Mô tả

Interface plugin thu thập dữ liệu về lưu lượng truy cập, số lượng gói trên mỗi giây và lỗi xảy ra trên các card mạng. 

<a name="cauhinhinterface"></a>
##### 4.2 Cách cấu hình.

Người dùng cấu hình trên file collectd.conf bằng cách uncomment dòng LoadPlugin Interface

```sh
  vi /etc/collectd/collectd.conf
```

<img src="http://i.imgur.com/knqy110.png">

<a name="minhhoainterface"></a>

4.3 Minh họa.

<img src="http://i.imgur.com/Afu9AUE.png"></a>

Trên mỗi card mạng, người dùng có thể thu thập thông tin :

1: errors (errors/s) : số lỗi trên một giây.

2: octets (bit/s) tốc độ gửi và nhận dữ liệu trên một card mạng.

3: packets (packets/s): số package gửi và nhận trên mỗi card mạng.

<a name="moronginterface"></a>
4.4 Mở rộng.

Người dùng có thể cấu hình để collectd thu thập dữ liệu từ một card mạng hoặc tất cả các card mạng.

Để collectd thu thập dữ liệu từ một card mạng, cấu hình trên file collectd.conf như sau:

```sh
<Plugin "interface">
  Interface "eth0"
  IgnoreSelected false
</Plugin>
```

Để collectd thu thập dữ liệu trên tất cả các card mạng, cấu hình:

```sh
<Plugin "interface">
  Interface "lo"
  Interface "sit0"
  IgnoreSelected true
</Plugin>
```

Khi copy một tài liệu sang máy, người dùng có thể nhìn thìn tốc độ nhận trên octets trong interface có sự thay đổi rõ rệt, tốc độ nhận ở octets gần xấp xỉ với 1024k/s

<img src="http://i.imgur.com/6IMjwLx.png">

<img src="http://i.imgur.com/n0ZVstv.png"> 
