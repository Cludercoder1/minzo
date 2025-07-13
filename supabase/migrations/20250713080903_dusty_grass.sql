-- MinzoIT Database Schema with 200 Products

-- Create database
CREATE DATABASE IF NOT EXISTS minzo_db;
USE minzo_db;

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(500),
    category_id INT,
    is_featured BOOLEAN DEFAULT FALSE,
    rating DECIMAL(3,2) DEFAULT 0.00,
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Users table (for future authentication)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Admin users table
CREATE TABLE IF NOT EXISTS admin_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('admin', 'manager') DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Orders table (for future use)
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'preparing', 'out_for_delivery', 'delivered', 'cancelled') DEFAULT 'pending',
    delivery_address TEXT,
    phone VARCHAR(20),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Order items table (for future use)
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
);

-- Insert Categories
INSERT INTO categories (name, description, image_url) VALUES
('Fruits', 'Fresh and organic fruits', 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400'),
('Vegetables', 'Farm fresh vegetables', 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400'),
('Dairy', 'Fresh dairy products', 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400'),
('Snacks', 'Delicious snacks and treats', 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400'),
('Beverages', 'Refreshing drinks and beverages', 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400'),
('Grains & Cereals', 'Rice, wheat, and other grains', 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400'),
('Meat & Fish', 'Fresh meat and seafood', 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400'),
('Bakery', 'Fresh bread and baked goods', 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400'),
('Spices & Condiments', 'Herbs, spices, and seasonings', 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400'),
('Household', 'Cleaning and household items', 'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=400');

-- Insert 200 Products
INSERT INTO products (title, description, price, image_url, category_id, is_featured, rating, stock) VALUES
-- Fruits (Category 1) - 25 products
('Fresh Red Apples', 'Crispy and sweet red apples', 150.00, 'https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?auto=compress&cs=tinysrgb&w=400', 1, TRUE, 4.5, 50),
('Organic Bananas', 'Sweet and nutritious organic bananas', 80.00, 'https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=400', 1, TRUE, 4.3, 30),
('Fresh Oranges', 'Juicy and vitamin C rich oranges', 120.00, 'https://images.pexels.com/photos/161559/background-bitter-breakfast-bright-161559.jpeg?auto=compress&cs=tinysrgb&w=400', 1, TRUE, 4.4, 40),
('Green Grapes', 'Sweet seedless green grapes', 200.00, 'https://images.pexels.com/photos/708777/pexels-photo-708777.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.2, 25),
('Fresh Mangoes', 'Sweet and juicy mangoes', 180.00, 'https://images.pexels.com/photos/918327/pexels-photo-918327.jpeg?auto=compress&cs=tinysrgb&w=400', 1, TRUE, 4.6, 35),
('Strawberries', 'Fresh red strawberries', 250.00, 'https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&w=400', 1, TRUE, 4.7, 20),
('Pineapple', 'Sweet tropical pineapple', 160.00, 'https://images.pexels.com/photos/947879/pexels-photo-947879.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.3, 15),
('Watermelon', 'Refreshing summer watermelon', 100.00, 'https://images.pexels.com/photos/1313267/pexels-photo-1313267.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.1, 10),
('Papaya', 'Sweet and healthy papaya', 90.00, 'https://images.pexels.com/photos/2294471/pexels-photo-2294471.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.0, 18),
('Kiwi Fruit', 'Tangy and nutritious kiwi', 300.00, 'https://images.pexels.com/photos/1414130/pexels-photo-1414130.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.4, 12),
('Pomegranate', 'Antioxidant rich pomegranate', 220.00, 'https://images.pexels.com/photos/65256/pomegranate-open-cores-fruit-65256.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.5, 22),
('Avocado', 'Creamy and healthy avocado', 280.00, 'https://images.pexels.com/photos/557659/pexels-photo-557659.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.3, 16),
('Dragon Fruit', 'Exotic dragon fruit', 350.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.2, 8),
('Coconut', 'Fresh coconut', 80.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.0, 25),
('Lemon', 'Fresh lemons', 60.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.1, 30),
('Lime', 'Tangy limes', 50.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.0, 35),
('Guava', 'Sweet guava fruit', 120.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.2, 20),
('Litchi', 'Sweet litchi fruit', 200.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.4, 15),
('Custard Apple', 'Sweet custard apple', 180.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.3, 12),
('Jackfruit', 'Sweet jackfruit', 150.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.1, 8),
('Passion Fruit', 'Tangy passion fruit', 320.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.5, 10),
('Star Fruit', 'Unique star fruit', 250.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.2, 6),
('Rambutan', 'Exotic rambutan', 400.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.3, 5),
('Persimmon', 'Sweet persimmon', 280.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.1, 8),
('Fig', 'Fresh figs', 350.00, 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400', 1, FALSE, 4.4, 7),

-- Vegetables (Category 2) - 30 products
('Fresh Tomatoes', 'Red ripe tomatoes', 90.00, 'https://images.pexels.com/photos/533280/pexels-photo-533280.jpeg?auto=compress&cs=tinysrgb&w=400', 2, TRUE, 4.4, 35),
('Onions', 'Fresh red onions', 70.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.2, 50),
('Potatoes', 'Fresh potatoes', 60.00, 'https://images.pexels.com/photos/144248/potatoes-vegetables-erdfrucht-bio-144248.jpeg?auto=compress&cs=tinysrgb&w=400', 2, TRUE, 4.3, 60),
('Carrots', 'Orange carrots', 80.00, 'https://images.pexels.com/photos/143133/pexels-photo-143133.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.1, 40),
('Cabbage', 'Fresh green cabbage', 50.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.0, 25),
('Cauliflower', 'White cauliflower', 85.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.2, 30),
('Broccoli', 'Green broccoli', 120.00, 'https://images.pexels.com/photos/47347/broccoli-vegetable-food-healthy-47347.jpeg?auto=compress&cs=tinysrgb&w=400', 2, TRUE, 4.5, 20),
('Bell Peppers', 'Colorful bell peppers', 150.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.3, 25),
('Cucumber', 'Fresh cucumber', 40.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.1, 35),
('Spinach', 'Fresh spinach leaves', 60.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, TRUE, 4.4, 30),
('Lettuce', 'Crispy lettuce', 80.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.2, 20),
('Radish', 'Fresh radish', 45.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.0, 25),
('Beetroot', 'Red beetroot', 70.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.1, 20),
('Sweet Potato', 'Orange sweet potato', 90.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.3, 25),
('Ginger', 'Fresh ginger root', 200.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.4, 15),
('Garlic', 'Fresh garlic bulbs', 180.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.3, 20),
('Green Chili', 'Spicy green chilies', 100.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.2, 30),
('Eggplant', 'Purple eggplant', 80.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.1, 25),
('Okra', 'Fresh okra', 90.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.0, 20),
('Green Beans', 'Fresh green beans', 110.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.2, 25),
('Peas', 'Fresh green peas', 120.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.3, 20),
('Corn', 'Sweet corn', 80.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.1, 30),
('Mushrooms', 'Fresh mushrooms', 200.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, TRUE, 4.5, 15),
('Zucchini', 'Fresh zucchini', 100.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.2, 18),
('Pumpkin', 'Orange pumpkin', 60.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.0, 12),
('Bottle Gourd', 'Fresh bottle gourd', 50.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 3.9, 15),
('Bitter Gourd', 'Fresh bitter gourd', 80.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 3.8, 12),
('Ridge Gourd', 'Fresh ridge gourd', 70.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.0, 15),
('Snake Gourd', 'Fresh snake gourd', 60.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 3.9, 10),
('Drumstick', 'Fresh drumstick', 90.00, 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400', 2, FALSE, 4.1, 18),

-- Dairy (Category 3) - 20 products
('Fresh Milk', 'Pure dairy milk', 120.00, 'https://images.pexels.com/photos/248412/pexels-photo-248412.jpeg?auto=compress&cs=tinysrgb&w=400', 3, TRUE, 4.7, 25),
('Greek Yogurt', 'Thick Greek yogurt', 180.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, TRUE, 4.6, 20),
('Cheddar Cheese', 'Aged cheddar cheese', 350.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.5, 15),
('Butter', 'Fresh dairy butter', 280.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, TRUE, 4.4, 30),
('Cream', 'Heavy cream', 200.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.3, 18),
('Cottage Cheese', 'Fresh cottage cheese', 160.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.2, 22),
('Mozzarella', 'Fresh mozzarella', 320.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.4, 12),
('Sour Cream', 'Tangy sour cream', 220.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.1, 15),
('Cream Cheese', 'Smooth cream cheese', 250.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.3, 18),
('Parmesan Cheese', 'Grated parmesan', 400.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.6, 10),
('Whole Milk', 'Full fat milk', 110.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.5, 30),
('Skim Milk', 'Low fat milk', 100.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.2, 25),
('Buttermilk', 'Fresh buttermilk', 80.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.1, 20),
('Ghee', 'Pure clarified butter', 500.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, TRUE, 4.8, 15),
('Paneer', 'Fresh cottage cheese', 300.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, TRUE, 4.5, 20),
('Lassi', 'Sweet yogurt drink', 60.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.3, 25),
('Kheer', 'Sweet rice pudding', 120.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.4, 12),
('Rasgulla', 'Sweet cheese balls', 150.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.6, 15),
('Curd', 'Fresh yogurt', 80.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, FALSE, 4.2, 30),
('Ice Cream', 'Vanilla ice cream', 200.00, 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400', 3, TRUE, 4.7, 18),

-- Snacks (Category 4) - 25 products
('Potato Chips', 'Crispy potato chips', 60.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.1, 40),
('Chocolate Cookies', 'Sweet chocolate cookies', 80.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, TRUE, 4.4, 35),
('Peanuts', 'Roasted peanuts', 120.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.2, 30),
('Almonds', 'Premium almonds', 800.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, TRUE, 4.6, 20),
('Cashews', 'Roasted cashews', 900.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, TRUE, 4.7, 15),
('Walnuts', 'Fresh walnuts', 1200.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.5, 12),
('Pistachios', 'Salted pistachios', 1500.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.6, 10),
('Raisins', 'Sweet raisins', 300.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.3, 25),
('Dates', 'Fresh dates', 400.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, TRUE, 4.5, 20),
('Pretzels', 'Salty pretzels', 150.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.0, 30),
('Popcorn', 'Butter popcorn', 100.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.1, 25),
('Crackers', 'Wheat crackers', 80.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 3.9, 35),
('Granola Bars', 'Healthy granola bars', 200.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, TRUE, 4.3, 20),
('Trail Mix', 'Mixed nuts and fruits', 350.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.4, 18),
('Chocolate Bar', 'Dark chocolate bar', 120.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, TRUE, 4.5, 40),
('Gummy Bears', 'Fruit gummy bears', 90.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.2, 30),
('Beef Jerky', 'Spicy beef jerky', 400.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.3, 15),
('Sunflower Seeds', 'Roasted sunflower seeds', 180.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.1, 25),
('Pumpkin Seeds', 'Roasted pumpkin seeds', 250.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.2, 20),
('Rice Cakes', 'Plain rice cakes', 70.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 3.8, 30),
('Fruit Leather', 'Natural fruit leather', 150.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.0, 22),
('Cheese Puffs', 'Cheesy puffs', 80.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.1, 35),
('Tortilla Chips', 'Corn tortilla chips', 100.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.2, 28),
('Energy Bars', 'Protein energy bars', 180.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, FALSE, 4.3, 25),
('Dried Fruits', 'Mixed dried fruits', 320.00, 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400', 4, TRUE, 4.4, 18),

-- Beverages (Category 5) - 25 products
('Orange Juice', 'Fresh orange juice', 180.00, 'https://images.pexels.com/photos/96974/pexels-photo-96974.jpeg?auto=compress&cs=tinysrgb&w=400', 5, TRUE, 4.6, 20),
('Apple Juice', 'Pure apple juice', 160.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.4, 25),
('Mango Juice', 'Sweet mango juice', 200.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, TRUE, 4.5, 18),
('Coconut Water', 'Natural coconut water', 120.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, TRUE, 4.7, 30),
('Green Tea', 'Organic green tea', 250.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.3, 40),
('Black Coffee', 'Premium black coffee', 300.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, TRUE, 4.6, 35),
('Energy Drink', 'Sports energy drink', 150.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.1, 50),
('Soda Water', 'Sparkling soda water', 60.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.0, 60),
('Lemonade', 'Fresh lemonade', 80.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.2, 40),
('Iced Tea', 'Refreshing iced tea', 100.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.1, 35),
('Smoothie', 'Mixed fruit smoothie', 220.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, TRUE, 4.5, 15),
('Protein Shake', 'Vanilla protein shake', 280.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.3, 20),
('Herbal Tea', 'Chamomile herbal tea', 200.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.2, 30),
('Hot Chocolate', 'Rich hot chocolate', 150.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.4, 25),
('Mineral Water', 'Pure mineral water', 40.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.5, 100),
('Sports Drink', 'Electrolyte sports drink', 120.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.2, 45),
('Fruit Punch', 'Mixed fruit punch', 140.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.1, 30),
('Cranberry Juice', 'Tart cranberry juice', 220.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.3, 20),
('Grape Juice', 'Sweet grape juice', 180.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.2, 25),
('Tomato Juice', 'Fresh tomato juice', 100.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 3.9, 20),
('Carrot Juice', 'Fresh carrot juice', 120.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.1, 18),
('Beetroot Juice', 'Healthy beetroot juice', 150.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.0, 15),
('Aloe Vera Drink', 'Refreshing aloe vera', 180.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.2, 22),
('Kombucha', 'Probiotic kombucha', 300.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, FALSE, 4.4, 12),
('Cold Brew Coffee', 'Smooth cold brew', 250.00, 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400', 5, TRUE, 4.5, 20),

-- Grains & Cereals (Category 6) - 20 products
('Basmati Rice', 'Premium basmati rice', 180.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, TRUE, 4.6, 50),
('Brown Rice', 'Healthy brown rice', 160.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, TRUE, 4.4, 40),
('Quinoa', 'Organic quinoa', 400.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.5, 25),
('Oats', 'Rolled oats', 120.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, TRUE, 4.3, 60),
('Wheat Flour', 'All-purpose flour', 80.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.2, 80),
('Whole Wheat Flour', 'Healthy whole wheat', 90.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, TRUE, 4.4, 70),
('Barley', 'Pearl barley', 140.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.1, 30),
('Millet', 'Nutritious millet', 100.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.0, 35),
('Cornmeal', 'Yellow cornmeal', 70.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 3.9, 40),
('Buckwheat', 'Gluten-free buckwheat', 200.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.2, 20),
('Rye Flour', 'Dark rye flour', 150.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.1, 25),
('Semolina', 'Durum semolina', 110.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.0, 45),
('Rice Flour', 'Fine rice flour', 90.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.1, 35),
('Chickpea Flour', 'Protein-rich besan', 120.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.3, 40),
('Corn Flakes', 'Breakfast corn flakes', 180.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, TRUE, 4.2, 50),
('Granola', 'Mixed nuts granola', 300.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.4, 30),
('Muesli', 'Fruit and nut muesli', 250.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.3, 25),
('Pasta', 'Durum wheat pasta', 120.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.2, 60),
('Noodles', 'Instant noodles', 40.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 3.8, 100),
('Bread Crumbs', 'Fine bread crumbs', 80.00, 'https://images.pexels.com/photos/1537169/pexels-photo-1537169.jpeg?auto=compress&cs=tinysrgb&w=400', 6, FALSE, 4.0, 30),

-- Meat & Fish (Category 7) - 20 products
('Chicken Breast', 'Fresh chicken breast', 350.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, TRUE, 4.5, 25),
('Mutton', 'Fresh mutton', 800.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, TRUE, 4.6, 15),
('Fish Fillet', 'Fresh fish fillet', 400.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, TRUE, 4.4, 20),
('Prawns', 'Fresh prawns', 600.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.3, 12),
('Salmon', 'Atlantic salmon', 900.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.7, 8),
('Tuna', 'Fresh tuna steak', 700.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.5, 10),
('Chicken Thighs', 'Juicy chicken thighs', 280.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.3, 30),
('Ground Beef', 'Lean ground beef', 450.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.4, 20),
('Pork Chops', 'Fresh pork chops', 380.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.2, 18),
('Crab', 'Fresh crab', 800.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.6, 6),
('Lobster', 'Fresh lobster', 1200.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.8, 4),
('Chicken Wings', 'Spicy chicken wings', 320.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.3, 25),
('Duck', 'Whole duck', 600.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.4, 8),
('Turkey', 'Turkey breast', 500.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.3, 10),
('Mackerel', 'Fresh mackerel', 300.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.2, 15),
('Sardines', 'Fresh sardines', 250.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.1, 20),
('Squid', 'Fresh squid', 400.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.0, 12),
('Octopus', 'Fresh octopus', 600.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.2, 8),
('Bacon', 'Smoked bacon strips', 450.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.4, 22),
('Sausages', 'Mixed sausages', 350.00, 'https://images.pexels.com/photos/361184/pexels-photo-361184.jpeg?auto=compress&cs=tinysrgb&w=400', 7, FALSE, 4.1, 30),

-- Bakery (Category 8) - 15 products
('White Bread', 'Fresh white bread', 60.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, TRUE, 4.2, 40),
('Whole Wheat Bread', 'Healthy wheat bread', 80.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, TRUE, 4.4, 35),
('Croissants', 'Buttery croissants', 120.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, FALSE, 4.3, 20),
('Bagels', 'Fresh bagels', 100.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, FALSE, 4.1, 25),
('Muffins', 'Blueberry muffins', 150.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, TRUE, 4.5, 18),
('Donuts', 'Glazed donuts', 80.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, FALSE, 4.2, 30),
('Cake', 'Chocolate cake slice', 200.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, TRUE, 4.6, 12),
('Cookies', 'Chocolate chip cookies', 120.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, FALSE, 4.3, 40),
('Pies', 'Apple pie slice', 180.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, FALSE, 4.4, 15),
('Pastries', 'Danish pastries', 140.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, FALSE, 4.2, 20),
('Baguette', 'French baguette', 90.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, FALSE, 4.1, 25),
('Rolls', 'Dinner rolls', 70.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, FALSE, 4.0, 35),
('Cupcakes', 'Vanilla cupcakes', 160.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, TRUE, 4.5, 24),
('Brownies', 'Fudge brownies', 180.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, FALSE, 4.4, 20),
('Cheesecake', 'New York cheesecake', 250.00, 'https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400', 8, TRUE, 4.7, 10),

-- Spices & Condiments (Category 9) - 15 products
('Black Pepper', 'Ground black pepper', 200.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, FALSE, 4.3, 50),
('Turmeric Powder', 'Pure turmeric powder', 150.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, TRUE, 4.5, 40),
('Cumin Seeds', 'Whole cumin seeds', 180.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, FALSE, 4.2, 35),
('Coriander Powder', 'Ground coriander', 120.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, FALSE, 4.1, 45),
('Red Chili Powder', 'Spicy chili powder', 160.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, TRUE, 4.4, 30),
('Garam Masala', 'Mixed spice blend', 220.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, FALSE, 4.6, 25),
('Salt', 'Iodized table salt', 40.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, FALSE, 4.0, 100),
('Sugar', 'White granulated sugar', 80.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, FALSE, 4.1, 80),
('Vinegar', 'White vinegar', 60.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, FALSE, 4.0, 60),
('Soy Sauce', 'Dark soy sauce', 100.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, FALSE, 4.2, 40),
('Olive Oil', 'Extra virgin olive oil', 400.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, TRUE, 4.7, 20),
('Mustard Oil', 'Pure mustard oil', 180.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, FALSE, 4.3, 30),
('Tomato Ketchup', 'Sweet tomato ketchup', 120.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, FALSE, 4.1, 50),
('Mayonnaise', 'Creamy mayonnaise', 150.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, FALSE, 4.2, 35),
('Honey', 'Pure natural honey', 300.00, 'https://images.pexels.com/photos/277253/pexels-photo-277253.jpeg?auto=compress&cs=tinysrgb&w=400', 9, TRUE, 4.6, 25),

-- Household (Category 10) - 10 products
('Dish Soap', 'Lemon dish soap', 80.00, 'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=400', 10, FALSE, 4.1, 60),
('Laundry Detergent', 'Powder detergent', 200.00, 'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=400', 10, TRUE, 4.3, 40),
('Toilet Paper', 'Soft toilet paper', 120.00, 'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=400', 10, FALSE, 4.2, 80),
('Paper Towels', 'Absorbent paper towels', 100.00, 'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=400', 10, FALSE, 4.0, 50),
('Trash Bags', 'Heavy duty trash bags', 150.00, 'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=400', 10, FALSE, 4.1, 30),
('All-Purpose Cleaner', 'Multi-surface cleaner', 180.00, 'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=400', 10, FALSE, 4.2, 35),
('Sponges', 'Kitchen sponges', 60.00, 'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=400', 10, FALSE, 3.9, 70),
('Aluminum Foil', 'Heavy duty foil', 120.00, 'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=400', 10, FALSE, 4.0, 40),
('Plastic Wrap', 'Food storage wrap', 80.00, 'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=400', 10, FALSE, 3.8, 45),
('Air Freshener', 'Lavender air freshener', 100.00, 'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=400', 10, FALSE, 4.1, 25);

-- Insert default admin user (password: admin123)
INSERT INTO admin_users (username, email, password, full_name, role) VALUES
('admin', 'admin@minzoit.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'MinzoIT Admin', 'admin');