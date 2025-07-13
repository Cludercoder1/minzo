// Admin Panel JavaScript

let products = [];
let categories = [];
let currentSection = 'dashboard';

// Initialize admin panel
document.addEventListener('DOMContentLoaded', function() {
    loadDashboard();
    loadCategories();
});

// Navigation functions
function showDashboard() {
    hideAllSections();
    document.getElementById('dashboard-section').style.display = 'block';
    setActiveNav('dashboard');
    loadDashboard();
}

function showProducts() {
    hideAllSections();
    document.getElementById('products-section').style.display = 'block';
    setActiveNav('products');
    loadProducts();
}

function showCategories() {
    hideAllSections();
    document.getElementById('categories-section').style.display = 'block';
    setActiveNav('categories');
    loadCategories();
}

function showOrders() {
    hideAllSections();
    document.getElementById('orders-section').style.display = 'block';
    setActiveNav('orders');
}

function showUsers() {
    hideAllSections();
    document.getElementById('users-section').style.display = 'block';
    setActiveNav('users');
}

function hideAllSections() {
    const sections = ['dashboard-section', 'products-section', 'categories-section', 'orders-section', 'users-section'];
    sections.forEach(section => {
        document.getElementById(section).style.display = 'none';
    });
}

function setActiveNav(section) {
    document.querySelectorAll('.sidebar .nav-link').forEach(link => {
        link.classList.remove('active');
    });
    
    const navMap = {
        'dashboard': 0,
        'products': 1,
        'categories': 2,
        'orders': 3,
        'users': 4
    };
    
    const navLinks = document.querySelectorAll('.sidebar .nav-link');
    if (navLinks[navMap[section]]) {
        navLinks[navMap[section]].classList.add('active');
    }
}

// Dashboard functions
async function loadDashboard() {
    try {
        // Load stats
        const statsResponse = await fetch('../api/admin_stats.php');
        const stats = await statsResponse.json();
        
        document.getElementById('total-products').textContent = stats.total_products || 0;
        document.getElementById('total-categories').textContent = stats.total_categories || 0;
        document.getElementById('featured-products').textContent = stats.featured_products || 0;
        document.getElementById('low-stock').textContent = stats.low_stock || 0;
        
        // Load recent products
        const recentResponse = await fetch('../api/admin_recent_products.php');
        const recentProducts = await recentResponse.json();
        
        const tableBody = document.getElementById('recent-products-table');
        tableBody.innerHTML = '';
        
        recentProducts.forEach(product => {
            const row = `
                <tr>
                    <td><img src="${product.image_url}" class="product-image" alt="${product.title}"></td>
                    <td>${product.title}</td>
                    <td>${product.category_name || 'N/A'}</td>
                    <td>Rs. ${parseFloat(product.price).toFixed(2)}</td>
                    <td>${product.stock}</td>
                    <td>
                        ${product.is_featured == 1 ? '<span class="badge badge-featured">Featured</span>' : ''}
                        ${product.stock < 10 ? '<span class="badge bg-warning">Low Stock</span>' : ''}
                    </td>
                </tr>
            `;
            tableBody.innerHTML += row;
        });
    } catch (error) {
        console.error('Error loading dashboard:', error);
    }
}

// Products functions
async function loadProducts() {
    try {
        const response = await fetch('../api/admin_products.php');
        products = await response.json();
        
        // Load categories for filter
        await loadCategoriesForFilter();
        
        displayProducts(products);
    } catch (error) {
        console.error('Error loading products:', error);
    }
}

function displayProducts(productsToShow) {
    const tableBody = document.getElementById('products-table');
    tableBody.innerHTML = '';
    
    productsToShow.forEach(product => {
        const row = `
            <tr>
                <td><img src="${product.image_url}" class="product-image" alt="${product.title}"></td>
                <td>
                    <strong>${product.title}</strong><br>
                    <small class="text-muted">${product.description || ''}</small>
                </td>
                <td>${product.category_name || 'N/A'}</td>
                <td>Rs. ${parseFloat(product.price).toFixed(2)}</td>
                <td>
                    ${product.stock}
                    ${product.stock < 10 ? '<span class="badge bg-warning ms-1">Low</span>' : ''}
                </td>
                <td>
                    <div class="d-flex align-items-center">
                        <span class="me-2">${product.rating || 0}</span>
                        <div class="text-warning">
                            ${'★'.repeat(Math.floor(product.rating || 0))}${'☆'.repeat(5 - Math.floor(product.rating || 0))}
                        </div>
                    </div>
                </td>
                <td>
                    ${product.is_featured == 1 ? '<span class="badge badge-featured">Featured</span>' : '<span class="badge bg-secondary">Regular</span>'}
                </td>
                <td>
                    <button class="btn btn-sm btn-outline-primary me-1" onclick="editProduct(${product.id})">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn btn-sm btn-outline-danger" onclick="deleteProduct(${product.id})">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            </tr>
        `;
        tableBody.innerHTML += row;
    });
}

async function loadCategoriesForFilter() {
    const categoryFilter = document.getElementById('category-filter');
    const productCategory = document.getElementById('product-category');
    
    categoryFilter.innerHTML = '<option value="">All Categories</option>';
    productCategory.innerHTML = '<option value="">Select Category</option>';
    
    categories.forEach(category => {
        categoryFilter.innerHTML += `<option value="${category.id}">${category.name}</option>`;
        productCategory.innerHTML += `<option value="${category.id}">${category.name}</option>`;
    });
}

function filterProducts() {
    const categoryFilter = document.getElementById('category-filter').value;
    const featuredFilter = document.getElementById('featured-filter').value;
    const searchTerm = document.getElementById('search-products').value.toLowerCase();
    
    let filteredProducts = products;
    
    if (categoryFilter) {
        filteredProducts = filteredProducts.filter(p => p.category_id == categoryFilter);
    }
    
    if (featuredFilter !== '') {
        filteredProducts = filteredProducts.filter(p => p.is_featured == featuredFilter);
    }
    
    if (searchTerm) {
        filteredProducts = filteredProducts.filter(p => 
            p.title.toLowerCase().includes(searchTerm) || 
            (p.description && p.description.toLowerCase().includes(searchTerm))
        );
    }
    
    displayProducts(filteredProducts);
}

function clearFilters() {
    document.getElementById('category-filter').value = '';
    document.getElementById('featured-filter').value = '';
    document.getElementById('search-products').value = '';
    displayProducts(products);
}

function showAddProductModal() {
    document.getElementById('productModalTitle').textContent = 'Add Product';
    document.getElementById('productForm').reset();
    document.getElementById('product-id').value = '';
    new bootstrap.Modal(document.getElementById('productModal')).show();
}

function editProduct(id) {
    const product = products.find(p => p.id == id);
    if (!product) return;
    
    document.getElementById('productModalTitle').textContent = 'Edit Product';
    document.getElementById('product-id').value = product.id;
    document.getElementById('product-title').value = product.title;
    document.getElementById('product-description').value = product.description || '';
    document.getElementById('product-price').value = product.price;
    document.getElementById('product-stock').value = product.stock;
    document.getElementById('product-rating').value = product.rating || '';
    document.getElementById('product-image').value = product.image_url || '';
    document.getElementById('product-category').value = product.category_id || '';
    document.getElementById('product-featured').checked = product.is_featured == 1;
    
    new bootstrap.Modal(document.getElementById('productModal')).show();
}

async function saveProduct() {
    const formData = new FormData();
    const productId = document.getElementById('product-id').value;
    
    formData.append('title', document.getElementById('product-title').value);
    formData.append('description', document.getElementById('product-description').value);
    formData.append('price', document.getElementById('product-price').value);
    formData.append('stock', document.getElementById('product-stock').value);
    formData.append('rating', document.getElementById('product-rating').value || 0);
    formData.append('image_url', document.getElementById('product-image').value);
    formData.append('category_id', document.getElementById('product-category').value);
    formData.append('is_featured', document.getElementById('product-featured').checked ? 1 : 0);
    
    if (productId) {
        formData.append('id', productId);
    }
    
    try {
        const response = await fetch('../api/admin_save_product.php', {
            method: 'POST',
            body: formData
        });
        
        const result = await response.json();
        
        if (result.success) {
            bootstrap.Modal.getInstance(document.getElementById('productModal')).hide();
            loadProducts();
            showAlert('Product saved successfully!', 'success');
        } else {
            showAlert('Error saving product: ' + result.message, 'danger');
        }
    } catch (error) {
        console.error('Error saving product:', error);
        showAlert('Error saving product', 'danger');
    }
}

async function deleteProduct(id) {
    if (!confirm('Are you sure you want to delete this product?')) return;
    
    try {
        const response = await fetch('../api/admin_delete_product.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ id: id })
        });
        
        const result = await response.json();
        
        if (result.success) {
            loadProducts();
            showAlert('Product deleted successfully!', 'success');
        } else {
            showAlert('Error deleting product: ' + result.message, 'danger');
        }
    } catch (error) {
        console.error('Error deleting product:', error);
        showAlert('Error deleting product', 'danger');
    }
}

// Categories functions
async function loadCategories() {
    try {
        const response = await fetch('../api/admin_categories.php');
        categories = await response.json();
        
        displayCategories(categories);
    } catch (error) {
        console.error('Error loading categories:', error);
    }
}

function displayCategories(categoriesToShow) {
    const tableBody = document.getElementById('categories-table');
    tableBody.innerHTML = '';
    
    categoriesToShow.forEach(category => {
        const row = `
            <tr>
                <td><img src="${category.image_url}" class="product-image" alt="${category.name}"></td>
                <td><strong>${category.name}</strong></td>
                <td>${category.description || ''}</td>
                <td>${category.product_count || 0}</td>
                <td>
                    <button class="btn btn-sm btn-outline-primary me-1" onclick="editCategory(${category.id})">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn btn-sm btn-outline-danger" onclick="deleteCategory(${category.id})">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            </tr>
        `;
        tableBody.innerHTML += row;
    });
}

function showAddCategoryModal() {
    document.getElementById('categoryModalTitle').textContent = 'Add Category';
    document.getElementById('categoryForm').reset();
    document.getElementById('category-id').value = '';
    new bootstrap.Modal(document.getElementById('categoryModal')).show();
}

function editCategory(id) {
    const category = categories.find(c => c.id == id);
    if (!category) return;
    
    document.getElementById('categoryModalTitle').textContent = 'Edit Category';
    document.getElementById('category-id').value = category.id;
    document.getElementById('category-name').value = category.name;
    document.getElementById('category-description').value = category.description || '';
    document.getElementById('category-image').value = category.image_url || '';
    
    new bootstrap.Modal(document.getElementById('categoryModal')).show();
}

async function saveCategory() {
    const formData = new FormData();
    const categoryId = document.getElementById('category-id').value;
    
    formData.append('name', document.getElementById('category-name').value);
    formData.append('description', document.getElementById('category-description').value);
    formData.append('image_url', document.getElementById('category-image').value);
    
    if (categoryId) {
        formData.append('id', categoryId);
    }
    
    try {
        const response = await fetch('../api/admin_save_category.php', {
            method: 'POST',
            body: formData
        });
        
        const result = await response.json();
        
        if (result.success) {
            bootstrap.Modal.getInstance(document.getElementById('categoryModal')).hide();
            loadCategories();
            showAlert('Category saved successfully!', 'success');
        } else {
            showAlert('Error saving category: ' + result.message, 'danger');
        }
    } catch (error) {
        console.error('Error saving category:', error);
        showAlert('Error saving category', 'danger');
    }
}

async function deleteCategory(id) {
    if (!confirm('Are you sure you want to delete this category? This will affect all products in this category.')) return;
    
    try {
        const response = await fetch('../api/admin_delete_category.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ id: id })
        });
        
        const result = await response.json();
        
        if (result.success) {
            loadCategories();
            showAlert('Category deleted successfully!', 'success');
        } else {
            showAlert('Error deleting category: ' + result.message, 'danger');
        }
    } catch (error) {
        console.error('Error deleting category:', error);
        showAlert('Error deleting category', 'danger');
    }
}

// Utility functions
function showAlert(message, type) {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
    alertDiv.style.top = '20px';
    alertDiv.style.right = '20px';
    alertDiv.style.zIndex = '9999';
    alertDiv.innerHTML = `
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    document.body.appendChild(alertDiv);
    
    setTimeout(() => {
        alertDiv.remove();
    }, 5000);
}

function logout() {
    if (confirm('Are you sure you want to logout?')) {
        window.location.href = 'login.php';
    }
}