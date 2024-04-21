CREATE DATABASE Ant_data;  -- Создаем базу данных с именем вашего проекта.
USE Ant_data;              -- Указываем, что мы будем использовать эту базу данных.


CREATE TABLE users (
   id INT AUTO_INCREMENT PRIMARY KEY,  -- Первичный ключ
   username VARCHAR(255) UNIQUE NOT NULL,  -- Уникальное поле для имени пользователя
   email VARCHAR(255) UNIQUE NOT NULL,  -- Уникальное поле для email пользователя
   password VARCHAR(255) NOT NULL,
   contact_info TEXT,
   created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_username ON users (username);  -- Индекс по имени пользователя
CREATE INDEX idx_email ON users (email);  -- Индекс по email пользователя

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Первичный ключ
    title VARCHAR(255) UNIQUE NOT NULL,  -- Уникальное поле для названия категории
    code VARCHAR(255) UNIQUE NOT NULL   -- Уникальное поле для кода категории
);
CREATE INDEX idx_title ON categories (title);  -- Индекс по названию категории

CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Первичный ключ
    title VARCHAR(255) NOT NULL,
    description TEXT,
    starting_bid DECIMAL(10, 2),
    image_url VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    expires_at DATETIME,
    category_id INT,   -- Внешний ключ на таблицу categories
    user_id INT,   -- Внешний ключ на таблицу users
    winner_id INT,   -- Внешний ключ на таблицу users
    min_bid DECIMAL(10, 2),
    FULLTEXT (title, description),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (winner_id) REFERENCES users(id)
);
CREATE INDEX idx_title ON items (title);  -- Индекс по заголовку

CREATE TABLE bids (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Первичный ключ
    bid_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    bid_amount DECIMAL(10, 2),
    item_id INT,   -- Внешний ключ на таблицу items
    user_id INT,   -- Внешний ключ на таблицу users
    FOREIGN KEY (item_id) REFERENCES items(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE INDEX idx_user ON bids (user_id);  -- Индекс по user_id для быстрого фильтрации ставок определенного пользователя