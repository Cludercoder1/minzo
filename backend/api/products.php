<?php
require_once 'config.php';

try {
    $category_id = $_GET['category_id'] ?? null;
    
    $sql = "SELECT p.*, c.name as category_name 
            FROM products p 
            LEFT JOIN categories c ON p.category_id = c.id 
            WHERE p.stock > 0";
    
    $params = [];
    
    if ($category_id) {
        $sql .= " AND p.category_id = ?";
        $params[] = $category_id;
    }
    
    $sql .= " ORDER BY p.created_at DESC";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    $products = $stmt->fetchAll();
    
    sendResponse($products);
} catch (PDOException $e) {
    sendError('Failed to fetch products: ' . $e->getMessage(), 500);
}
?>