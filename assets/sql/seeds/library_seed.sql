INSERT INTO "books" (title, author, year, genre) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Fiction'),
('To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction'),
('1984', 'George Orwell', 1949, 'Dystopian'),
('Pride and Prejudice', 'Jane Austen', 1813, 'Romance'),
('Moby-Dick', 'Herman Melville', 1851, 'Adventure'),
('War and Peace', 'Leo Tolstoy', 1869, 'Historical'),
('The Catcher in the Rye', 'J.D. Salinger', 1951, 'Fiction'),
('The Hobbit', 'J.R.R. Tolkien', 1937, 'Fantasy'),
('Crime and Punishment', 'Fyodor Dostoevsky', 1866, 'Crime'),
('The Odyssey', 'Homer', -800, 'Epic');

INSERT INTO "members" (name, email, join_date) VALUES
('Alice Johnson', 'alice@gmail.com', '2025-01-10 09:00:00'),
('Bob Smith', 'bob@gmail.com', '2025-02-15 10:30:00'),
('Carla Davis', 'carla@gmail.com', '2025-03-20 14:15:00'),
('Daniel Brown', 'daniel@gmail.com', '2025-04-25 11:45:00'),
('Elisa Wilson', 'elisa@gmail.com', '2025-05-30 16:00:00'),
('Frank Miller', 'frank@gmail.com', '2025-06-05 13:20:00'),
('Grace Lee', 'grace@gmail.com', '2025-07-10 10:10:00'),
('Henry Adams', 'henry@gmail.com', '2025-08-15 15:40:00'),
('Isabel Clark', 'isabel@gmail.com', '2025-09-20 12:00:00'),
('Jack Lewis', 'jack@gmail.com', '2025-10-25 09:50:00');

INSERT INTO "loans" (book_id, member_id, loan_date, return_date) VALUES
(1, 1, '2025-10-01 14:00:00', '2025-10-10 18:00:00'),
(2, 2, '2025-10-02 09:30:00', '2025-10-12 16:45:00'),
(3, 3, '2025-10-03 11:15:00', '2025-10-13 15:30:00'),
(4, 4, '2025-10-04 13:00:00', '2025-10-14 17:20:00'),
(5, 5, '2025-10-05 10:45:00', '2025-10-15 14:00:00'),
(6, 6, '2025-10-06 12:30:00', '2025-10-16 16:50:00'),
(7, 7, '2025-10-07 09:20:00', '2025-10-17 13:40:00'),
(8, 8, '2025-10-08 15:10:00', '2025-10-18 18:30:00'),
(9, 9, '2025-10-09 11:50:00', '2025-10-19 14:15:00'),
(10, 10, '2025-10-10 13:35:00', '2025-10-20 16:00:00');
