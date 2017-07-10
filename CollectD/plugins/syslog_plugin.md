# Plugin Syslog


## 1. Mô tả

- plugin để ghi log các sự kiện hoặc cảnh báo được gửi tới collectd
- Phiên bản OS sử dụng là Ubuntu 14.04.5, kernel 4.4.0-79-generic.
- Phiên bản collectd sử dụng là collectd 5.5.3.1.

## 2. Cách cấu hình

Cấu hình theo `NotificationExec`

```sh
LoadPlugin syslog
<Plugin syslog>
LogLevel warning
NotifyLevel WARNING
</Plugin>

```
## 3. Các tùy chọn khi cấu hình
`LogLevel debug|info|notice|warning|err`

Tất cả các sự kiện được thu thập bởi collectd với các mức độ `notice, warning, err` sẽ được đưa vào syslog. Lưu ý tùy chọn này chỉ có thể thực hiện nếu collectd được chạy ở chế độ debug

`NotifyLevel OKAY|WARNING|FAILURE`

Các cảnh báo thu thập bới collectd sẽ được gửi tới syslog
- `OKAY`: Tất cả cảnh báo được gửi tới syslog.
- `WARNING`: Tất cả cảnh báo WARNING và FAILURE được gửi tới syslog, cảnh báo `OKAY` không được gửi.
- `FAILURE`: chỉ gửi cảnh báo FAILURE tới syslog.


Tham khảo:

[1] - https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_syslog
