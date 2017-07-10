# Plugin RRDtool


## 1. Mô tả

RRDtool plugin sử dụng để ghi giá trị metric vào RRD file sử dụng librrd

## 2 Cách cấu hình

```sh
LoadPlugin rrdtool
<Plugin "rrdtool">
  DataDir "/var/lib/collectd/rrd"
  CacheFlush 120
  WritesPerSecond 50
</Plugin>
```

## 3. Các lệnh sử dụng



Tham khảo:

[1] - https://collectd.org/wiki/index.php/Plugin:RRDtool

[2] - https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_rrdtool

[3] - https://collectd.org/wiki/index.php/Inside_the_RRDtool_plugin
