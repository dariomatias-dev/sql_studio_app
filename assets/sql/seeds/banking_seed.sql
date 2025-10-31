INSERT INTO "customers" (name, cpf, email) VALUES
('Alice Smith', '520-27-9600', 'alice.smith@gmail.com'),
('Bruno Johnson', '185-23-7010', 'bruno.johnson@gmail.com'),
('Carla Miller', '147-94-9220', 'carla.miller@gmail.com'),
('Daniel Brown', '619-74-4720', 'daniel.brown@gmail.com'),
('Elisa Davis', '344-89-4350', 'elisa.davis@gmail.com'),
('Felipe Lewis', '221-31-1340', 'felipe.lewis@gmail.com'),
('Gabriela Martin', '866-87-6540', 'gabriela.martin@gmail.com'),
('Henry Adams', '106-99-3110', 'henry.adams@gmail.com'),
('Isabel Clark', '403-58-6380', 'isabel.clark@gmail.com'),
('John Carroll', '671-65-6020', 'john.carroll@gmail.com');

INSERT INTO "branches" (name, address) VALUES
('New York Branch', '150 W 34th St, New York, NY 10001, USA'),
('Los Angeles Branch', '600 S Flower St, Los Angeles, CA 90017, USA'),
('Chicago Branch', '233 S Wacker Dr, Chicago, IL 60606, USA');

INSERT INTO "employees" (name, branch, role) VALUES
('Fernando Lewis', 'New York Branch', 'Manager'),
('Gabriela Smith', 'Los Angeles Branch', 'Teller'),
('Hugo Brown', 'Chicago Branch', 'Teller'),
('Irene Adams', 'New York Branch', 'Teller'),
('Jason Martin', 'Los Angeles Branch', 'Assistant');

INSERT INTO "accounts" (customer_id, balance, type) VALUES
(1, 1500.75, 'CHECKING'),
(2, 3200.50, 'SAVINGS'),
(3, 4500.00, 'CHECKING'),
(4, 800.25, 'SAVINGS'),
(5, 12000.00, 'CHECKING'),
(6, 950.00, 'SAVINGS'),
(7, 5300.00, 'CHECKING'),
(8, 2200.00, 'CHECKING'),
(9, 1800.50, 'SAVINGS'),
(10, 7600.00, 'CHECKING');

INSERT INTO "transactions" (account_id, amount, type) VALUES
(1, 500.00, 'DEPOSIT'),
(1, 200.00, 'WITHDRAW'),
(2, 1200.50, 'DEPOSIT'),
(3, 1500.00, 'DEPOSIT'),
(4, 100.25, 'WITHDRAW'),
(5, 3000.00, 'DEPOSIT'),
(6, 200.00, 'DEPOSIT'),
(7, 400.00, 'WITHDRAW'),
(8, 600.00, 'DEPOSIT'),
(9, 250.50, 'WITHDRAW'),
(10, 800.00, 'DEPOSIT');

INSERT INTO "loans" (customer_id, amount, interest_rate, due_date) VALUES
(1, 5200.00, 5.1, '2025-12-28 10:00:00'),
(2, 11800.00, 4.6, '2026-06-25 15:30:00'),
(3, 7300.00, 6.0, '2025-11-20 09:45:00'),
(4, 3100.00, 5.4, '2026-03-22 14:15:00'),
(5, 14950.00, 4.1, '2026-12-03 11:20:00'),
(6, 2600.00, 6.3, '2025-10-12 16:50:00'),
(7, 8100.00, 5.0, '2026-05-07 13:10:00'),
(8, 4200.00, 4.9, '2026-01-18 10:30:00'),
(9, 3550.00, 5.3, '2025-12-15 17:40:00'),
(10, 10200.00, 4.4, '2026-07-09 12:25:00');
