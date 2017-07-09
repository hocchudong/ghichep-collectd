# Hướng dẫn thiết lập cảnh báo cho VM

## 1. Mô tả

Hướng dẫn sử dụng collectd để gửi cảnh báo qua email cho admin khi metric của VM đạt ngưỡng đặt trước.

## 2 Cách cấu hình
Sử dụng 3 plugin có sẵn của collectd:
 - [virt](virt_plugin.md)
 - [threshold](threshold_plugin.md)
 - [notify_email](notify_email_plugin.md)

## 2.1. Sửa file `/etc/collectd/collectd.conf`

```sh
FQDNLookup true
LoadPlugin threshold
LoadPlugin libvirt
LoadPlugin notify_email

<Plugin "notify_email">
 From "notify_email@email.com"
 Recipient "receiver@email.com"
 SMTPServer "smtp.notification.com"
 SMTPUser "notify_email"
 SMTPPort "25"
 Subject "[collectd] %s on %s!"
 SMTPPassword "notify_email_password"
</Plugin>

<Plugin exec>
 NotificationExec "nobody:nogroup" "/usr/lib/collectd/notify.sh"
</Plugin>

<Plugin "threshold">
<Host "compute1">
 <Plugin "memory">
       <Type "memory">
         Instance "used"
         WarningMin 100000000
         WarningMax 1200000000
       </Type>
 </Plugin>
</Host>

<Plugin "virt">
        <Type "if_octets">
         DataSource "tx"
         WarningMin 100
         WarningMax 1200
       </Type>
</Plugin>

</Plugin>

<Plugin libvirt>
    RefreshInterval 120
    Connection "qemu:///system"
    HostnameFormat "uuid"
    InterfaceFormat "address"
</Plugin>
```

## 2.2. Khởi động lại collect
`service collectd restart`

## 2.3. Đẩy tải trên VM và kiểm tra email thông báo
![notify_email](../images/notify_email/notify_email_1.png)



Tham khảo:

[1] - https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_notify_email
