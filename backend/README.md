# MinzoIT Backend API

## Setup Instructions

### 1. Database Setup
1. Create a MySQL database named `minzo_db`
2. Import the schema from `database/schema.sql`
3. Update database credentials in `api/config.php`

### 2. Server Configuration
1. Upload all files to your cPanel public_html directory
2. Ensure PHP 7.4+ is enabled
3. Enable CORS headers (already configured in config.php)

### 3. API Endpoints

#### Categories
- **GET** `/api/categories.php` - Get all categories

#### Products
- **GET** `/api/products.php` - Get all products
- **GET** `/api/products.php?category_id=1` - Get products by category

#### Featured Products
- **GET** `/api/featured_products.php` - Get featured products

### 4. Database Schema

#### Categories Table
- `id` - Primary key
- `name` - Category name
- `description` - Category description
- `image_url` - Category image URL
- `created_at` - Creation timestamp
- `updated_at` - Update timestamp

#### Products Table
- `id` - Primary key
- `title` - Product title
- `description` - Product description
- `price` - Product price (decimal)
- `image_url` - Product image URL
- `category_id` - Foreign key to categories
- `is_featured` - Boolean for featured products
- `rating` - Product rating (0-5)
- `stock` - Available stock quantity
- `created_at` - Creation timestamp
- `updated_at` - Update timestamp

### 5. Sample Data
The schema includes sample categories and products to get you started.

### 6. Security Notes
- Update database credentials in config.php
- Consider implementing API authentication for production
- Validate and sanitize all inputs
- Use HTTPS in production

### 7. Future Enhancements
- User authentication endpoints
- Order management APIs
- Payment integration
- Admin panel APIs
- Push notification system