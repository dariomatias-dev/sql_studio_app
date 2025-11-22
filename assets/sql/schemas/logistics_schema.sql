DROP TABLE IF EXISTS status_history;

DROP TABLE IF EXISTS deliveries;

DROP TABLE IF EXISTS packages;

DROP TABLE IF EXISTS drivers;

DROP TABLE IF EXISTS customers;

CREATE TABLE IF NOT EXISTS "customers" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    address TEXT
);

CREATE TABLE IF NOT EXISTS "drivers" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    vehicle TEXT
);

CREATE TABLE IF NOT EXISTS "packages" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    weight REAL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES "customers" (id)
);

CREATE TABLE IF NOT EXISTS "deliveries" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    package_id INTEGER NOT NULL,
    driver_id INTEGER,
    estimated_date TEXT,
    FOREIGN KEY (package_id) REFERENCES "packages" (id),
    FOREIGN KEY (driver_id) REFERENCES "drivers" (id)
);

CREATE TABLE IF NOT EXISTS "status_history" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    delivery_id INTEGER NOT NULL,
    status TEXT NOT NULL,
    changed_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (delivery_id) REFERENCES "deliveries" (id)
);