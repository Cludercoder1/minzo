<?php
require_once 'config.php';

try {
    $stmt = $pdo->query("SELECT * FROM categories ORDER BY name ASC");
    $categories = $stmt->fetchAll();
    
    sendResponse($categories);
} catch (PDOException $e) {
    sendError('Failed to fetch categories: ' . $e->getMessage(), 500);
}
?>