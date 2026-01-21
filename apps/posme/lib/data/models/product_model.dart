// lib/models/product_model.dart

import 'package:flutter/foundation.dart';

enum ProductCategory {
  appetizers,
  mainCourse,
  desserts,
  beverages,
  alcoholicDrinks,
  sides,
  combos,
  specials,
}

enum ProductStatus {
  available,
  outOfStock,
  discontinued,
  seasonal,
  lowStock,
}

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final ProductCategory category;
  final List<String> tags;
  final int stockCount;
  final ProductStatus status;
  final bool isVeg;
  final bool isSpicy;
  final List<String> allergens;
  final int preparationTime; // in minutes
  final double costPrice; // for profit calculation
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isFeatured;
  final double? discountPercentage;
  final double? discountedPrice;
  
  // Calculated property
  double get finalPrice => discountedPrice ?? price;
  
  // Stock status helper
  bool get isAvailable => stockCount > 0 && status != ProductStatus.discontinued;
  bool get isLowStock => stockCount <= 5 && stockCount > 0;
  String get stockStatus {
    if (status == ProductStatus.discontinued) return 'Discontinued';
    if (stockCount == 0) return 'Out of Stock';
    if (stockCount <= 5) return 'Low Stock ($stockCount left)';
    return 'In Stock ($stockCount)';
  }

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl = '',
    required this.category,
    this.tags = const [],
    required this.stockCount,
    this.status = ProductStatus.available,
    this.isVeg = true,
    this.isSpicy = false,
    this.allergens = const [],
    this.preparationTime = 15,
    required this.costPrice,
    DateTime? createdAt,
    this.updatedAt,
    this.isFeatured = false,
    this.discountPercentage,
    this.discountedPrice,
  }) : createdAt = createdAt ?? DateTime.now();

  // Copy with method for immutability
  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    ProductCategory? category,
    List<String>? tags,
    int? stockCount,
    ProductStatus? status,
    bool? isVeg,
    bool? isSpicy,
    List<String>? allergens,
    int? preparationTime,
    double? costPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFeatured,
    double? discountPercentage,
    double? discountedPrice,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      stockCount: stockCount ?? this.stockCount,
      status: status ?? this.status,
      isVeg: isVeg ?? this.isVeg,
      isSpicy: isSpicy ?? this.isSpicy,
      allergens: allergens ?? this.allergens,
      preparationTime: preparationTime ?? this.preparationTime,
      costPrice: costPrice ?? this.costPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFeatured: isFeatured ?? this.isFeatured,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountedPrice: discountedPrice ?? this.discountedPrice,
    );
  }

  // To JSON for Firebase/API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category.index,
      'tags': tags,
      'stockCount': stockCount,
      'status': status.index,
      'isVeg': isVeg,
      'isSpicy': isSpicy,
      'allergens': allergens,
      'preparationTime': preparationTime,
      'costPrice': costPrice,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isFeatured': isFeatured,
      'discountPercentage': discountPercentage,
      'discountedPrice': discountedPrice,
    };
  }

  // From JSON for Firebase/API
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      category: ProductCategory.values[json['category'] ?? 0],
      tags: List<String>.from(json['tags'] ?? []),
      stockCount: json['stockCount'] ?? 0,
      status: ProductStatus.values[json['status'] ?? 0],
      isVeg: json['isVeg'] ?? true,
      isSpicy: json['isSpicy'] ?? false,
      allergens: List<String>.from(json['allergens'] ?? []),
      preparationTime: json['preparationTime'] ?? 15,
      costPrice: (json['costPrice'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isFeatured: json['isFeatured'] ?? false,
      discountPercentage: json['discountPercentage']?.toDouble(),
      discountedPrice: json['discountedPrice']?.toDouble(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price: $price, stock: $stockCount)';
  }
}

// Helper class for product variations (sizes, add-ons, etc.)
class ProductVariant {
  final String id;
  final String name; // e.g., "Small", "Large", "Extra Cheese"
  final double priceAdjustment;
  final int stockCount;

  ProductVariant({
    required this.id,
    required this.name,
    required this.priceAdjustment,
    required this.stockCount,
  });
}

// Inventory tracking model
class InventoryHistory {
  final String id;
  final String productId;
  final int quantityChange;
  final String reason; // 'sale', 'restock', 'waste', 'adjustment'
  final DateTime timestamp;
  final String? notes;
  final String? userId;

  InventoryHistory({
    required this.id,
    required this.productId,
    required this.quantityChange,
    required this.reason,
    required this.timestamp,
    this.notes,
    this.userId,
  });
}