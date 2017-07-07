# Plugin Notify email

## 1. Mô tả

Plugin notiy_email sử dụng thư viện ESMTP để gửi các cảnh báo tới địa chỉ email


## 2 Cách cấu hình

```sh
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
```

## 3. Các tùy chọn khi cấu hình:

 - `From Address`:

    Khai báo địa chỉ email sử dụng để gửi cảnh báo

 - `Recipient Address`:

    Khai báo địa chỉ email để nhận cảnh báo, có thể lặp lại khai báo này để thêm nhiều email
 
 - `SMTPServer Hostname`:

    Khai báo Hostname của SMTP Server

 - `SMTPPort Port`:

    Mặc định sử dụng port 25

 - `SMTPUser Username`:

    Khai báo User name để xác thực với mail server

 - `SMTPPassword Password`:

    Khai báo User password

 - `Subject Subject`:

    Khai báo tiêu để của mail. Sẽ có 2 biến có thể thay thê trong subject, thứ nhất là mức độ cảnh báo, thứ 2 là hostname.
    VD: [collectd] %s on %s!
    Subject email nhận được sẽ là [collectd] Warning on Host1!



Tham khảo:

[1] - https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_notify_email
