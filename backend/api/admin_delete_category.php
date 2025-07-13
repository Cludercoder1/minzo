<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Method not allowed', 405);
}

try {
    $input = json_decode(file_get_contents('php://input'), true);
    $id = $input['id'] ?? null;
    
    if (!$id) {
        sendError('Category ID is required');
    }
    
    // Check if category has products
    $stmt = $pdo->prepare("SELECT COUNT(*) as count FROM products WHERE category_id = ?");
    $stmt->execute([$id]);
    $productCount = $stmt->fetch()['count'];
    
    if ($productCount > 0) {
        // Set category_id to NULL for products in this category
        $stmt = $pdo->prepare("UPDATE products SET category_id = NULL WHERE category_id = ?");
        $stmt->execute([$id]);
    }
    
    // Delete the category
    $stmt = $pdo->prepare("DELETE FROM categories WHERE id = ?");
    $result = $stmt->execute([$id]);
    
    if ($result) {
        sendResponse(['success' => true, 'message' => 'Category deleted successfully']);
    } else {
        sendError('Failed to delete category');
    }
} catch (PDOException $e) {
    sendError('Database error: ' . $e->getMessage(), 500);
}
?>