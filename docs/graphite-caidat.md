# Cài đặt Graphite trên Centos 7.

- Bước 1 : update hệ thống và cài đặt các phần mềm phụ trợ : 

    ```sh
    yum -y update
    yum install -y httpd net-snmp perl pycairo mod_wsgi python-devel git gcc-c++
    ```

- Bước 2 : Cài đặt các gói quản lý của Python : 

    ```sh
    yum install -y python-pip node npm
    ```

- Bước 3: Cài đặt Graphite qua pip :

    ```sh
    pip install 'django<1.6'
    pip install 'Twisted<12'
    pip install django-tagging
    pip install whisper
    pip install graphite-web
    pip install carbon

    ```


# Một số lỗi gặp trong khi cài đặt.

- Tại bước 3 khi cài đặt `graphite web` nếu gặp lỗi sau : 

    ```sh
    Perhaps you should add the directory containing `libffi.pc'
        to the PKG_CONFIG_PATH environment variable
        No package 'libffi' found
        c/_cffi_backend.c:15:17: fatal error: ffi.h: No such file or directory
        #include <ffi.h>

    ```

- Các fix : Cài thêm gói `python-cffi` :

    ```sh
    yum install python-cffi -y
    ```

- Thực hiện các lệnh sau để sao chép file cấu hình :

    ```sh
    cp /opt/graphite/examples/example-graphite-vhost.conf /etc/httpd/conf.d/graphite.conf
    cp /opt/graphite/conf/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf
    cp /opt/graphite/conf/storage-aggregation.conf.example /opt/graphite/conf/storage-aggregation.conf
    cp /opt/graphite/conf/graphite.wsgi.example /opt/graphite/conf/graphite.wsgi
    cp /opt/graphite/conf/graphTemplates.conf.example /opt/graphite/conf/graphTemplates.conf
    cp /opt/graphite/conf/carbon.conf.example /opt/graphite/conf/carbon.conf
    ```

- Thực hiện phân quyền cho thư mục `/opt/graphite/storage/`

    ```sh
    chown -R apache:apache /opt/graphite/storage/
    ```

- Dùng trình soạn thảo `vi` mở file `/opt/graphite/conf/storage-schemas.conf`

    ```sh
    vi /opt/graphite/conf/storage-schemas.conf
    ```

- Thêm những dòng sau vào section `[default]` :

    ```sh
    [default]
    pattern = .*
    retentions = 10s:4h, 1m:3d, 5m:8d, 15m:32d, 1h:1y
    ```

- Đồng bộ cơ sở sữ liệu :

    ```sh
    cd /opt/graphite/webapp/graphite
    sudo python manage.py syncdb
    ```

- Khởi chạy các dịch vụ :

    ```sh
    systemctl enable httpd
    systemctl start httpd
    /opt/graphite/bin/carbon-cache.py start
    ```

- Chạy Graphite server :

    ```sh
    /opt/graphite/bin/run-graphite-devel-server.py /opt/graphite/
    ```

- Kiểm tra :

    ```sh
    http://ip:8080
    ```