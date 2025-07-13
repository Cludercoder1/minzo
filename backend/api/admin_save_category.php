<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError('Method not allowed', 405);
}

try {
    $id = $_POST['id'] ?? null;
    $name = $_POST['name'] ?? '';
    $description = $_POST['description'] ?? '';
    $image_url = $_POST['image_url'] ?? '';
    
    // Validation
    if (empty($name)) {
        sendError('Category name is required');
    }
    
    if ($id) {
        // Update existing category
        $stmt = $pdo->prepare("
            UPDATE categories 
            SET name = ?, description = ?, image_url = ?, updated_at = CURRENT_TIMESTAMP
            WHERE id = ?
        ");
        
        $result = $stmt->execute([$name, $description, $image_url, $id]);
    } else {
        // Create new category
        $stmt = $pdo->prepare("
            INSERT INTO categories (name, description, image_url) 
            VALUES (?, ?, ?)
        ");
        
        $result = $stmt->execute([$name, $description, $image_url]);
    }
    
    if ($result) {
        sendResponse(['success' => true, 'message' => 'Category saved successfully']);
    } else {
        sendError('Failed to save category');
    }
} catch (PDOException $e) {
    sendError('Database error: ' . $e->getMessage(), 500);
}
?>