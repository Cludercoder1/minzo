<?php
require_once 'config.php';

try {
    // Get total products
    $stmt = $pdo->query("SELECT COUNT(*) as total FROM products");
    $totalProducts = $stmt->fetch()['total'];
    
    // Get total categories
    $stmt = $pdo->query("SELECT COUNT(*) as total FROM categories");
    $totalCategories = $stmt->fetch()['total'];
    
    // Get featured products
    $stmt = $pdo->query("SELECT COUNT(*) as total FROM products WHERE is_featured = 1");
    $featuredProducts = $stmt->fetch()['total'];
    
    // Get low stock products (less than 10)
    $stmt = $pdo->query("SELECT COUNT(*) as total FROM products WHERE stock < 10");
    $lowStock = $stmt->fetch()['total'];
    
    $stats = [
        'total_products' => $totalProducts,
        'total_categories' => $totalCategories,
        'featured_products' => $featuredProducts,
        'low_stock' => $lowStock
    ];
    
    sendResponse($stats);
} catch (PDOException $e) {
    sendError('Failed to fetch stats: ' . $e->getMessage(), 500);
}
?>