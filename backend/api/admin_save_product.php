<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Method not allowed', 405);
}

try {
    $id = $_POST['id'] ?? null;
    $title = $_POST['title'] ?? '';
    $description = $_POST['description'] ?? '';
    $price = $_POST['price'] ?? 0;
    $stock = $_POST['stock'] ?? 0;
    $rating = $_POST['rating'] ?? 0;
    $image_url = $_POST['image_url'] ?? '';
    $category_id = $_POST['category_id'] ?? null;
    $is_featured = $_POST['is_featured'] ?? 0;
    
    // Validation
    if (empty($title)) {
        sendError('Product title is required');
    }
    
    if ($price <= 0) {
        sendError('Price must be greater than 0');
    }
    
    if ($stock < 0) {
        sendError('Stock cannot be negative');
    }
    
    if ($id) {
        // Update existing product
        $stmt = $pdo->prepare("
            UPDATE products 
            SET title = ?, description = ?, price = ?, stock = ?, rating = ?, 
                image_url = ?, category_id = ?, is_featured = ?, updated_at = CURRENT_TIMESTAMP
            WHERE id = ?
        ");
        
        $result = $stmt->execute([
            $title, $description, $price, $stock, $rating, 
            $image_url, $category_id, $is_featured, $id
        ]);
    } else {
        // Create new product
        $stmt = $pdo->prepare("
            INSERT INTO products (title, description, price, stock, rating, image_url, category_id, is_featured) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ");
        
        $result = $stmt->execute([
            $title, $description, $price, $stock, $rating, 
            $image_url, $category_id, $is_featured
        ]);
    }
    
    if ($result) {
        sendResponse(['success' => true, 'message' => 'Product saved successfully']);
    } else {
        sendError('Failed to save product');
    }
} catch (PDOException $e) {
    sendError('Database error: ' . $e->getMessage(), 500);
}
?>