###Mục lục

[Mở đầu](#modau)

[1. Memory Plugin](#memory)
- [1.1 Mô tả](#motamemory)
- [1.2 Cách cấu hình](#cauhinhmemory)
- [1.3 Minh họa](#minhhoamemory)
- [1.4 Mở rộng](#morongmemory)

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

[5. CPU Plugin](#plugincpu)
- [5.1 Mô tả](#moataplugincpu)
- [5.2 Cách cấu hình](#cauhinhplugincpu)
- [5.3 Minh họa](#minhhoaplugincpu)

[6. Load Plugin](#load)
- [6.1 Mô tả](#motaload)
- [6.2 Cách cấu hình](#cauhinhload)
- [6.3 Minh họa](#minhhoaload)
- [6.4 Mở rộng](#morongload)


[7. TCPconns Plugin](#tcpcon)
- [7.1 Mô tả](#motatcpcon)
- [7.2 Cách cấu hình](#cauhinhtcpcon)
- [7.3 Minh họa](#minhhoatcpcon)
- [7.4 Mở rộng](#morongtcpcon)

<a name="modau"></a>
#### Mở đầu

**Collectd** cung cấp một kho plugin để người dùng có thể sử dụng, người dùng có thể cấu hình trong file collectd.conf để lấy các thông số mà họ muốn. Sau khi **collectd** thu thập được dữ liệu nó sẽ truyền vào **Graphite**, **Graphite** thể hiện những thông số này dưới dạng biểu đồ.

Hình 1
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
```sh 
  LoadPlugin memory
```

<a name="minhhoamemory"></a>
##### 1.3 Minh họa

Hình 2
<img src ="http://i.imgur.com/4EC16cX.png">

Biểu đồ trên giao diện web của Graphite thể hiện thông tin về:
- buffered (1)
- cached (2)
- free (3)
- used (4)

Để kiểm tra các thông số này trên máy ubuntu có thể dùng lệnh: free, top...

Hình 3

<img src="http://i.imgur.com/69ceHgf.png">


Chú ý: 
```sh 
  used(4) = used(d) = used(a) - buffered(b)- cached(c)
                160 = 358 -35 - 162

```

<a name="morongmemory"></a>
##### 1.4 Mở rộng

Ở bản 5.5 người dùng có thể cấu hình để collectd có thể hiện thị thông số thu thập được dưới dạng phần trăm (%)

```sh 
	vi /etc/collectd/collectd.conf
```

```sh 
	<Plugin memory>
		ValuesAbsolute false
        ValuesPercentage true
	</Plugin>
```

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

```sh
  LoadPlugin df
```

<a name="minhhoadf"></a>
##### 2.3 Minh họa.

Hình 4
<img src="http://i.imgur.com/aK998kV.png">

```sh
1: thể hiện thông số của thư mục dev

2: thể hiện thông số của thư mục root

3: thể hiện thông số của thư mục run

4: thể hiện thông số của thư mục /run/lock

5: thể hiện thông số của thư mục /run/shm

6: thể hiện thông số của thư mục /run/user 

7: thể hiện thông số của thư mục /sys/fs/cgroup
```

Trên mỗi thư mụcngười dùng có thể thấy các thông số:
- free (1.1)
- reserved (1.2)
- used (1.3)

Trong đó total = free + reserved + used 

Để kiểm tra trên máy ubuntu ổ đĩa đã được sử dụng bao nhiêu và còn trống bao nhiêu sử dụng lệnh **df -m** để dữ liệu hiển thị dưới dạng MB.

Hình 5

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
```sh
LoadPlugin disk
```

<a name="minhhoadisk"></a>
##### 3.3 Minh họa.

Hình 6
<img src="http://i.imgur.com/6AotRFJ.png">

```sh
1: thể hiện thông số của ổ đĩa sda

2: thể hiện thông số của phân vùng sda1 trên sda

3: thể hiện thông số của phân vùng sda2 trên sda

4: thể hiện thông số của phân vùng sda5 trên sda

5: thể hiện thông số của ổ đĩa sdb

6: thể hiện thông số của phân vùng sdb1 trên sdb
```
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

Hình 7

<img src ="http://i.imgur.com/gyeGfmy.png">


Hình 8

<img src="http://i.imgur.com/8N4EIIL.png">

Hình 9

<img src="http://i.imgur.com/vIZuwRX.png">


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

```sh 
LoadPlugin network

```

<a name="minhhoainterface"></a>

#####4.3 Minh họa.

Hình 10
<img src="http://i.imgur.com/Afu9AUE.png"></a>

Trên mỗi card mạng, người dùng có thể thu thập thông tin :

```sh

1: errors (errors/s) : số lỗi trên một giây.

2: octets (bit/s) tốc độ gửi và nhận dữ liệu trên một card mạng.

3: packets (packets/s): số package gửi và nhận trên mỗi card mạng.

```
<a name="moronginterface"></a>
#####4.4 Mở rộng.

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

Hình 11
<img src="http://i.imgur.com/6IMjwLx.png">

Hình 12

<img src="http://i.imgur.com/n0ZVstv.png"> 


<a name="plugincpu"></a>
#### 5. Plugin CPU


<a name="motaplugincpu"></a>
##### 5.1 Mô tả
Dùng để hiển thị tình trạng CPU đang sử dụng như thế nào.


<a name="cauhinhplugincpu"></a>
##### 5.2 Cách cấu hình 

```sh
# Khai bao su dung plugin cpu trong file config cua collectd tren client
LoadPlugin cpu

# Cac khai bao mo rong
<Plugin cpu>
  ReportByCpu false # Hiển thị CPU chung khi máy chủ có nhiều CPU
  ReportByState true # Hien thi tat ca cac tham so ve tinh trang su dung CPU nhu:  "system", "user" and "idle
  ValuesPercentage true # Hien thi theo phan tram (%) thay vi hien thi Jiffies mac dinh
</Plugin>
```


<a name="minhhoaplugincpu"></a>
##### 5.3 Minh họa
Kết quả của plugin khi quan sát trên biểu đồ

Hình 13 

![plugincpu](/images/pluginCPU1.png)


- Các tham số về CPU hiển thị theo dạng phần trăm (được thiết lập với tùy chọn `ValuesPercentage true`)
- Các giá trị trong hình trên 
```sh
1 : là phầm trăm CPU ở trạng thái idle
2 : phần trăm CPU mà user đang sử dụng.
3 : biểu đồ thể hiện phần trăm CPU ở trạng thái idle
4 : biểu đồ thể hiện phần trăm CPU mà user đang sử dụng.
5 : Kết quả của lệnh top về phần trăm CPU ở trạng thái idle
6 : Kết quả của lệnh top về phần trăm CPU mà user đang sử dụng.
```

<a name="load"></a>
#### 6. Load Plugin.

<a name="motaload"></a>
#####6.1 Mô tả.

Load plugin thu thập dữ liệu về tải hệ thống. Những con số này đưa ra một cái nhìn tổng quán về việc sử dụng máy. 

<a name="cauhinhload"></a>
#####6.2 Cách cấu hình.

```sh 
	vi /etc/collectd/collectd.conf
```

```sh
# Khai bao su dung plugin load trong file config cua collectd tren client
LoadPlugin load

# Cac khai bao mo rong
<Plugin load>
  ReportRelative true # thông sổ hiện thị là tải hệ thống chia cho số lõi của CPU có sẵn
</Plugin>
```

<a name="minhhoaload"></a>
#####6.3 Minh họa.

Hình 14 

![load](/images/pluginload1.png)

```sh 
1: tải hệ thống trong 15 phút
2: tải hệ thống trong 5 phút
3: tải hệ thống trong 1 phút
4: load-relative xuất hiện khi cấu hình trong file collectd.conf 'ReportRelative true'
```

Người dùng có thể dùng lệnh uptime, top để kiểm tra tải hệ thống trên máy.

Hình 15

![load](/images/pluginload2.png)

<a name="morongload"></a>
#####6.4 Mở rộng
 
Khi người dùng cấu hình 'ReportRelative true" dữ liệu trên biểu đồ là tải hệ thống chia cho số CPU core
```sh
<Plugin load>
  ReportRelative true # thông sổ hiện thị là tải hệ thống chia cho số lõi của CPU có sẵn
</Plugin>
```
Để kiểm tra số CPU core, người dùng có thể sử dụng câu lệnh nproc

Hình 16

 ![load](/images/pluginload4.png)
 
 Trong trường hợp này số CPU core bằng 1, nên số liệu trên biểu đồ bằng tải hệ thống chia cho 1.
 
<a name="tcpcon"></a>
#### 7. TCPconns Plugin.
 
<a name="motatcp"></a>
##### 7.1 Mô tả.

TCPconns plugin thu thập dữ liệu về tổng số lượng kết nối TCP trên một port cụ thể hoặc tất cả các port.

<a name="cauhinhtcpcon"></a>
##### 7.2 Cách cấu hình.

```sh
# Khai bao su dung plugin cpu trong file config cua collectd tren client
LoadPlugin tcpconns

# Cac khai bao mo rong
<Plugin tcpconns>
	AllPortsSummary true # lấy giữ liệu về tổng số kết nối tcp trên tất cả các port
</Plugin>
```

<a name="minhhoatcpcon"></a>
#####7.3 Minh họa.

Hình 17

![tcpcon](/images/plugintcp1.png)

```sh
1: các kết nối tcp đã đóng
2: các kết nối tcp đang chờ để đóng
3: các kết nối tcp đang đóng
4: cổng đã sẵn sàng nhận/ gửi dữ liệu với tcp
5: các kết nối đang ở trạng thái chờ đợi 1 ACK cho một FIN đã gửi hoặc là chờ đợi một yêu cầu kết thúc kết nối
6: các kết nối đã nhận được một ACK cho yêu cầu của mình để chấm dứt kết nối
7: các kết nối đã gửi FIN riêng của mình và đang chờ đợi 1 ACK.
8: đang đợi yêu cầu kết nối từ một TCP và cổng bất kỳ.
9: đang đợi tcp ở xa gửi lại một tin báo nhận sau khi đã gửi cho TCP ở xa đó một tin báo nhận kết nối.
10: đang đợi TCP ở xa gửi lại một gói tin TCP với các cờ SYN và ACK được bật
11: đang đợi qua đủ thời gian để chắc chắn là TCP ở xa nhận được tin nhắn được tín báo nhận về yêu cầu kết thúc của nó.

``` 


Để kiểm tra các kết nối tcp, người dùng có thể dùng lệnh:

```sh
	 netstat -ant | awk '{print $6}' | sort | uniq -c | sort -n
```

Hình 18 

![tcpcon](/images/plugintcp2.png)


<a name="morongtcpcon.png></a>
#####7.4 Mở rộng.

Thay vì thu thập số lượng các kết nối TCP trên tất cả các cổng người dùng có thể cấu hình để collectd có thể thu thập các kết nối TCP từ một port.

```ssh
	<Plugin "tcpconns">
	
	ListeningPorts false 	# Không lấy dữ liệu từ tất cả các port
	
	LocalPort "25" 	#tính số kêt nối trên port nội bộ (25 : port của mail)
	
	RemotePort "25" 	#tính số kêt nối trên port bên ngoài
	</Plugin>
```