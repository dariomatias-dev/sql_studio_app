INSERT INTO "guests" (name, email) VALUES
('Alice Johnson', 'alice.johnson@gmail.com'),
('Bob Smith', 'bob.smith@gmail.com'),
('Carla Davis', 'carla.davis@gmail.com'),
('Daniel Brown', 'daniel.brown@gmail.com'),
('Elisa Wilson', 'elisa.wilson@gmail.com'),
('Frank Miller', 'frank.miller@gmail.com'),
('Grace Lee', 'grace.lee@gmail.com'),
('Henry Adams', 'henry.adams@gmail.com'),
('Isabel Clark', 'isabel.clark@gmail.com'),
('Jack Lewis', 'jack.lewis@gmail.com');

INSERT INTO "rooms" (number, type, price) VALUES
('101', 'Single', 80.00),
('102', 'Double', 120.00),
('103', 'Suite', 200.00),
('104', 'Single', 85.00),
('105', 'Double', 125.00),
('201', 'Suite', 220.00),
('202', 'Single', 90.00),
('203', 'Double', 130.00),
('204', 'Suite', 250.00),
('205', 'Single', 95.00);

INSERT INTO "reservations" (guest_id, room_id, check_in, check_out) VALUES
(1, 1, '2025-11-01 15:00:00', '2025-11-05 11:00:00'),
(2, 2, '2025-11-02 16:00:00', '2025-11-06 12:00:00'),
(3, 3, '2025-11-03 14:00:00', '2025-11-07 11:30:00'),
(4, 4, '2025-11-04 15:30:00', '2025-11-08 12:00:00'),
(5, 5, '2025-11-05 16:15:00', '2025-11-10 11:00:00'),
(6, 6, '2025-11-06 15:00:00', '2025-11-12 12:00:00'),
(7, 7, '2025-11-07 14:45:00', '2025-11-11 11:30:00'),
(8, 8, '2025-11-08 16:00:00', '2025-11-13 12:00:00'),
(9, 9, '2025-11-09 15:30:00', '2025-11-14 11:00:00'),
(10, 10, '2025-11-10 16:15:00', '2025-11-15 12:00:00');

INSERT INTO "payments" (reservation_id, amount, date) VALUES
(1, 400.00, '2025-11-01 12:00:00'),
(2, 480.00, '2025-11-02 12:00:00'),
(3, 800.00, '2025-11-03 12:00:00'),
(4, 425.00, '2025-11-04 12:00:00'),
(5, 625.00, '2025-11-05 12:00:00'),
(6, 1100.00, '2025-11-06 12:00:00'),
(7, 450.00, '2025-11-07 12:00:00'),
(8, 650.00, '2025-11-08 12:00:00'),
(9, 1250.00, '2025-11-09 12:00:00'),
(10, 475.00, '2025-11-10 12:00:00');

INSERT INTO "employees" (name, role, salary) VALUES
('Laura White', 'Manager', 3000.00),
('James Green', 'Receptionist', 1800.00),
('Sophie Black', 'Housekeeping', 1500.00),
('Michael Brown', 'Chef', 2500.00),
('Emma Davis', 'Concierge', 2000.00),
('David Wilson', 'Waiter', 1600.00),
('Olivia Lee', 'Bartender', 1700.00),
('Lucas Miller', 'Security', 1800.00),
('Mia Adams', 'Cleaner', 1400.00),
('Ethan Clark', 'Maintenance', 1900.00);

INSERT INTO "services" (name, price) VALUES
('Room Cleaning', 25.00),
('Breakfast', 15.00),
('Spa', 50.00),
('Laundry', 10.00),
('Airport Shuttle', 30.00),
('Dinner', 40.00),
('Gym Access', 20.00),
('Pool Access', 10.00),
('Parking', 15.00),
('WiFi Premium', 5.00);
