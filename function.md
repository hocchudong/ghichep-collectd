###Mục lục

[1. Sum function](#sum)
- [1.1 Mô tả](#motasum)
- [1.2 Minh họa](#minhhoasum)

[2. Average function](#average)
- [2.1 Mô tả](#motaaverage)
- [2.2 Minh họa](#minhhoaaverage)

[3. Product function](#product)
- [3.1 Mô tả](#motaproduct)
- [3.2 Minh họa](#minhhoaproduct)

[4. Min value function](#minvalue)
- [4.1 Mô tả](#motaminvalue)
- [4.2 Minh họa](#minhhoaminvalue)

[5. Max value function](#maxvalue)
- [5.1 Mô tả](#motamaxvalue)
- [5.2 Minh họa](#minhhoamaxvalue)

[6. Difference function](#difference)
- [6.1 Mô tả](#motadifference)
- [6.2 Minh họa](#minhhoadifference)

[7. Ratio function](#ratio)
- [7.1 Mô tả](#motaratio)
- [7.2 Minh họa](#minhhoaratio)

<a name="sum"></a>
#### 1. Sum function.

<a name="motasum"></a>
#####1.1 Mô tả.
- Function sum giúp người dùng tính tổng các thông số được chọn

<a name="minhhoasum"></a>
#####1.2 Minh họa.

- Người dùng chọn thông số muốn tính tổng. Ở đây tôi chọn memory: used, buffered, userd và free. Sau đó chọn Apply Fuction-> Combine-> Sum.

Hình 1
![sum](/images/functionSum1.png)

Hình 2
![sum](/images/functionSum2.png)

Chú ý: Trong đó sumSeries(collectdServer.memory.memory-buffered,collectdServer.memory.memory-cached,collectdServer.memory.memory-free,collectdServer.memory.memory-used)= total RAM = 1024 M
<a name="average"></a>
####2. Average function.

<a name="motaaverage"></a>
#####2.1 Mô tả.
- Funtion average giúp người dùng tính trung bình thông số được chọn.

<a name="minhhoaaverage"></a>
#####2.2 Minh họa.

- Người dùng chọn các thông số muốn tính trung bình. Ở đây tôi chọn load.shortterm longterm và midterm. Sau đó chọn Apply Fuction-> Combine-> Average.

Hình 3
![average](/images/functionAverage1.png)

Hình 4
![average](/images/functionAverage2.png)

Chú ý: Trong đó averageSeries(collectdServer.load.load.longterm,collectdServer.load.load.midterm,collectdServer.load.load.shortterm)=(0.00 + 0.01 + 0.05)/3 = 0.02

<a name="product"></a>
####3. Product function.

<a name="motaproduct"></a>
#####3.1 Mô tả.
- Product function giúp người nhân hai thông số được chọn với nhau.

<a name="minhhoaproduct"></a>
#####3.2 Minh họa.

- Người dùng chọn hai thông số. Ở đây tôi chọn load.shortterm và load.longterm. Sau đó chọn Apply Fuction-> Combine-> Product.

Hình 5
![average](/images/functionProduct1.png)

Hình 6
![average](/images/functionProduct2.png)

Chú ý: Trong đó multiplySeries(collectdServer.load.load.shortterm,collectdServer.load.load.longterm)= 0.12 x 0.14 = 0.0168

<a name="minvalue"></a>
####4. Min value function.

<a name="motaminvalue"></a>
#####4.1 Mô tả.

- Min value function giúp người dùng tìm ra chỉ thông số nào là thấp nhất trong các thông số được chọn. Hệ thống sẽ so sánh các điểm để tìm ra thông số nhỏ nhất.

<a name="minhhoaminvalue"></a>
#####4.2 Minh họa

- Chọn các thông số người dùng muốn so sánh. Ở đây tôi chọn load.shortterm và load.midterm. Sau đó chọn Apply Fuction-> Combine-> Min value.

Hình 7
![minvalue](/images/functionMinvalue1.png)

<a name="maxvalue"></a>
####4. Max value function.

<a name="motamaxvalue"></a>
#####4.1 Mô tả.

- Min value function giúp người dùng tìm ra chỉ thông số nào là cao nhất trong các thông số được chọn. Hệ thống sẽ so sánh các điểm để tìm ra thông số lớn nhất.

<a name="minhhoamaxvalue"></a>
#####5.2 Minh họa

- Chọn các thông số người dùng muốn so sánh. Ở đây tôi chọn load.shortterm và load.midterm. Sau đó chọn Apply Fuction-> Combine-> Max value.

Hình 8
![maxvalue](/images/functionMaxvalue1.png)

<a name="difference"></a>
####6. Difference function.

<a name="motadifference"></a>
#####6.1 Mô tả.

- Người dùng có thế so sánh giữa hai thông số được chọn. Lấy thông số chọn đầu tiên trừ cho thông số thứ hai được chọn.

<a name="minhhoadifference"></a>
#####6.2 Minh họa.

- Chọn hai thông số người dùng muốn so sánh. Tôi chọn load.longterm và load.shortterm. Sau đó chọn Apply Function-> Calculate-> Difference.

Hình 9
![difference](/images/functionDifference1.png)

Hình 10
![difference](/images/functionDifference2.png)

<a name="ratio"></a>
####7. Ratio function.

<a name="motaratio"></a>
#####7.1 Mô tả.

- Ratio function giúp người dùng có thể biết tỉ lệ giữa hai thông số được chọn.

<a name="minhhoaratio"></a>
#####7.2 Minh họa.

- Chọn 2 function người dùng muốn so sánh. Tôi so sánh dung lượng của free và used trong memory.

Chọn hai thông số đó-> Apply Function-> Calculate-> Ratio.

Hình 11
![ratio](/images/functionRatio1.png)

Hình 12
![ratio](/images/functionRatio1.png)

Chú ý: Nhìn vào biểu đồ người dùng có thể nhận thấy rằng dung lượng free luôn lớn hơn dung lượng used trong memory. 


