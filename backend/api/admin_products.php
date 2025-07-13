<?php
require_once 'config.php';

try {
    $stmt = $pdo->query("
        SELECT p.*, c.name as category_name 
        FROM products p 
        LEFT JOIN categories c ON p.category_id = c.id 
        ORDER BY p.created_at DESC
    ");
    
    $products = $stmt->fetchAll();
    
    sendResponse($products);
} catch (PDOException $e) {
    sendError('Failed to fetch products: ' . $e->getMessage(), 500);
}
?>