Trong trường hợp người dùng không muốn theo dõi hoạt động của một máy hoặc một plugin  nào đó, người dùng có thế xóa nó đi khỏi cơ sở dữ liệu của Graphite.

#### 1. Xóa giám sát một máy.

 Truy cập vào máy Graphite, vào thư mục /var/lib/graphite/whisper và kiểm tra xem nó đang giám sát những máy nào: 
 
 ```sh 
 /var/lib/graphite/whisper
 ll
 ```
 
 Kết quả: 
 
 ![](/images/huongdan_xoamay1.png)
 
 Sau đó dùng lệnh rm -rf để xóa máy người dùng muốn, ở đây mình xóa máy collectubuntu2
 
 ```sh
  rm -rf collectdubuntu2
 ```
 
 Kiểm tra lại số máy:
 
 ![](/images/huongdan_xoamay2.png)
 
#### 2. Xóa một plugin.

Tương tự như xóa một máy, người dùng vào thư mục /var/lib/graphite/whisper và vào một máy mà người dùng muốn xóa plugin:

```sh
cd /var/lib/graphite/whisper/collectdubuntu/
ll
```
Kết quả:

![](/images/huongdan_xoaplugin1.png)

Dùng lệnh rm -rf để xóa plugin muốn xóa, ở đây mình xóa *users plugin*

```sh 
	rm -rf users
```

Kiểm tra lại plugin

![](/images/huongdan_xoaplugin2.png)