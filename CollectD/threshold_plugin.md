# Plugin Threshold


## 1. Mô tả

Plugin threshold cho phép tạo và gửi đi cảnh báo khi có vấn đề được ghi nhận trong quá trình giám sát của collectd. Các plugin khác có thể cấu hình để nhận cảnh báo và thực hiện các hành động tiếp theo. 
Mỗi khi giá trị vượt ngưỡng, cảnh báo được gửi đi, khi giá trị trở lại ngưỡng thì cảnh báo "OK" được gửi đi.

## 2 Cách cấu hình

```sh
LoadPlugin "threshold"
 <Plugin "threshold">
   <Type "foo">
     WarningMin    0.00
     WarningMax 1000.00
     FailureMin    0.00
     FailureMax 1200.00
     Invert false
     Instance "bar"
   </Type>
   
   <Plugin "interface">
     Instance "eth0"
     <Type "if_octets">
       FailureMax 10000000
       DataSource "rx"
     </Type>
   </Plugin>
   
   <Host "hostname">
     <Type "cpu">
       Instance "idle"
       FailureMin 10
     </Type>
   
     <Plugin "memory">
       <Type "memory">
         Instance "cached"
         WarningMin 100000000
       </Type>
     </Plugin>
   
     <Type "load">
        DataSource "midterm"
        FailureMax 4
        Hits 3
        Hysteresis 3
     </Type>
   </Host>
</Plugin>
```

Để xác định giá trị được gửi cảnh báo, ta dùng các block `Host`, `Plugin`, `Type`.
Một value được xác định bởi một `name`, hay còn gọi là `identifier`, một identifier có 5 phần, gồm:
 - host
 - plugin
 - plugin instance (optional)
 - type
 - type instance (optional)

 VD: c0f671e9-9353-49dd-954a-e7f783f5660f/virt-instance-00000015/disk_octets-vda

 - `c0f671e9-9353-49dd-954a-e7f783f5660f`: host là id máy ảo
 - `virt`: tên plugin
 - `instance-00000015`: plugin instance là tên máy ảo
 - `disk_octets`: metric type
 - `vda`: type instance là tên ổ đĩa được lấy metric

## 3. Các tùy chọn khi cấu hình

 `FailureMax Value
  WarningMax Value`:

  Đặt ngưỡng chặn trên cho metric. Nếu giá trị vượt ngưỡng FailureMax, một cảnh báo "FAILURE" sẽ được tạo. Nếu giá trị vượt ngưỡng "WarningMax" nhưng nhở hơn "FailureMax" một cảnh báo WARNING sẽ được tạo.
 
 `FailureMin Value
  WarningMin Value`:

  Đặt ngưỡng chặn dưới cho metric. Nếu giá trị vượt ngưỡng FailureMin, một cảnh báo "FAILURE" sẽ được tạo. Nếu giá trị vượt ngưỡng "WarningMin" nhưng nhở hơn "FailureMin" một cảnh báo WARNING sẽ được tạo.
 
 `DataSource DSName`:

  Một số data có thể có nhiều datasource, vd `if_octets` có `rx`(số bytes đi vào NIC) và `tx` (số bytes đi ra khỏi NIC), hoặc `disk_ops`, có datasource `read` và `write`.
  Nếu muốn đặt threshold cho một datasource cụ thể, dùng tùy chọn này.

 `Invert true|false`:

  Nếu set là `true` sẽ đổi ngược lại các khoảng giá trị, VD giá trị giữa FailureMin và FailureMax sẽ trở thành Failure. Mặc định option này là False.

 `Persist true|false:

  - Nếu là `true`, cảnh báo sẽ được tạo với mỗi giá trị nằm ngoài ngưỡng.
  - Nếu là `false`, cảnh báo sẽ được tạo khi giá trị nằm ngoài ngưỡng mà giá trị trước đó là WARNING hoặc FAILURE.

 `PersistOK true|false`:

  - Nếu là `true`, cảnh báo sẽ được tạo với mỗi giá trị nằm trong ngưỡng.
  - Nếu là `false`, cảnh báo sẽ được tạo khi giá trị nằm trong ngưỡng mà giá trị trước đó là OK.

 `Percentage true|false`:

  Nếu set `true`, giá trị lớn nhất và nhỏ nhất được thể hiện bằng %

 `Hits Value`:

  Khai báo số lần vượt ngưỡng liên tiếp cần đạt tới trước khi gửi cảnh báo

 `Hysteresis Value`
 
  Khai báo khoảng dao động cho threshold, tránh trường hợp giá trị dao động liên tục quanh nguõng cảnh báo.
  VD:
    WarningMax 100.0
    Hysteresis 1.0
  Cảnh báo chi gửi đi khi giá trị vượt quá 101 và trở về OK khi giá trị dưới 99.

 `Interesting true|false`

  Nếu set true, một cảnh báo FAILURE sẽ được gửi khi các giá trị không còn được update và bị xóa khỏi cache. Nếu set false, bỏ qua cảnh báo
 
Tham khảo:

[1] - https://collectd.org/documentation/manpages/collectd-threshold.5.shtml

[2] - https://www.netways.de/fileadmin/images/Events_Trainings/Events/OSMC/2015/Slides_2015/collectd_Thresholds_Plugin_and_Icinga_-_Florian_Forster.pdf

[3] - https://collectd.org/documentation/manpages/collectd.conf.5.shtml#threshold_configuration

[4] - https://collectd.org/wiki/index.php/Notifications_and_thresholds

