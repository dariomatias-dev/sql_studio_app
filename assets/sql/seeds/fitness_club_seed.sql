INSERT INTO "members" (name, email, join_date) VALUES
('Alice Smith', 'alice.smith@gmail.com', '2025-01-10 09:00:00'),
('Bob Johnson', 'bob.johnson@gmail.com', '2025-02-12 10:15:00'),
('Carla Miller', 'carla.miller@gmail.com', '2025-03-15 14:30:00'),
('Daniel Brown', 'daniel.brown@gmail.com', '2025-04-20 11:45:00'),
('Elisa Davis', 'elisa.davis@gmail.com', '2025-05-05 13:20:00'),
('Frank Wilson', 'frank.wilson@gmail.com', '2025-06-08 15:10:00'),
('Grace Lee', 'grace.lee@gmail.com', '2025-07-12 12:05:00'),
('Henry Adams', 'henry.adams@gmail.com', '2025-08-18 16:40:00'),
('Isabel Clark', 'isabel.clark@gmail.com', '2025-09-22 09:50:00'),
('Jack Lewis', 'jack.lewis@gmail.com', '2025-10-01 08:30:00');

INSERT INTO "plans" (name, price, duration_months) VALUES
('Basic', 29.99, 1),
('Standard', 49.99, 3),
('Premium', 79.99, 6),
('Annual', 299.99, 12),
('Student', 19.99, 1),
('Family', 99.99, 6),
('Couple', 59.99, 3),
('Corporate', 199.99, 12),
('Weekend', 15.99, 1),
('Trial', 0.00, 1);

INSERT INTO "subscriptions" (member_id, plan_id, start_date, end_date) VALUES
(1, 2, '2025-02-01 00:00:00', '2025-05-01 23:59:59'),
(2, 1, '2025-03-01 00:00:00', '2025-04-01 23:59:59'),
(3, 3, '2025-04-01 00:00:00', '2025-10-01 23:59:59'),
(4, 2, '2025-05-01 00:00:00', '2025-08-01 23:59:59'),
(5, 5, '2025-06-01 00:00:00', '2025-07-01 23:59:59'),
(6, 4, '2025-07-01 00:00:00', '2026-07-01 23:59:59'),
(7, 6, '2025-08-01 00:00:00', '2026-02-01 23:59:59'),
(8, 1, '2025-09-01 00:00:00', '2025-10-01 23:59:59'),
(9, 7, '2025-10-01 00:00:00', '2026-01-01 23:59:59'),
(10, 2, '2025-10-15 00:00:00', '2026-01-15 23:59:59');
