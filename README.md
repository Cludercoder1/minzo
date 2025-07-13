# MinzoIT - Grocery Delivery App

A modern Flutter-based grocery delivery application with PHP backend, designed for the MinzoIT brand in Birgunj.

## 🚀 Features

### Frontend (Flutter)
- **Modern UI/UX**: Clean, responsive design with MinzoIT branding
- **Video Banner**: Auto-playing promotional video (with fallback)
- **Product Catalog**: Grid view of featured products with images
- **Categories**: Horizontal scrolling category list
- **Shopping Cart**: Local storage with quantity management
- **Search**: Product search functionality
- **Responsive**: Optimized for Android devices

### Backend (PHP + MySQL)
- **RESTful APIs**: Clean API endpoints for data management
- **Database**: MySQL with proper schema and relationships
- **CORS Support**: Cross-origin requests enabled
- **Sample Data**: Pre-populated categories and products

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| Frontend | Flutter |
| Backend | PHP (Core PHP) |
| Database | MySQL |
| Hosting | cPanel / Firebase |

## 📁 Project Structure

```
minzo/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── product.dart
│   │   ├── category.dart
│   │   └── cart_item.dart
│   ├── providers/
│   │   ├── cart_provider.dart
│   │   └── product_provider.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── cart_screen.dart
│   │   └── profile_screen.dart
│   ├── services/
│   │   └── api_service.dart
│   ├── widgets/
│   │   ├── video_banner.dart
│   │   ├── search_bar_widget.dart
│   │   ├── category_list.dart
│   │   ├── product_grid.dart
│   │   ├── product_card.dart
│   │   └── cart_item_widget.dart
│   └── utils/
│       └── app_colors.dart
├── assets/
│   ├── images/
│   └── videos/
├── backend/
│   ├── api/
│   │   ├── config.php
│   │   ├── categories.php
│   │   ├── products.php
│   │   └── featured_products.php
│   └── database/
│       └── schema.sql
└── pubspec.yaml
```

## 🎨 Design Features

### Branding
- **Colors**: Green (primary), Yellow (secondary)
- **Typography**: Clean, modern sans-serif (Poppins)
- **Logo**: MinzoIT branding integration

### UI Components
- **App Bar**: Logo + "MinzoIT | Birgunj" title
- **Video Banner**: Auto-playing promotional content
- **Search Bar**: "Search for groceries, fruits, snacks..."
- **Categories**: Horizontal scroll with images
- **Product Grid**: Masonry layout with add-to-cart buttons
- **Cart Badge**: Floating cart icon with item count
- **Bottom Navigation**: Home | Cart | Profile

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- PHP 7.4+
- MySQL 5.7+
- cPanel hosting or local server

### Flutter Setup
1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Add your assets:
   - Place logo.png in `assets/images/`
   - Place promo.mp4 in `assets/videos/`
4. Update API endpoint in `lib/services/api_service.dart`
5. Run the app:
   ```bash
   flutter run
   ```

### Backend Setup
1. Create MySQL database `minzo_db`
2. Import `backend/database/schema.sql`
3. Update database credentials in `backend/api/config.php`
4. Upload backend files to your server
5. Test API endpoints

## 📱 App Screens

### Home Screen
- Video banner with promotional content
- Search bar for product discovery
- Horizontal category list
- Featured products grid
- Floating cart with item count

### Cart Screen
- List of added products
- Quantity controls (+/-)
- Total amount calculation
- Checkout button (placeholder)

### Profile Screen
- User information
- Menu items (Orders, Address, Payment, etc.)
- Logout functionality

## 🔗 API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/categories.php` | GET | Get all categories |
| `/api/products.php` | GET | Get all products |
| `/api/products.php?category_id=1` | GET | Get products by category |
| `/api/featured_products.php` | GET | Get featured products |

## 🎯 Next Steps

### Phase 2 Features
- [ ] User authentication (Login/Register)
- [ ] Order management system
- [ ] Google Maps integration for delivery tracking
- [ ] Payment gateway (Khalti/eSewa)
- [ ] Push notifications
- [ ] Admin panel for product management
- [ ] Real-time stock management

### Technical Improvements
- [ ] State management optimization
- [ ] Offline support
- [ ] Image caching
- [ ] Performance optimization
- [ ] Error handling enhancement

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and queries, contact the MinzoIT team in Birgunj.

---

**MinzoIT** - Fresh Groceries Delivered to Your Doorstep 🛒