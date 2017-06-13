# Ghi chép về Carbon
Carbon là mọt thành phần của Graphite, nhận các metric, cache các metric này vào bộ nhớ memory (RAM), trước khi đẩy xuống storage backend để lưu trữ, Graphite web cũng có thể query dữ liệu trực tiếp trên lớp cache này.
![Mo hinh](../images/carbon/overview.png)

Carbon bao gồm các daemon sau:
 
## 1. Carbon-cache
carbon-cache sẽ cache các metric trong RAM mỗi khi nhận được metric mới, sau đó flush xuống storge backend theo từng khoảng thời gian(backend mặc định là whisper). Nó cũng cho phép query các metric datapoint in-memory, giúp Graphite web app có thể sử dụng các "hot data" metric .

Khi số lượng metric tăng lên, một daemon carbon-cache không thể xử lý hết các IO load. Để mở rộng, chạy các instance carbon-cache đằng sau daemon carbon-aggregator hoặc carbon-relay.

Cấu hình:
`carbon.conf`: khai báo các port, giao thức và phương thức để nhận metric
`storate-schemas.conf`: khai báo các policy để lưu trữ metric và lọc các metric được lưu trữ dựa trên regex pattern.

## 2. Carbon-relay
carbon-relay đảm nhiệm 2 vai trò: nhân bản và phân tán.
- Với cơ chế `RELAY_METHOD = rules`, carbon-relay sẽ chuyển tiếp các metric đến các backend carbon-cache trên nhiều host.
- Với cơ chế `RELAY_METHOD = consistent-hashing`, carbon-relay sẽ chuyển tiếp các metric tới các carbon-cache backend thông qua các quy tắc được định trong trường `DESTINATIONS`

Cấu hình:
`carbon.conf`: định nghĩa host và port nhận metric.
`relay-rules.conf`: định nghĩa ra các metric match với mẫu regex nào thì sẽ được đẩy về host carbon-cache tương ứng

## 3. Carbon-aggregator
daemon này đặt ở trước carbon-cache để buffer các metric trước khi đẩy vào whisper. Nó giúp làm giảm I/O load và kích thước file trên whisper bằng cách định nghĩa các khoảng thời gian và các hàm để tập hợp metric(sum hoặc average) đối với các metric khớp với mẫu cho trước. Sau 1 khoảng thời gian, các metric sau khi được aggregate sẽ được đẩy xuống carbon-cache.

Cấu hình:
`carbon.conf`: định nghĩa host và port nhận metric.
`aggregation-rules.conf`: định nghĩa khoảng thời gian và hàm để thực hiện aggregate cho các metric khớp với các regex pattern.
`rewrite-rules.conf`: cho phép định nghĩa các regex pattern, khi metric khớp với pattern đó sẽ được viết lại dựa trên đoạn text được định nghĩa trước.

Tham khảo:

[1] - http://graphite.readthedocs.io/en/latest/carbon-daemons.html

[2] - https://www.franklinangulo.com/blog/2014/6/6/graphite-series-6-carbon-aggregators

[3] - http://syntaxi.net/2014/03/01/graphite-relay/