###1. Hướng dẫn upgrade collectd 5.5 

Tham khảo link sau: https://launchpad.net/~rullmann/+archive/ubuntu/collectd nếu muốn cài đặt collectd 5.5 từ source. 

Trong hướng dẫn này sẽ nói về cách upgrade collectd từ 5.4 lên 5.5

####Step1 : Kiểm tra phiên bản hiện tại và backup file collectd.conf
<img src="http://i.imgur.com/M8WYUKE.png">

    cp /etc/collectd/collectd.conf /etc/collectd/collectd.conf.bka


####Step2 : Add PPA vào software source

    add-apt-repository ppa:rullmann/collectd
  
  Ấn phím ENTER để thêm ppa
  <img src="http://i.imgur.com/gdoHU6f.png">
  
####Step3 : Update PPA
  apt-get update
####Step 4 : Cài đặt và upgrade collectd
  apt-get install collectd -y
  
  Chọn N để giữ những cài đặt trong file collectd.conf
    <img src="http://i.imgur.com/QEADgKc.png">
  
  apt-get upgrade collectd -y
  
####Step 5 : Kiểm tra lại phiên bản 
<img src="http://i.imgur.com/Nnyjv80.png">
