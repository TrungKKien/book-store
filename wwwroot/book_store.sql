CREATE DATABASE IF NOT EXISTS book_store;

USE book_store;

CREATE TABLE IF NOT EXISTS authors (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(355) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `authors` (`id`, `name`, `description`) VALUES
(1, 'Dale Carnegie', 'tacs gia noi tieeng sdadd');

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

INSERT INTO `books` (`id`, `author_id`, `category_id`, `name`, `image`, `discription`, `number`, `price`) VALUES
(1, 1, 1, 'Sói đội Lốt Cừu', 'https://vn-live-01.slatic.net/p/937720c737e2477bc9b7bd666f07e60f.jpg', 'sdasdeds', 12, 120000),
(8, 1, 1, 'Đắc Nhân Tâm', 'https://blog.bizbooks.vn/wp-content/uploads/2019/04/DAC-NHAN-TAM-bia-truoc.jpg', 'ffsdsrwer', 10, 100000);


CREATE TABLE IF NOT EXISTS categories (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'KINH DOANH', 'sách kinh doanh'),
(2, 'TÂM LÝ', 'sách tâm lý'),
(5, 'CHÍNH TRỊ', 'sách chính trị');


CREATE TABLE IF NOT EXISTS comments (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `comments` (`id`, `user_id`, `book_id`, `comment`) VALUES
(1, 2, 1, 'sách hay'),
(2, 2, 8, 'sách hay vô cùng'),
(3, 2, 8, 'faihfoha'),
(4, 2, 8, 'dfdsfd'),
(5, 1, 1, 'sách hay bình thường');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--
CREATE TABLE IF NOT EXISTS orders (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `status` int(10) NOT NULL,
  `number` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `book_id`, `status`, `number`) VALUES
(3, 2, 1, 0, 1),
(4, 2, 1, 0, 1),
(5, 2, 1, 1, 1),
(6, 2, 8, 0, 1),
(7, 2, 8, 3, 1),
(8, 2, 1, 1, 1),
(9, 2, 1, 0, 1),
(10, 2, 1, 0, 1),
(11, 2, 8, 0, 1),
(12, 1, 8, 0, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--
CREATE TABLE IF NOT EXISTS users (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `phone_number` int(12) NOT NULL,
  `password` varchar(150) NOT NULL,
  `address` varchar(255) NOT NULL,
  `role` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `phone_number`, `password`, `address`, `role`) VALUES
(1, 'test', 123456, '123456', 'ddfdsf', 0),
(2, 'kienn', 654321, '1234', 'sdfsdfsdf', 0),
(3, 'admin', 88888888, '12345', 'Hà Nội', 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `author_id` (`author_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`,`name`);

--
-- Chỉ mục cho bảng `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `authors`
--
ALTER TABLE `authors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `books_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`);

ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;
