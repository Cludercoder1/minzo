<?php
require_once 'config.php';

try {
    $stmt = $pdo->query("
        SELECT p.*, c.name as category_name 
        FROM products p 
        LEFT JOIN categories c ON p.category_id = c.id 
        WHERE p.is_featured = 1 AND p.stock > 0 
        ORDER BY p.created_at DESC 
        LIMIT 20
    ");
    
    $products = $stmt->fetchAll();
    
    sendResponse($products);
} catch (PDOException $e) {
    sendError('Failed to fetch featured products: ' . $e->getMessage(), 500);
}
?>