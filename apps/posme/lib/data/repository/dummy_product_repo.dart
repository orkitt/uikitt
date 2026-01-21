// lib/data/dummy_products.dart

import '../models/product_model.dart';

class DummyProducts {
  static List<ProductModel> get dummyProducts => [
    ProductModel(
      id: '1',
      name: 'Margherita Pizza',
      description: 'Classic tomato sauce, fresh mozzarella, and basil',
      price: 12.99,
      imageUrl: 'https://example.com/pizza.jpg',
      category: ProductCategory.mainCourse,
      tags: ['pizza', 'italian', 'cheese'],
      stockCount: 25,
      status: ProductStatus.available,
      isVeg: true,
      isSpicy: false,
      allergens: ['gluten', 'dairy'],
      preparationTime: 20,
      costPrice: 4.50,
      isFeatured: true,
    ),
    
    ProductModel(
      id: '2',
      name: 'Grilled Salmon',
      description: 'Atlantic salmon with lemon butter sauce',
      price: 24.99,
      imageUrl: 'https://example.com/salmon.jpg',
      category: ProductCategory.mainCourse,
      tags: ['seafood', 'healthy', 'grilled'],
      stockCount: 3,
      status: ProductStatus.lowStock,
      isVeg: false,
      isSpicy: false,
      allergens: ['fish'],
      preparationTime: 25,
      costPrice: 12.00,
      isFeatured: true,
      discountPercentage: 10,
    ),
    
    ProductModel(
      id: '3',
      name: 'Caesar Salad',
      description: 'Fresh romaine, croutons, parmesan, caesar dressing',
      price: 8.99,
      imageUrl: 'https://example.com/salad.jpg',
      category: ProductCategory.appetizers,
      tags: ['salad', 'healthy', 'starter'],
      stockCount: 15,
      status: ProductStatus.available,
      isVeg: false, // contains anchovies in dressing
      isSpicy: false,
      allergens: ['gluten', 'dairy', 'fish'],
      preparationTime: 10,
      costPrice: 2.50,
    ),
    
    ProductModel(
      id: '4',
      name: 'Chocolate Lava Cake',
      description: 'Warm chocolate cake with molten center, vanilla ice cream',
      price: 7.99,
      imageUrl: 'https://example.com/cake.jpg',
      category: ProductCategory.desserts,
      tags: ['dessert', 'chocolate', 'sweet'],
      stockCount: 0,
      status: ProductStatus.outOfStock,
      isVeg: true,
      isSpicy: false,
      allergens: ['gluten', 'dairy', 'eggs'],
      preparationTime: 15,
      costPrice: 1.80,
    ),
    
    ProductModel(
      id: '5',
      name: 'Craft Beer Flight',
      description: 'Sample 4 local craft beers (4oz each)',
      price: 14.99,
      imageUrl: 'https://example.com/beer.jpg',
      category: ProductCategory.alcoholicDrinks,
      tags: ['beer', 'alcohol', 'craft'],
      stockCount: 40,
      status: ProductStatus.available,
      isVeg: true,
      isSpicy: false,
      allergens: ['gluten'],
      preparationTime: 5,
      costPrice: 6.00,
    ),
    
    ProductModel(
      id: '6',
      name: 'Seasonal Fruit Lemonade',
      description: 'Freshly squeezed lemonade with seasonal fruits',
      price: 4.99,
      imageUrl: 'https://example.com/lemonade.jpg',
      category: ProductCategory.beverages,
      tags: ['drink', 'refreshing', 'summer'],
      stockCount: 50,
      status: ProductStatus.seasonal,
      isVeg: true,
      isSpicy: false,
      allergens: [],
      preparationTime: 5,
      costPrice: 0.80,
      discountPercentage: 15,
    ),
    
    ProductModel(
      id: '7',
      name: 'French Fries',
      description: 'Crispy golden fries with sea salt',
      price: 4.49,
      imageUrl: 'https://example.com/fries.jpg',
      category: ProductCategory.sides,
      tags: ['side', 'snack', 'fried'],
      stockCount: 30,
      status: ProductStatus.available,
      isVeg: true,
      isSpicy: false,
      allergens: [],
      preparationTime: 8,
      costPrice: 0.60,
    ),
    
    ProductModel(
      id: '8',
      name: 'Burger Combo',
      description: 'Beef burger + fries + soda',
      price: 15.99,
      imageUrl: 'https://example.com/burger.jpg',
      category: ProductCategory.combos,
      tags: ['combo', 'burger', 'meal'],
      stockCount: 20,
      status: ProductStatus.available,
      isVeg: false,
      isSpicy: true,
      allergens: ['gluten', 'dairy'],
      preparationTime: 18,
      costPrice: 5.50,
      isFeatured: true,
    ),
  ];

  // Get products by category
  static List<ProductModel> getProductsByCategory(ProductCategory category) {
    return dummyProducts.where((product) => product.category == category).toList();
  }

  // Get featured products
  static List<ProductModel> getFeaturedProducts() {
    return dummyProducts.where((product) => product.isFeatured).toList();
  }

  // Get low stock products
  static List<ProductModel> getLowStockProducts() {
    return dummyProducts.where((product) => product.isLowStock).toList();
  }

  // Get out of stock products
  static List<ProductModel> getOutOfStockProducts() {
    return dummyProducts.where((product) => product.stockCount == 0).toList();
  }
}