# I. Tổng quan về Graphite.

-  Graphite giúp chúng ta thực hiện 2 công việc . Thứ nhất là thu thập dữ liệu theo kiểu time-series data, thứ 2 là render đồ thị 
của dữ liệu này theo yêu cầu.

- Graphite không thực hiện thu thập dữ liệu cho bạn , tuy nhiên có một số công cụ bên ngoài biết làm cách nào để gửi được dữ liệu 
đến cho Graphite.

# II. Kiến trúc Graphite.

- Graphite bao gồm 3 thành phần như sau :
 <ul>
    <li>1. Carbon : Một dịch vụ mạng lắng nghe các số liệu đến. Nó lưu trữ các số liệu tạm thời trong bộ đệm bộ nhớ cache trong một thời gian ngắn trước khi xả chúng vào đĩa dưới dạng định dạng cơ sở dữ liệu Whisper.</li>
    <li>2. Whisper : Một thư viện cơ sở dữ liệu đơn giản để lưu dữ liệu chuỗi thời gian (tương tự trong thiết kế đến RRD)</li>
    <li>3. Một webapp của Django cho phép đồ thị theo yêu cầu sử dụng Cairo.</li>
 </ul>

- Hình ảnh dưới đây minh họa các thành phần cấu trúc của Graphite :

![Graphite-architect](/images/graphite-architecture.png)

# III. Các thành phần bên trong Graphite.

## 1. Carbon.

- Bất cứ khi nào đề cập  về thành phần Carbon trong Graphite giường như chúng ta luôn nói về dịch vụ Carbon Cache. Người mới sử dụng có thể không nhận ra thực sự chúng ta có 3 deamon riêng biệt được gọi chung là Carbon 
đó là : Carbon cache listener, Carbon relay và Carbon-aggregator. 

### 1.1. Carbon cache.

- Carbon cache deamon là quy trình làm việc khó nhất trong time-series . Nó được viết bằng Python dựa trên thư viện Twisted, một công cụ mang theo sự kiện. Nhưng nó không chỉ được miêu tả là một bộ nhớ cache đơn thuần. Carbon cache 
là một dịch vụ mạng chấp nhận các chỉ số gửi đi từ clients , lưu trữ tạm thời các số liệu trong bộ nhớ (bộ nhớ cache) , và sau đó ghi chúng vào đĩa như kiểu Whisper database files. Nó chấp nhận các metrics qua TCP hoặc UDP giống như kiểu plain text hoặc 
sử dụng giao thức ngầm của Python (một đinh djang tuần tự hiệu quả). Nếu bạn hỗ trợ một number distributed system , Graphite thậm chí hỗ trợ AMQP message bus. Bởi vì Graphite cần quyền truy cập của cả 2 số liệu đã tồn tại bên trong bộ nhớ, trình cache deamon cxung bao gồm một port 
mà ứng dụng web Graphite thăm dò các số liệu "hot" chưa được ghi lên đĩa.

- Các cài đặt cơ bản thường có thể nhận được một quy trình Carbon cache đơn. Mỗi bộ nhớ cache liên kết với lõi CPU của chính nó . Do đó nó có thể dễ dàng theo dõi một quá trình làm việc với bộ nhớ cache thông qua các công cụ đơn giản của UNIX giống như top hoặc ps.

### 1.2. Carbon relay.

- Giống như với tên gọi của nó Carbon relay được thiết kế để chuyển các metrics từ một quy trình Carbon này đến một quy trình Carbon khác . Bạn có thể nghĩ nó như là băng keo của hệ thống Graphite. Bất cứ lúc nào chúng ta cần phát triển cụm Graphite thì Carbon relay chắc chắn phải liên quan đến nó.

- Có 2 nhiệm vụ chúng mà Carbon relay được thiết kế đó là : Chuyển tiếp các metrics đến một deamon khác của Carbon và nhân rộng các metrics đến nhiều điểm đến. Điều này sẽ mở ra cánh cửa không giới hạn các mẫu và các trường hợp sử dụng nơi chúng ta cần thêm các chức năng như cân bằng tải 
hoặc nhân rộng Graphite cluster của chúng ta.

- Tùy vào tình hình mà chúng ta có thể sử dụng Carbon relay để mở rộng một máy chủ Graphite , dưới đây là một ví dụ điển hình :

![Carbon-relay](/images/Carbon-relay.png)

### 1.3. Carbon aggregator .

- Giả sử tại một thời điểm nào đó một trong các ứng dụng của bạn đang phát ra các số liệu ở quy mô bất thường . Bạn muốn tránh những khoảng trống trong đồ thị của bạn , kỹ thuật này không phải là một vấn đề với Graphite anyways nhờ các transformNULL chắc năng.

- Trong một trường hợp khác , chúng ta có thể muốn tổng hợp lại một bộ các metrics vào một metric đơn lẻ mới. Ví dụ như chúng ta muốn theo dõi độ trễ trung bình qua một loạt các máy chủ ứng dụng ? Graphite API sẽ cho phép chúng ta làm điều này một cách dễ dàng, nhưng nó có 
thể dẫn đến một hiệu suất đáng kể nếu như chúng ta yêu cầu Graphite làm trung bình các metrics trên hàng chục, hàng trăm hoặc gần như chắc chắn hàng nghìn máy chủ cùng một lúc .

- Carbon aggregator tập chung cả 2 tình huống này. Deamon này cho phép chúng ta xác định các quy tắc chỉ định một hoặc nhiều số liệu nguồn (sử dụng các ký tự đại diện) một aggregation method (tổng hoặc trung bình), 
số lượng thời gian (tính bằng giây) để đệm trước khi xuất ra kết quả và tên số liệu mới .

## 2. Whisper.

- Whisper là một cơ sở dữ liệu có kích thước cố định, tương tự như thiết kế và mục đích của RRD (round-robin-database). Cung cấp khả năng lưu trữ dữ liệu số nhanh và đáng tin cậy qua thời gian. Whisper cho phép độ phân giải cao hơn (giây mỗi điểm) của dữ liệu gần đây để phân hủy thành các độ phân giải thấp hơn để duy trì lâu dài dữ liệu lịch sử.

- Một hệ thống lưu trữ chuyên dụng gọi là Round Robin Database cho phép lưu trữ một lượng lớn các thông tin theo thời gian như nhiệt độ, băng thông mạng và giá cổ phiếu và ghi dữ liệu vào đĩa liên tục. Nó thực hiện điều này bằng cách tận dụng các nhu cầu thay đổi cho độ chính xác.

- Trong ngắn hạn, mỗi điểm dữ liệu là quan trọng: chúng tôi muốn có một bức tranh chính xác về mọi sự kiện đã xảy ra trong 24 giờ qua, có thể bao gồm các đột biến nhỏ trong việc sử dụng đĩa hoặc băng thông mạng (có thể chỉ ra một cuộc tấn công). Tuy nhiên về lâu dài, chỉ cần các xu hướng chung là đủ.

- Để tiết kiệm không gian, chúng ta có thể thu thập dữ liệu cũ bằng chức năng Hợp nhất (CF), thực hiện một số tính toán trên nhiều điểm dữ liệu để kết hợp nó vào một điểm duy nhất trong một khoảng thời gian dài hơn. Hãy tưởng tượng rằng chúng tôi lấy trung bình của 288 mẫu vào cuối mỗi 24 giờ; Trong trường hợp đó, chúng tôi chỉ cần 365 điểm dữ liệu để lưu trữ dữ liệu cho cả năm

- Nhưng RRD không chấp nhận các data bất thường, nếu metric A với mốc thời gian là 5:05:00 đến sau metric B với mốc thời gian 5:05:30, metric đến trước sẽ bị loại bỏ hoàn toàn bởi RRD ( điều này sẽ được thiết kế lại về sau). Whisper giải quyết thiết kế thiếu sót này một cách đặc biệt, và tại cùng một thời điểm như nhau, đơn giản hóa cấu hình và bố trí thời gian lưu trữ với mỗi database file.

## 3. Graphite web.

# Tham khảo .

- http://graphite.readthedocs.io/en/latest/overview.html

- https://github.com/hocchudong/ghichep-graphite-collectd

- references.