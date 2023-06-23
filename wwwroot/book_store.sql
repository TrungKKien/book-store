CREATE DATABASE IF NOT EXISTS book_store;

USE book_store;

CREATE TABLE IF NOT EXISTS authors (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(355) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


CREATE TABLE IF NOT EXISTS books (
  `id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `discription` varchar(2000) NOT NULL,
  `number` int(10) NOT NULL,
  `price` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS categories (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


CREATE TABLE IF NOT EXISTS comments (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


CREATE TABLE IF NOT EXISTS orders (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `status` int(10) NOT NULL,
  `number` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


CREATE TABLE IF NOT EXISTS users (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `phone_number` int(12) NOT NULL,
  `password` varchar(150) NOT NULL,
  `address` varchar(255) NOT NULL,
  `role` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `users` (`id`, `name`, `phone_number`, `password`, `address`, `role`) VALUES
(1, 'test', 123456, '123456', 'ddfdsf', 0),
(2, 'kienn', 654321, '1234', 'sdfsdfsdf', 0),
(3, 'admin', 88888888, '12345', 'Hà Nội', 1),
(4, 'Trung Kien', 1234567, '1234', 'Hà Nội', 0),
(10, 'Kienn', 98765, '1234', 'hanoii', 0);

ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `author_id` (`author_id`);

ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`,`name`);

ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `user_id` (`user_id`);

ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `user_id` (`user_id`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `authors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `books_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`);

ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);




-- insert dữ liệu vào database
INSERT INTO `authors` (`id`, `name`, `description`) VALUES
(1, 'Dale Carnegie', 'tacs gia noi tieeng sdadd'),
(2, 'Paulo Coelho', 'tác giả'),
(3, 'Mario Puzo', 'tác giả tiểu thuyết'),
(4, 'YOU LING', 'Sinh:Tháng Mười Một 9, 1989\r\nTuổi:33\r\nGiống:Cái\r\nQuê hương:Bắc Kinh, Trung Quốc\r\nYou.Ling là một nhóm vẽ tranh biếm họa sinh đôi nổi tiếng của Trung Quốc. Vâng, cặp song sinh. Một số tác phẩm nổi tiếng nhất của họ ở nước ngoài bao gồm Bring My brother Away, Top News King và bây giờ là MODE II. Những truyện tranh này không chỉ phổ biến đối với độc giả '),
(5, 'Thomas Harris', 'William Thomas Harris III (sinh ngày 22 tháng 1940 năm 1) là một nhà văn người Mỹ, nổi tiếng với một loạt tiểu thuyết hồi hộp về nhân vật nổi tiếng nhất của ông, Hannibal Lecter. Phần lớn các tác phẩm của ông đã được chuyển thể thành phim và truyền hình, đáng chú ý nhất là Sự im lặng của bầy cừu, trở thành bộ phim thứ ba trong lịch sử giải Oscar càn qué'),
(6, 'Thiên Hạ Bá Xướng', 'Thiên Hạ Bá Xướng là một nhà văn Trung Quốc, được biết tới là người đi đầu trong thể loại truyện trộm mộ. Tác phẩm nổi tiếng nhất của anh, Ma Thổi Đèn, ban đầu được viết và đăng trên mạng năm 2006.');


INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'KINH DOANH', 'sách kinh doanh'),
(2, 'TÂM LÝ', 'sách tâm lý'),
(5, 'CHÍNH TRỊ', 'sách chính trị'),
(8, 'TIỂU THUYẾT', 'Sách tiểu thuyết'),
(9, 'KINH DỊ', 'sách Kinh dị');



INSERT INTO `books` (`id`, `author_id`, `category_id`, `name`, `image`, `discription`, `number`, `price`) VALUES
(1, 1, 1, 'Sói đội Lốt Cừu', 'https://vn-live-01.slatic.net/p/937720c737e2477bc9b7bd666f07e60f.jpg', 'sdasdeds', 11, 120000),
(8, 1, 2, 'Đắc Nhân Tâm', 'https://blog.bizbooks.vn/wp-content/uploads/2019/04/DAC-NHAN-TAM-bia-truoc.jpg', 'ffsdsrwer', 8, 100000),
(9, 2, 8, 'Nhà Giả Kim', 'http://thpthuonghoa.quangtri.edu.vn/upload/32300/fck/files/sach-nha-gia-kim.jpg', 'Có bao giờ bạn bị sa ngã trước những lời phán xét của mọi người xung quanh? Tương lai, sự nghiệp của bạn là do sự sắp đặt hay là sự lựa chọn? Tôi đã từng lung lay trước những ánh mắt dèm pha, lời nói miệt thị của người khác để thay đổi bản thân. Từ chối nghe theo tiếng lòng vì sợ rằng không hoàn hảo trong mắt người khác, cho đến khi tôi bắt gặp “Nhà giả kim” của Paulo Coelho\r\n\r\n”Ai cũng biết người khác nên sống như thế nào, nhưng lại không hiểu mình nên sống ra sao”.\r\n\r\n     Ta luôn phán xét người này nên sống thế này sống thế kia mới hạnh phúc, mới có một cuộc sống tốt nhưng bản thân không biết sẽ sống như thế nào, xoay sở ra làm sao mà trong lúc đó lại bị mắc kẹt trong đống dây suy nghĩ hỗn độn .\r\n\r\nMột chàng trai trẻ Sitiago với ước muốn được phiêu lưu khắp mọi nơi, nhưng cha mẹ cậu lại mong muốn cậu trở thành linh mục để mang lại niềm tự hào cho gia đình. Với niềm đam mê và hoài bão của mình cậu đã thuyết phục bố mẹ và trở thành một người chăn cừu. Chàng ta lựa chọn theo đuổi giấc mơ và không quan tâm người khác nói gì, đặt mình ở đâu vì chàng ta hiểu bản thân mình cần gì , con đường mà anh ta sắp trải qua sẽ gặp những trắc trở, chông gai gập gềnh hơn ai hết.\r\n\r\nBản thân mỗi chúng ta cũng thế, cuộc đời của chúng ta thì do chúng ta sắp đặt và lựa chọn, ta chỉ được một lần để sống và đừng để nó trở thành một lần vô nghĩa. Ai cũng có ước mơ để theo đuổi để được ước muốn đoạt được, vậy tại sao không nghe theo tiếng gọi tận sâu trong đáy lòng, kiên trì đuổi theo nó đến cùng?\r\n\r\nHành trình chinh phục được bất cứ điều gì cũng không hề đơn giản và bằng phẳng, đôi lúc ta vấp phải những biến cố hay phải đánh đổi bằng rất nhiều những thứ khác.\r\n\r\n“ Khi bạn thực sự mong muốn một điều gì, cả vũ trụ hợp lại giúp bạn đạt được nó”', 56, 69000),
(10, 3, 8, 'Tiểu thuyết Bố Già', 'https://static.8cache.com/cover/o/eJzLyTDW1_XJMndLzM10Mo4P1A8zdPT2DPFJdfHy1HeEAv94X30z99DQlMQSF-dwzyQnl8iASNf0suDw4hy_QueApAJn40Bn53z9ciNDU90MYyMjAHsCGiE=/bo-gia-the-godfather.jpg', 'Amêrigô Bônaxêra ngồi Ở phòng ba tòa đại hình Niu York chờ xem công lý được thực thi và lưỡi gươm trừng phạt sẽ bổ xuống đầu mấy thằng mất dạy đã hành hung thành thương tật và toan làm nhục con gái lão. Ngài chánh án uy nghi trang trọng vén tay áo thụng như sắp sửa tự tay mình trị tội hai thằng côn đồ đang đứng trước tòa. BỘ mặt sắt của ngài dầy khinh bỉ, cao ngạo, song Ở dây có một cái gì dó giả trá mà Amêrigô Bônaxêra đã nhận thấy bằng trực giác mặc dù còn chưa hiểu ra sự thể.\r\n\r\nHành động của các người là hành động của bọn cặn bã mạt hạng, - ngài chánh án lớn tiếng. Đúng, Bônaxêra nghĩ bụng, dúng thế. lũ súc sinh. Loài dã thú. Hai thằng thanh niên tóc bóng mượt cắt đúng mốt, mặt mày sáng sủa lộ rõ vẻ ăn năn - hai đứa cúi đầu cam chịu. Quan chánh án phán tiếp:\r\n\r\n- Các người hành động như lũ dã thú trong rừng, may mà cô gái đáng thương chưa bị các người xâm phạm tiết hạnh, bằng không ta phải nhốt các người đủ hai chục năm mới nghe. - Ngài dừng lại một lúc, cặp mắt cáo bên dưới đôi lông mày rậm rì nhíu lại dữ tợn đảo nhanh qua bộ mặt tái ngắt của Bônaxêra. Rồi càng sa sầm mặt với vẻ dữ tợn hơn, so vai như để kìm cơn giận tự nhiên, ngài kết thúc:\r\n\r\n- Nhưng xét các người còn trẻ, trước đây chưa có tiền án, vả lại đều là con nhà tử tế, mặt khác luật pháp là cực kì sáng suốt, đặt ra không phải để trả thù, nên ta tuyên phạt mỗi tên ba năm tù. Cho phép các người được hưởng án treo. ( Trích đoạn)', 48, 105000),
(11, 1, 2, 'Quẳng gánh lo đi và vui sống', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd6Un9LTB_-ZyHdkC480m2KmtqVV8pJ241At9Posg0hWNfJkvvTFTXBQN6CoXnPGwLNqQ&usqp=CAU', 'Sau sự thành công của Đắc Nhân Tâm, Quảng Gánh Lo Đi Và Vui Sống là tác phẩm nổi tiếng kế tiếp lọt top những quyển sách nên đọc của Dale Carnegie. Cuốn sách này phân tích và giải đáp những nỗi khổ,phiền muộn mà mỗi người đều gặp phải trong cuộc sống hàng ngày. Qua đó, tác giả xây dựng cho người đọc một thái độ sống vui vẻ, tích cực và loại bỏ thói quen lo lắng. Tác phẩm được chia thành sáu phần, mỗi phần có thể được coi là lời khuyên hữu ích cho những ai đang gặp rắc rối mà không biết làm thế nào để vượt qua.\r\n\r\nĐây là cuốn sách nên đọc 1 lần trong đời để giúp bạn vượt qua khó khăn và trở thành một người lạc quan, hạnh phúc.', 50, 90000),
(12, 3, 8, 'Những Ngày Thơ Ấu ', 'https://toplist.vn/images/800px/nhung-ngay-tho-au-41533.jpg', 'Những Ngày Thơ Ấu có thể coi là một tác phẩm văn học Việt Nam xuất sắc. Đây là tập hồi ký về tuổi thơ ghi lại những “rung động cực điểm của một linh hồn trẻ dại”.\r\n\r\nCuốn sách bao gồm những phần chính sau:\r\n\r\n– Tiếng kèn\r\n\r\n– Chúa thương xót chúng con\r\n\r\n– Truỵ lạc\r\n\r\n– Trong lòng mẹ\r\n\r\n– Đêm noel\r\n\r\n– Trong đêm đông\r\n\r\n– Đồng xu cái\r\n\r\n– Sa ngã\r\n\r\n– Một bước ngắn', 12, 122222),
(13, 4, 9, 'Chế Độ Thứ II', 'https://popsimg.akamaized.net/api/v2/containers/file2/cms_thumbnails/chedothuhai_thumb_640x960-df260d60880d-1597805018450-c1qkoanR.jpg?v=0&maxW=420&format=jpg', 'Phải kể đến đầu tiên trong list truyện kinh dị hay này là tác phẩm “Chế Độ Thứ Ii” của tác giả của nhiều tác phẩm kinh dị nổi tiếng, chẳng hạn như: Hãy Mang Anh Trai Tôi Đi, Trang Nhất Toàn Là Hắn,….', 12, 20000),
(14, 5, 9, 'Rồng Đỏ', 'https://i.pinimg.com/originals/13/37/d1/1337d1ea3f5a452b4973f5ef3499232e.jpg', 'Rồng đỏ là một tiểu thuyết của tác giả người Mỹ Thomas Harris, được xuất bản lần đầu tiên vào năm 1981. Nội dung cuốn tiểu thuyết xoay quanh một cựu nhân viên FBI Will Graham, người sắp nghỉ hưu để tìm và bắt giữ một kẻ giết người hàng loạt bí ẩn có biệt danh \"Tiên răng\". Cuốn tiểu thuyết giới thiệu nhân vật Tiến sĩ Hannibal Lecter, một bác sĩ tâm thần tài giỏi và là kẻ giết người hàng loạt ăn thịt người. Hannibal là người mà Graham miễn cưỡng tới tìm xin lời khuyên. Tiêu đề đề cập đến nhân vật trong bức tranh của William Blake , Con rồng đỏ vĩ đại và Người phụ nữ mặc mặt trời.', 13, 100000),
(15, 6, 9, 'Ebook Ma Thổi Đèn', 'https://th.bing.com/th/id/OIP.ZVpixjLED-EeFK5u_XsnFAAAAA?pid=ImgDet&rs=1', 'ùa mô kim, ấn quật mộ, dỡ núi dời non tìm quyết chú\r\n\r\nNgười thắp nến, quỷ thổi đèn, dò mồ đổ đấu kiếm vạn tiền…\r\n\r\nTừ ngàn năm trước, ở đất nước Trung Hoa đã có nghề trộm mộ, còn gọi là Mô Kim hiệu úy. Dám hành nghề đào mộ quật mả, can trường là chuyện nhỏ, còn phải là tay sâu dày về huyền học, phong thủy… cũng như các loại cạm bẫy.\r\n\r\nHồ Bát Nhất, quân nhân giải ngũ có cuốn bửu bối của ông nội; Tuyền béo, con nhà lính, súng bắn như chớp; Shirley Dương, nữ triệu phú Hoa kiều, cũng là cháu ngoại một tay trộm mộ lẫy lừng  – chính là ba Mô kim hiệu uý đương thời. Ba người, ba động cơ, đã cùng dấn bước vào sa mạc hung hiểm hòng truy tìm toà thành cổ Tinh Tuyệt thần bí… Bản lĩnh có thừa, chỉ tiếc là, họ không biết được những lời nguyền đáng sợ nào đang đợi họ…\r\n\r\nMa thổi đèn, cuốn kỳ thư về nghề trộm mộ, thật sự là một hiện tượng\r\n\r\nxuất bản ở Trung Quốc, được coi là Da Vinci Code và Tomb Raider ở nước này, và đã mở ra cả một trào lưu ganh đua xuất bản tiểu thuyết và sách về mồ mả huyền thuật ở đại lục suốt mấy năm gần đây.', 12, 120000);


INSERT INTO `orders` (`id`, `user_id`, `book_id`, `status`, `number`) VALUES
(7, 2, 8, 3, 1),
(8, 2, 1, 2, 1),
(11, 2, 8, 0, 2),
(17, 1, 1, 1, 2),
(20, 10, 1, 0, 3),
(24, 4, 1, 3, 1),
(27, 4, 10, 3, 2),
(28, 4, 9, 2, 3),
(29, 4, 8, 1, 1),
(30, 4, 1, 1, 1),
(31, 4, 11, 0, 1);


INSERT INTO `comments` (`id`, `user_id`, `book_id`, `comment`) VALUES
(1, 2, 1, 'sách hay'),
(2, 2, 8, 'sách hay vô cùng'),
(3, 2, 8, 'faihfoha'),
(4, 2, 8, 'dfdsfd'),
(5, 1, 1, 'sách hay bình thường'),
(6, 1, 1, 'ljsdjh'),
(7, 1, 1, '10 điểm'),
(8, 1, 1, '10 diem'),
(9, 1, 9, '10 diemm');
