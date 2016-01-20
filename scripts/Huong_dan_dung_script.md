
# Hướng dẫn  sử dụng các file script

##### 1. Tải các gói script từ git:

```
git clone https://github.com/vdcit/GRAPHITE
```
##### 2. Di chuyển vào thư mục GRAPHITE và cấp quyền :

```
cd GRAPHITE
chmod +x *.sh 
```
##### 3. Chạy  các file script :
###### 3.1.  Trên máy server:
####### 3.1.1: cài đặt Graphite
``` 
bash graphite-server.sh
```
####### 3.1.2: Cài đặt collectd
```
bash collectd-server.sh
```
###### 3.2. Trên Client chạy file collectd :
  
```
bash collectd.sh
```
##### 4. Hoàn thành :
 Truy cập vào  đỉa chỉ:
 ```
  http://ip_server
 ```  
để kiểm tra script
