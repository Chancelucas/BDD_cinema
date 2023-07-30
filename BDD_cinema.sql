CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth TIMESTAMP NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    role VARCHAR(10) NOT NULL DEFAULT 'customer'
);

CREATE TABLE admin (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) UNIQUE,
    password CHAR(60) NOT NULL
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) UNIQUE,
    type_customer VARCHAR(50)
);

CREATE TABLE cinema (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone VARCHAR(10) NOT NULL,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category_id INTEGER REFERENCES category(id),
    duration VARCHAR(100) NOT NULL
);

CREATE TABLE room (
    id SERIAL PRIMARY KEY,
    cinema_id INTEGER REFERENCES cinema(id),
    movie_id INTEGER REFERENCES movie(id),
    datetime TIMESTAMP NOT NULL,
    capacity INTEGER NOT NULL
);

CREATE TABLE projection (
    id SERIAL PRIMARY KEY,
    cinema_id INTEGER REFERENCES cinema(id),
    movie_id INTEGER REFERENCES movie(id),
    room_id INTEGER REFERENCES room(id),
    datetime TIMESTAMP NOT NULL
);

CREATE TABLE seat (
    id SERIAL PRIMARY KEY,
    number VARCHAR(100)
);

CREATE TABLE session_movie (
    id SERIAL PRIMARY KEY,
    cinema_id INTEGER REFERENCES cinema(id),
    movie_id INTEGER REFERENCES movie(id)
);

CREATE TABLE reservation (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    movie_id INTEGER REFERENCES movie(id),
    session_movie_id INTEGER REFERENCES session_movie(id),
    room_id INTEGER REFERENCES room(id),
    seat_id INTEGER REFERENCES seat(id),
    payment_method VARCHAR(100),
    date_payment TIMESTAMP NOT NULL,
    price DECIMAL(5,2)
);

CREATE INDEX ON reservation (customer_id);
CREATE INDEX ON reservation (movie_id);
CREATE INDEX ON reservation (session_movie_id);
CREATE INDEX ON reservation (room_id);
CREATE INDEX ON reservation (seat_id);

INSERT INTO users (first_name, last_name, date_of_birth, email, role) VALUES
    ('John', 'Doe', '1985-05-10', 'john.doe@example.com', 'customer'),
    ('Alice', 'Smith', '1990-08-15', 'alice.smith@example.com', 'customer'),
    ('Bob', 'Johnson', '1980-02-20', 'bob.johnson@example.com', 'admin'),
    ('Michael', 'Brown', '1992-03-25', 'michael.brown@example.com', 'customer'),
    ('Emma', 'Wilson', '1988-11-05', 'emma.wilson@example.com', 'customer'),
    ('David', 'Taylor', '1984-06-15', 'david.taylor@example.com', 'customer'),
    ('Sophia', 'Lee', '1995-09-12', 'sophia.lee@example.com', 'customer'),
    ('James', 'Anderson', '1983-04-30', 'james.anderson@example.com', 'customer');

INSERT INTO admin (user_id, password) VALUES
    (3, 'hashed_password_1');

INSERT INTO customers (user_id, type_customer) VALUES
    (1, 'cinema'),
    (2, 'online'),
    (4, 'online'),
    (5, 'cinema'),
    (6, 'online'),
    (7, 'cinema'),
    (8, 'cinema');

INSERT INTO cinema (name, address, phone, city) VALUES
    ('Cinema 1', '123 Avenue Street', '1234567890', 'City 1'),
    ('Cinema 2', '456 Main Road', '9876543210', 'City 2'),
    ('Cinema 3', '147 Street Main Road', '5431654841', 'City 3'),
    ('Cinema 4', '56 Road Main', '4278921281', 'City 4'),
    ('Cinema 5', '42 Main Avenue Road', '6972589127', 'City 5');

INSERT INTO category (name) VALUES
    ('Action'),
    ('Comedy'),
    ('Drama'),
    ('Science Fiction'),
    ('Horror');

INSERT INTO movie (title, category_id, duration) VALUES
    ('Movie 1', 1, '2h30m'),
    ('Movie 2', 2, '1h45m'),
    ('Movie 3', 3, '2h10m'),
    ('Movie 4', 4, '2h05m'),
    ('Movie 5', 5, '1h55m'),
    ('Movie 6', 3, '2h20m'),
    ('Movie 7', 2, '1h50m'),
    ('Movie 8', 1, '2h15m'),
    ('Movie 9', 5, '1h40m'),
    ('Movie 10', 4, '2h25m');

INSERT INTO room (cinema_id, movie_id, datetime, capacity) VALUES
    (1, 1, '2023-07-01 18:00:00', 100),
    (1, 2, '2023-07-02 20:30:00', 80),
    (2, 3, '2023-07-03 15:15:00', 120),
    (3, 4, '2023-07-01 19:45:00', 90),
    (4, 5, '2023-07-02 15:30:00', 110),
    (2, 6, '2023-07-03 19:00:00', 100),
    (5, 7, '2023-07-01 22:30:00', 70),
    (3, 8, '2023-07-02 14:45:00', 85),
    (1, 9, '2023-07-03 18:00:00', 95),
    (4, 10, '2023-07-01 17:00:00', 105);

INSERT INTO projection (cinema_id, movie_id, room_id, datetime) VALUES
    (1, 1, 1, '2023-07-01 18:00:00'),
    (1, 2, 2, '2023-07-02 20:30:00'),
    (2, 3, 3, '2023-07-03 15:15:00'),
    (3, 4, 4, '2023-07-01 19:45:00'),
    (4, 5, 5, '2023-07-02 15:30:00'),
    (2, 6, 6, '2023-07-03 19:00:00'),
    (5, 7, 7, '2023-07-01 22:30:00'),
    (3, 8, 8, '2023-07-02 14:45:00'),
    (1, 9, 9, '2023-07-03 18:00:00'),
    (4, 10, 10, '2023-07-01 17:00:00');

INSERT INTO seat (number) VALUES
    ('A1'),
    ('A2'),
    ('B1'),
    ('B2'),
    ('C1'),
    ('C2'),
    ('D1'),
    ('D2'),
    ('E1'),
    ('E2'),
    ('F1'),
    ('F2'),
    ('G1'),
    ('G2'),
    ('H1'),
    ('H2'),
    ('I1'),
    ('I2'),
    ('J1'),
    ('J2');

INSERT INTO session_movie (cinema_id, movie_id) VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5),
    (2, 6),
    (5, 7),
    (3, 8),
    (1, 9),
    (4, 10);

INSERT INTO reservation (customer_id, movie_id, session_movie_id, room_id, seat_id, payment_method, date_payment, price) VALUES
    (1, 1, 1, 1, 1, 'cash', '2023-07-01 17:30:00', 9.20),
    (2, 2, 2, 2, 2, 'online', '2023-07-02 20:00:00', 7.60),
    (4, 3, 3, 3, 3, 'online', '2023-07-03 14:45:00', 5.90);
