=================================

### I. Tìm hiểu về graphite
##### 1. Graphite : 
- Là 1 ứng dụng thu thập, lưu trữ và hiển thị thông tin máy chủ và các ứng dụng.
- Thư viện đồ họa nhiêu thành phần sử dụng để  hiển thị thông số hình ảnh theo thời gian thực
   
##### 2.Các thành phần
###### Graphite-webapp:
- Thiết kế các biểu đồ dữ liệu.
- Cung câp giao diện đồ họa  để hiển thị các thông số từ máy chủ và ứng dụng.
- Tạo đồ thị dựa trên dữ liệu mà nó nhận được
=> chỉ hiển thị biểu đồ không lưu trữ lại dữ liệu.

######  Carbon:
- Thành phần lưu trữ dữ liệu của graphite
- Xử lý dữ liệu được gửi qua câc tiến trình khác để thu thập và truyền tải số liệu thống kê.
	 
###### Whiper:
- Là thư viện CSDL của Graphite => sử dụng lưu thông tin nhận được.
- Cung cấp nhanh và tin cậy số liệu theo thời gian thực.
	 
##### 3. Các thành phần làm việc :
- Graphite chỉ thống kê thông tin dữ liệu dựa vào 2 thành phần là StatD,Collectd.

3.1.Collectd:
- Thu thập thông tin  thống  kê về các thành phần của máy chủ như : Ram,CPU,network theo thời gian thực
- Thu thập các thông tin tù các ứng dụng : Apache,Nginx,iptable,memcache,...
- Cug cấp các thông tin trước khi tạo các ứng dụng trên máy chủ  

3.2.StatD:
- Thu tập thông tin thông qua các cổng chạy trên  giao thức UDP => tổng hợp -> đưa lên Graphite.

### II. Cài đặt và sử dụng : 
#### Mô hình : 
  <img src="http://i.imgur.com/EenjRqY.png"></br>
 
#### Chuẩn bị cài đặt:
 

- Server
 
 - OS : Ubuntu server 14.04
 - Ram : > 512MB
 - HDD : 20GB
 - CPU : 2 CPU(VTx)
 - Ip : 172.16.69.71/24

- Client
 
 - OS : Ubuntu server 14.04
 - Ram : > 512MB
 - HDD : 20GB
 - CPU : 2 CPU(VTx)
 - Ip  : 172.16.69.73/24 </br>

#### 1. Cài đặt Graphite :
 
##### * Cập nhập OS và cài các gói:

```
sudo apt-get update
sudo apt-get install graphite-web graphite-carbon

``` 
##### * Cấu hình  CSDL với Django:
- cài PostgreSQL:

```
sudo apt-get install postgresql libpq-dev python-psycopg2
```		
- Create a Database User and a Database:
```
sudo -u postgres psql
CREATE USER graphite WITH PASSWORD 'password';
CREATE DATABASE graphite WITH OWNER graphite;
\q
```
##### *Cấu hình  Graphite-webapp :
```
sudo nano /etc/graphite/local_settings.py
```
- Sửa file:

```
SECRET_KEY = 'a_salty_string'
TIME_ZONE = 'Asia/Ho_Chi_Minh'
USE_REMOTE_USER_AUTHENTICATION = True
DATABASES = {
'default': {
'NAME': 'graphite',
'ENGINE': 'django.db.backends.postgresql_psycopg2',
'USER': 'graphite',
'PASSWORD': 'password',
'HOST': '127.0.0.1',
'PORT': ''
 }
}
```
- Đồng bộ dữ liệu:

```
sudo graphite-manage syncdb
```
##### * Cấu hình Carbon:
        
- Bật dịch vụ carbon 

```
sudo nano /etc/default/graphite-carbon
CARBON_CACHE_ENABLED=true
```		
- Sửa file :
sudo nano /etc/carbon/carbon.conf

```
ENABLE_LOGROTATION = True
```  
- Cài đặt và cấu hình Apache:

```
sudo apt-get install -y apache2 libapache2-mod-wsgi
```

- Tắt dịch vụ host ảo :
```
sudo a2dissite 000-default
```
- Next, copy the Graphite Apache virtual host file into the available sites directory:
```
sudo cp /usr/share/graphite-web/apache2-graphite.conf /etc/apache2/sites-available
```
- Enable host ảo:
```
sudo a2ensite apache2-graphite
```
- Khởi động lại dịch vụ Apache:
```
sudo service apache2 reload
```
- Truy cập vào : 
```
http://server_domain_name_or_IP
```
sẽ được giao diện như dưới :

<img src="http://i.imgur.com/6eUgKnM.png">

- Chọn tab graphite :

 <img src="http://i.imgur.com/YooahDo.png">	

### III Cài đặt  collectd:

- Cài collectd và các gói hỗ trợ:

```
sudo apt-get install collectd collectd-utils -y 
```  
- Sửa cấu hình trong collectd :

sudo nano /etc/collectd/collectd.conf

- Chỉnh để hiển thị các  plugin:

``` 
LoadPlugin apache
LoadPlugin cpu
LoadPlugin df
LoadPlugin entropy
LoadPlugin interface
LoadPlugin load
LoadPlugin memory
LoadPlugin processes
LoadPlugin rrdtool
LoadPlugin users
LoadPlugin write_graphite

----------------------------------------------------------------------
<Plugin apache>
<Instance "Graphite">
URL "http://172.16.69.204/server-status?auto"
Server "apache"
</Instance>
 </Plugin>
--------------------------------------------------------------------
 <Plugin df>
Device "/dev/sda"
MountPoint "/"
FSType "ext4"
</Plugin>
------------------------------------------------------------------

 <Plugin interface>
Interface "eth1"
IgnoreSelected false
</Plugin>

-----------------------------------------------------------
<Plugin write_graphite>
<Node "graphing">
Host "localhost"
Port "2003"
Protocol "tcp"
LogSendErrors true
Prefix "collectd."
StoreRates true
AlwaysAppendDS false
EscapeCharacter "_"
</Node>
</Plugin>
-------------------------------------------------------------------------
<Plugin network>
	 Listen "*" "2003"
</Plugin>
```
- Cấu hình host apache :
```
sudo nano /etc/apache2/sites-available/apache2-graphite.conf

```
```
<Location "/server-status">
        SetHandler server-status
        Require all granted
    </Location>
```

- Khởi động lại dịch vụ: 

```
sudo service apache2 reload
```

- Cấu hình store :

```
sudo nano /etc/carbon/storage-schemas.conf
```

```
[collectd]
pattern = ^collectd.*
retentions = 10s:1d,1m:7d,10m:1y
```

```
sudo service carbon-cache stop          ## wait a few seconds here
sudo service carbon-cache start


sudo service collectd stop
sudo service collectd start

```

#### III. Cài đặt  trên client : 

```
-----------------
apt-get install collect libjson-perl -y
apt-get update
```

- Load các plugin để hiển thị thông tin cần giám sát:

```
FQDNLookup true
Interval 10
ReadThreads 5
LoadPlugin syslog
<Plugin syslog>
    LogLevel info
</Plugin>
LoadPlugin battery
LoadPlugin cpu
LoadPlugin df
LoadPlugin disk
LoadPlugin entropy
LoadPlugin interface
LoadPlugin irq
LoadPlugin load
LoadPlugin memory
LoadPlugin network
LoadPlugin processes
LoadPlugin rrdtool
LoadPlugin swap
LoadPlugin users
<Plugin interface>
  Interface "eth0"
 # Interface "eth1"
 #Interface  "eth2"
 #Interface   
  IgnoreSelected false
</Plugin>
<Plugin network>
    # client setup:
   Server "$ipadds" "2003"
</Plugin>
<Plugin rrdtool>
    DataDir "/var/lib/collectd/rrd"
</Plugin>
Include "/etc/collectd/filters.conf"
Include "/etc/collectd/thresholds.conf"
```
Kết thúc quá trình cài đặt và cấu hình Graphite 

#### IV .Các tài liệu tham khảo: 

- https://www.digitalocean.com/community/tutorials/how-to-install-and-use-graphite-on-an-ubuntu-14-04-server
- https://www.digitalocean.com/community/tutorials/how-to-configure-collectd-to-gather-system-metrics-for-graphite-on-ubuntu-14-04
