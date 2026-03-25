PRAGMA foreign_keys = ON;

-- CUSTOMER
CREATE TABLE CUSTOMER (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone_number TEXT,
    interests TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- EMPLOYEE
CREATE TABLE EMPLOYEE (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    salary REAL,
    hired_at TEXT
);

-- PUBLISHER
CREATE TABLE PUBLISHER (
    publisher_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT,
    phone TEXT,
    address TEXT,
    publisher_category TEXT
);

-- AUTHOR
CREATE TABLE AUTHOR (
    author_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    biography TEXT,
    email TEXT,
    website TEXT
);

-- BOOK
CREATE TABLE BOOK (
    book_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    isbn TEXT UNIQUE,
    price REAL NOT NULL DEFAULT 0.00,
    year_published INTEGER,
    publisher_id INTEGER,
    genre TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (publisher_id) REFERENCES PUBLISHER(publisher_id)
);

-- BOOK_AUTHOR (Many-to-Many)
CREATE TABLE BOOK_AUTHOR (
    book_id INTEGER,
    author_id INTEGER,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES BOOK(book_id),
    FOREIGN KEY (author_id) REFERENCES AUTHOR(author_id)
);

-- ORDERS (renamed from "ORDER")
CREATE TABLE ORDERS (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    employee_id INTEGER,
    order_date TEXT NOT NULL,
    order_time TEXT NOT NULL,
    total_cost REAL NOT NULL,
    number_of_items INTEGER NOT NULL DEFAULT 0,
    status TEXT NOT NULL DEFAULT 'placed',
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id),
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id)
);

-- ORDER_ITEM
CREATE TABLE ORDER_ITEM (
    order_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    unit_price REAL NOT NULL,
    discount_applied REAL NOT NULL DEFAULT 0.00,
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (book_id) REFERENCES BOOK(book_id)
);

-- REVIEW
CREATE TABLE REVIEW (
    review_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id),
    FOREIGN KEY (book_id) REFERENCES BOOK(book_id)
);

-- INVENTORY
CREATE TABLE INVENTORY (
    inventory_id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER NOT NULL,
    stock_count INTEGER NOT NULL DEFAULT 0,
    reorder_level INTEGER NOT NULL DEFAULT 5,
    managed_by INTEGER,
    last_updated TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES BOOK(book_id),
    FOREIGN KEY (managed_by) REFERENCES EMPLOYEE(employee_id)
);