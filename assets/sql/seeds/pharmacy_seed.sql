INSERT INTO "products" (name, category, price, stock) VALUES
('Aspirin', 'Pain Relief', 4.99, 100),
('Paracetamol', 'Pain Relief', 3.49, 200),
('Vitamin C', 'Supplements', 12.99, 150),
('Cough Syrup', 'Cold & Flu', 6.99, 80),
('Antibiotic Cream', 'First Aid', 8.49, 60),
('Multivitamin', 'Supplements', 14.99, 120),
('Ibuprofen', 'Pain Relief', 5.99, 90),
('Allergy Pills', 'Allergy', 9.49, 70),
('Bandages', 'First Aid', 2.99, 300),
('Thermometer', 'Equipment', 15.99, 50);

INSERT INTO "suppliers" (name, phone) VALUES
('HealthCorp', '+1-202-555-0101'),
('MediSupply', '+1-202-555-0202'),
('PharmaPlus', '+1-202-555-0303'),
('Wellness Inc.', '+1-202-555-0404'),
('Global Pharma', '+1-202-555-0505'),
('LifeMed', '+1-202-555-0606'),
('CareHealth', '+1-202-555-0707'),
('Sunrise Pharma', '+1-202-555-0808'),
('NatureMed', '+1-202-555-0909'),
('Prime Pharma', '+1-202-555-1010');

INSERT INTO "customers" (name, email) VALUES
('Alice Johnson', 'alice@gmail.com'),
('Bob Smith', 'bob@gmail.com'),
('Carla Davis', 'carla@gmail.com'),
('Daniel Brown', 'daniel@gmail.com'),
('Elisa Wilson', 'elisa@gmail.com'),
('Frank Miller', 'frank@gmail.com'),
('Grace Lee', 'grace@gmail.com'),
('Henry Adams', 'henry@gmail.com'),
('Isabel Clark', 'isabel@gmail.com'),
('Jack Lewis', 'jack@gmail.com');

INSERT INTO "sales" (customer_id, total, date) VALUES
(1, 19.95, '2025-10-01 10:15:00'),
(2, 25.47, '2025-10-02 11:20:00'),
(3, 13.49, '2025-10-03 09:30:00'),
(4, 40.97, '2025-10-04 14:45:00'),
(5, 8.99, '2025-10-05 16:10:00'),
(6, 32.48, '2025-10-06 12:50:00'),
(7, 22.47, '2025-10-07 13:25:00'),
(8, 15.99, '2025-10-08 15:40:00'),
(9, 28.98, '2025-10-09 17:00:00'),
(10, 10.99, '2025-10-10 10:05:00');

INSERT INTO "sale_items" (sale_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(2, 5, 2),
(3, 4, 1),
(4, 6, 2),
(4, 7, 3),
(5, 8, 1),
(6, 9, 4),
(7, 10, 1),
(8, 1, 1),
(9, 3, 2),
(9, 5, 1),
(10, 2, 2);
