import 'package:flutter/material.dart';
import 'package:posme/data/models/product_model.dart';

class PremiumProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final bool showAddButton;

  const PremiumProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.showAddButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: isDark ? Colors.grey[900] : Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              _buildImageSection(context),
              
              // Content section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and price row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Category tag
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(product.category)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  _getCategoryLabel(product.category),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getCategoryColor(product.category),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              
                              // Product name
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              
                              // Description
                              Text(
                                product.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        
                        // Price section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (product.discountPercentage != null)
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            Text(
                              '\$${product.finalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            if (product.discountPercentage != null)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE53935),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${product.discountPercentage!.toInt()}% OFF',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Bottom row with tags and action button
                    Row(
                      children: [
                        // Tags
                        Expanded(
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              // Vegetarian/Non-veg indicator
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: product.isVeg
                                      ? const Color(0xFF4CAF50).withOpacity(0.1)
                                      : const Color(0xFFF44336).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: product.isVeg
                                        ? const Color(0xFF4CAF50)
                                        : const Color(0xFFF44336),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: product.isVeg
                                            ? const Color(0xFF4CAF50)
                                            : const Color(0xFFF44336),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      product.isVeg ? 'VEG' : 'NON-VEG',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: product.isVeg
                                            ? const Color(0xFF4CAF50)
                                            : const Color(0xFFF44336),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Spicy indicator
                              if (product.isSpicy)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF9800).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.local_fire_department,
                                        size: 12,
                                        color: Color(0xFFFF9800),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'SPICY',
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.orange[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              
                              // Preparation time
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 12,
                                      color: Colors.blueGrey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${product.preparationTime} min',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blueGrey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Stock status and add button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Stock status
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getStockStatusColor(product.stockStatus)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                product.stockStatus.split(' ')[0],
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: _getStockStatusColor(product.stockStatus),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            
                            // Add to cart button
                            if (showAddButton && product.isAvailable)
                              InkWell(
                                onTap: onAddToCart,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF2E7D32),
                                        Color(0xFF4CAF50),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.add_shopping_cart_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        // Product image
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            height: 180,
            width: double.infinity,
            color: Colors.grey[200],
            child: product.imageUrl.isNotEmpty
                ? Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholderImage();
                    },
                  )
                : _buildPlaceholderImage(),
          ),
        ),
        
        // Featured badge
        if (product.isFeatured)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFD700),
                    Color(0xFFFFC107),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    size: 12,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'FEATURED',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        
        // Allergen warning
        if (product.allergens.isNotEmpty)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${product.allergens.length} allergens',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[300]!,
            Colors.grey[200]!,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.fastfood_rounded,
          size: 60,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  Color _getCategoryColor(ProductCategory category) {
    switch (category) {
      case ProductCategory.appetizers:
        return const Color(0xFF2196F3);
      case ProductCategory.mainCourse:
        return const Color(0xFFF44336);
      case ProductCategory.desserts:
        return const Color(0xFF9C27B0);
      case ProductCategory.beverages:
        return const Color(0xFF00BCD4);
      case ProductCategory.alcoholicDrinks:
        return const Color(0xFFFF9800);
      case ProductCategory.sides:
        return const Color(0xFF795548);
      case ProductCategory.combos:
        return const Color(0xFF4CAF50);
      case ProductCategory.specials:
        return const Color(0xFFFFC107);
    }
  }

  String _getCategoryLabel(ProductCategory category) {
    switch (category) {
      case ProductCategory.appetizers:
        return 'APPETIZER';
      case ProductCategory.mainCourse:
        return 'MAIN COURSE';
      case ProductCategory.desserts:
        return 'DESSERT';
      case ProductCategory.beverages:
        return 'BEVERAGE';
      case ProductCategory.alcoholicDrinks:
        return 'COCKTAIL';
      case ProductCategory.sides:
        return 'SIDE';
      case ProductCategory.combos:
        return 'COMBO';
      case ProductCategory.specials:
        return 'SPECIAL';
    }
  }

  Color _getStockStatusColor(String status) {
    if (status.contains('Out of Stock')) return const Color(0xFFF44336);
    if (status.contains('Low Stock')) return const Color(0xFFFF9800);
    if (status.contains('Discontinued')) return Colors.grey;
    return const Color(0xFF4CAF50);
  }
}

// Usage example in a list
class ProductListView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return PremiumProductCard(
          product: product,
          onTap: () {
            // Navigate to product detail
          },
          onAddToCart: () {
            // Add to cart logic
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added ${product.name} to cart'),
                backgroundColor: Colors.green,
              ),
            );
          },
        );
      },
    );
  }
}

// Grid view variant for menu display
class ProductGridView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return PremiumProductCard(
          product: product,
          onAddToCart: () {
            // Add to cart logic
          },
        );
      },
    );
  }
}