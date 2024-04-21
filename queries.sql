USE Ant_data;

-- Insert categories
INSERT INTO categories (title, code) VALUES ('Доски и лыжи', 'boards'), ('Крепления', 'attachment'), ('Ботинки', 'boots'), ('Одежда', 'clothing'), ('Инструменты', 'tools'), ('Разное', 'other');

-- Insert users
INSERT INTO users (username, password, email, created_at, contact_info) VALUES ('Danila', 'password1', 'test@email.com', NOW(), 'Contact info for Danila'), ('Artimonya', 'password2', 'test@email.ru', NOW(), 'Contact info for Artimonya');

-- Insert items
INSERT INTO items (title, description, starting_bid, image_url, expires_at, category_id, user_id) VALUES
                                                                                                      ('2014 Rossignol District Snowboard', 'Cool snowboard', 10999.00, 'img/lot-1.jpg', NOW() + INTERVAL 7 DAY, 1, 1),
                                                                                                      ('DC Ply Mens 2016/2017 Snowboard', 'That is a nice one!', 159999.00, 'img/lot-2.jpg', NOW() + INTERVAL 5 DAY, 1, 2),
                                                                                                        ('Крепления Union Contact Pro 2015 года размер L/XL', 'Крепления в хорошем состоянии', 8000.00, 'img/lot-3.jpg', NOW() + INTERVAL 3 DAY, 2, 1),
                                                                                                        ('Ботинки для сноуборда DC Mutiny Charocal', 'Мягкие и удобные ботинки', 10999.00, 'img/lot-4.jpg', NOW() + INTERVAL 12 DAY, 3, 2),
                                                                                                        ('Куртка для сноуборда DC Mutiny Charocal', 'Stylish and warm jacket', 7500.00, 'img/lot-5.jpg', NOW() + INTERVAL 10 DAY, 4, 1),
                                                                                                        ('Маска Oakley Canopy', 'Clear view', 5400.00, 'img/lot-6.jpg', NOW() + INTERVAL 8 DAY, 6, 2);

-- Insert bids
INSERT INTO bids (bid_amount, bid_time, user_id, item_id) VALUES
                                                              (150.00, NOW(), 1, 1), -- User 1 makes a bid on Item 1
                                                              (250.00, NOW(), 2, 2); -- User 2 makes a bid on Item 2

-- Get all categories
SELECT * FROM categories;

-- Get the most recent, open lots along with their category title
SELECT items.title, items.starting_bid, items.image_url, MAX(bids.bid_amount) AS current_price, categories.title as category_title
FROM items
         JOIN bids ON items.id = bids.item_id
         JOIN categories ON items.category_id = categories.id
WHERE items.expires_at > NOW() AND bids.bid_time IN (SELECT MAX(bid_time) FROM bids GROUP BY item_id);

-- Show lot by its ID, along with the category title to which it belongs
SELECT items.*, categories.title as category_title
FROM items
         JOIN categories ON items.category_id = categories.id

WHERE items.id = 1;

-- Update lot title by its ID
UPDATE items SET title = '2014 Rossignol District Snowboard' WHERE id = 1;

-- Get the list of bids for an item by its ID, sorted by date
SELECT * FROM bids
WHERE item_id = id
ORDER BY bid_time DESC; -- Replace ? with actual item id