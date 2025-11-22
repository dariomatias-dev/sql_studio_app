DROP TABLE IF EXISTS salary_history;

DROP TABLE IF EXISTS job_positions;

DROP TABLE IF EXISTS departments;

DROP TABLE IF EXISTS employees;

CREATE TABLE IF NOT EXISTS "departments" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "job_positions" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    base_salary REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS "employees" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    department_id INTEGER,
    position_id INTEGER,
    manager_id INTEGER,
    hired_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES "departments" (id),
    FOREIGN KEY (position_id) REFERENCES "job_positions" (id),
    FOREIGN KEY (manager_id) REFERENCES "employees" (id)
);

CREATE TABLE IF NOT EXISTS "salary_history" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_id INTEGER NOT NULL,
    salary REAL NOT NULL,
    valid_from TEXT NOT NULL,
    valid_to TEXT,
    FOREIGN KEY (employee_id) REFERENCES "employees" (id)
);