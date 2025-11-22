INSERT INTO "users" (name, username, created_at) VALUES
('Alice Johnson', 'alicej', '2025-01-10 09:12:00'),
('Robert Smith', 'roberts', '2025-01-11 10:15:00'),
('Emma Davis', 'emmad', '2025-01-12 11:20:00'),
('Daniel Brown', 'danielb', '2025-01-13 12:25:00'),
('Sophia Wilson', 'sophiaw', '2025-01-14 13:30:00'),
('Liam Thompson', 'liamt', '2025-01-15 14:35:00'),
('Olivia Martinez', 'oliviam', '2025-01-16 15:40:00'),
('Noah Clark', 'noahc', '2025-01-17 16:45:00'),
('Ava Lewis', 'aval', '2025-01-18 17:50:00'),
('Ethan Walker', 'ethanw', '2025-01-19 18:55:00');

INSERT INTO "followers" (user_id, follower_id, created_at) VALUES
(1, 2, '2025-01-12 09:00:00'),
(1, 3, '2025-01-12 10:00:00'),
(2, 1, '2025-01-13 11:00:00'),
(2, 4, '2025-01-13 12:00:00'),
(3, 1, '2025-01-14 13:00:00'),
(3, 5, '2025-01-14 14:00:00'),
(4, 2, '2025-01-15 15:00:00'),
(5, 3, '2025-01-16 16:00:00'),
(6, 1, '2025-01-17 17:00:00'),
(7, 4, '2025-01-18 18:00:00');

INSERT INTO "posts" (user_id, content, created_at) VALUES
(1, 'Excited to start my new project today!', '2025-01-20 09:15:00'),
(2, 'Loving the sunny weather this week.', '2025-01-21 10:20:00'),
(3, 'Just finished reading an amazing book.', '2025-01-22 11:25:00'),
(4, 'Had a great workout session this morning.', '2025-01-23 12:30:00'),
(5, 'Cooking a new recipe tonight!', '2025-01-24 13:35:00'),
(6, 'Planning a weekend trip to the mountains.', '2025-01-25 14:40:00'),
(7, 'Started learning guitar.', '2025-01-26 15:45:00'),
(8, 'Watching a movie with friends.', '2025-01-27 16:50:00'),
(9, 'Trying out a new coffee place.', '2025-01-28 17:55:00'),
(10, 'Working on a coding challenge.', '2025-01-29 18:00:00');

INSERT INTO "comments" (post_id, user_id, content, created_at) VALUES
(1, 2, 'Good luck with your project!', '2025-01-20 10:00:00'),
(1, 3, 'Can\'t wait to see it!', '2025-01-20 10:30:00'),
(2, 1, 'Yes, it\'s beautiful outside!', '2025-01-21 11:00:00'),
(2, 4, 'Perfect weather for a walk.', '2025-01-21 11:30:00'),
(3, 5, 'Which book was it?', '2025-01-22 12:00:00'),
(3, 6, 'I love reading too!', '2025-01-22 12:30:00'),
(4, 7, 'Keep it up!', '2025-01-23 13:00:00'),
(5, 8, 'What recipe are you trying?', '2025-01-24 14:00:00'),
(6, 9, 'Have fun on your trip!', '2025-01-25 15:00:00'),
(7, 10, 'Guitar is fun!', '2025-01-26 16:00:00');

INSERT INTO "likes" (post_id, user_id, created_at) VALUES
(1, 2, '2025-01-20 10:05:00'),
(1, 3, '2025-01-20 10:35:00'),
(2, 1, '2025-01-21 11:05:00'),
(2, 4, '2025-01-21 11:35:00'),
(3, 5, '2025-01-22 12:05:00'),
(3, 6, '2025-01-22 12:35:00'),
(4, 7, '2025-01-23 13:05:00'),
(5, 8, '2025-01-24 14:05:00'),
(6, 9, '2025-01-25 15:05:00'),
(7, 10, '2025-01-26 16:05:00');
