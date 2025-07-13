<?php
require_once 'config.php';

try {
    $stmt = $pdo->query("
        SELECT c.*, 
               COUNT(p.id) as product_count
        FROM categories c 
        LEFT JOIN products p ON c.id = p.category_id 
        GROUP BY c.id 
        ORDER BY c.name ASC
    ");
    
    $categories = $stmt->fetchAll();
    
    sendResponse($categories);
} catch (PDOException $e) {
    sendError('Failed to fetch categories: ' . $e->getMessage(), 500);
}
?>