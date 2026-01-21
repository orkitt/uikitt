// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:orkitt/orkitt.dart';

import 'package:posme/core/constants/spacing.dart';
import 'package:posme/data/models/product_model.dart';
import 'package:posme/data/repository/dummy_order_repo.dart';
import 'package:posme/data/repository/dummy_product_repo.dart';

import '../../../data/models/order_list_model.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kSpace.px,
          child: ListView(
            children: [
              Padding(
                padding: kSpace.py,
                child: Row(
                  children: [
                    Text('Hello,\nGweny Adms', style: context.titleSmall.bold),
                    Spacer(),
                    UiAvatarCircle(
                      image: AssetImage('assets/images/avater.png'),
                      radius: kSize,
                    ),
                  ],
                ),
              ),
              kSize.s,
              UiTextField(
                hintText: 'Search Food',
                fillColor: context.surfaceElevated,
                borderWidth: 1,
                prefixIcon: Icon(Icons.search),
                borderRadius: 48.r,
                suffixIcon: UiButton.circle(
                  onPressed: () {},
                  icon: Icon(Icons.filter),
                ).withMargin(6.mr),
                borderColor: context.surfaceElevated,
                borderConfig: UiTextFieldBorder(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: context.divider),
                    borderRadius: BorderRadius.all(Radius.circular(48.r)),
                  ),
                ),
              ),
              kSize.s,
              Text('Order List', style: context.titleSmall.bold),

              UiListView.horizontal(
                itemCount: dummyOrders.length,
                itemBuilder: (context, i) => OrderCard(order: dummyOrders[i]),
              ),
              kSize.s,
              DealCard(),
              kSize.s,
              Row(spacing: 5, children: [CardSelles(), CardSelles()]),
              kSize.s,
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dummyOrders.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    product: DummyProducts.dummyProducts[index],
                  );
                  //return TransactionList(order: dummyOrders[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( vertical: 6),
      decoration: BoxDecoration(
        color: context.surfaceElevated,
        borderRadius: BorderRadius.circular(16),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.05),
        //     blurRadius: 8,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Product detail navigation
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Product icon with background
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: context.brandPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.food_bank_sharp,
                      color: context.brandPrimary,
                      size: 28,
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: context.titleMedium.bold.withColor(context.textPrimary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (product.isFeatured)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.amber,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'FEATURED',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[800],
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.description,
                        style: context.bodySmall.withColor(Colors.grey[600]!),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.price.toDollar(),
                        style: context.titleSmall.bold.withColor(context.brandPrimary),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Stock and add button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStockColor(product.stockCount).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${product.stockCount} left',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getStockColor(product.stockCount),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: context.brandPrimary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: context.brandPrimary.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: product.stockCount > 0
                            ? () {
                                // Add to cart logic
                              }
                            : null,
                        icon: const Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        padding: const EdgeInsets.all(10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStockColor(int stockCount) {
    if (stockCount == 0) return Colors.red;
    if (stockCount <= 5) return Colors.orange;
    return Colors.green;
  }
}
// class ProductCard extends StatelessWidget {
//   final ProductModel product;
//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12), // Fixed: 12.mb → EdgeInsets
//       decoration: BoxDecoration(
//         color: context.surfaceElevated,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           // Leading icon with background
//           Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: context.brandPrimary.withOpacity(0.18),
//               shape: BoxShape.circle,
//             ),
//             child: IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.food_bank_sharp, 
//                 color: context.brandPrimary,
//               ),
//               padding: const EdgeInsets.all(8),
//             ),
//           ),
          
//           // Product info
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     product.name,
//                     style: context.bodyLarge.bold.withColor(context.textPrimary),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     product.description,
//                     style: context.bodySmall.bold,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     product.price.toDollar(),
//                     style: context.bodyLarge.bold.withColor(context.brandPrimary),
//                   ),
//                 ],
//               ),
//             ),
//           ),
          
//           // Trailing stock info and add button
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'In stock: ${product.stockCount}',
//                   style: context.bodyMedium.bold.withColor(
//                     product.stockCount > 0 ? Colors.green : Colors.red,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: context.brandPrimary, // Background color for icon
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: IconButton(
//                     onPressed: () {
//                       // Add to cart logic
//                     },
//                     icon: const Icon(
//                       Icons.add_shopping_cart_rounded,
//                       color: Colors.white,
//                     ),
//                     padding: const EdgeInsets.all(8),
//                     constraints: const BoxConstraints(
//                       minWidth: 40,
//                       minHeight: 40,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class TransactionList extends StatelessWidget {
  final OrderListModel order;
  const TransactionList({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 12.mb,
      decoration: BoxDecoration(
        color: context.surfaceElevated,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: 8.p,
        style: ListTileStyle.list,
        leading: UiButton.circle(
          color: context.brandPrimary.withValues(alpha: .18),
          onPressed: () {},
          icon: Icon(Icons.food_bank_sharp, color: context.brandPrimary),
        ),
        title: Text(
          'Order #${order.orderID}',
          style: context.bodyLarge.bold.withColor(context.textPrimary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: [
            Text('${order.items} items', style: context.bodySmall.bold),
            const SizedBox(width: 12),
            Text('Table ${order.tableNo}', style: context.bodySmall.bold),
          ],
        ),
        trailing: Text(
          order.price.toDollar(),
          style: context.bodyMedium.bold.withColor(context.brandPrimary),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderListModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.surfaceElevated,

      margin: 8.mr,
      child: Padding(
        padding: 12.p,
        child: Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .start,
          children: [
            Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              spacing: 8,
              children: [
                Text(
                  order.mealName,
                  style: context.bodyMedium.bold.withColor(
                    context.brandPrimary,
                  ),
                ),
                Text(
                  'Order #${order.orderID}',
                  style: context.titleLarge.bold.withColor(context.textPrimary),
                ),
                Row(
                  spacing: 12,
                  children: [
                    Text('${order.items} items', style: context.bodySmall.bold),
                    Text(
                      'Table ${order.tableNo}',
                      style: context.bodySmall.bold,
                    ),
                  ],
                ),
              ],
            ),
            switch (order.status) {
              Status.kitchen => StatusView(
                color: Kolors.orange,
                text: 'Kitchen',
              ),
              // TODO: Handle this case.
              Status.delivered => StatusView(
                color: Kolors.green,
                text: 'Delivered',
              ),
              // TODO: Handle this case.
              Status.cancelled => StatusView(
                color: Kolors.red,
                text: 'Cancelled',
              ),
            },
          ],
        ),
      ),
    ).withBorderRadius(BorderRadius.all(Radius.circular(12)));
  }
}

class StatusView extends StatelessWidget {
  final Color color;
  final String text;
  const StatusView({Key? key, required this.color, required this.text})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 4.py + 8.px,
      margin: 12.ml,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .18),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: .min,
        spacing: 4,
        children: [
          Icon(Icons.circle_outlined, color: color, size: 16),
          Text(text, style: context.bodySmall.bold.withColor(color)),
        ],
      ),
    );
  }
}

class DealCard extends StatelessWidget {
  const DealCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.p,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage('assets/images/banner_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .start,
        spacing: 12,
        children: [
          Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              Icon(Icons.calendar_month, color: context.textTertiary, size: 16),
              Text(
                '4th December',
                style: context.bodySmall.withColor(context.textTertiary),
              ),
            ],
          ),

          Text(
            'Sales Revinue Grows by 5.1%\nin One Week',
            style: context.displaySmall.withColor(Colors.white),
          ),
          AppPrimaryButton(
            label: 'See Deatils',
            onPressed: () {},
            useGradient: false,
            useShadow: false,
            backgroundColor: context.surfaceElevated.withValues(alpha: .03),
            borderRadius: 25,
            labelStyle: context.labelMedium.withColor(Colors.white),
            icon: Icons.arrow_forward,
          ),
        ],
      ),
    );
  }
}

class CardSelles extends StatelessWidget {
  const CardSelles({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.p,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.surfaceElevated,
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .start,
        spacing: 16,
        children: [
          Row(
            mainAxisSize: .min,
            spacing: 8,
            children: [
              UiButton.circle(
                onPressed: () {},
                icon: Icon(
                  Icons.calendar_month,
                  color: context.brandPrimary,
                  size: 18,
                ),
                color: context.surface,
              ),

              Text(
                'Total Sell \nRevinue',
                style: context.bodyLarge.withColor(context.textSecondary),
              ),
            ],
          ),

          Text('\$98,980', style: context.displaySmall),
          Row(spacing: 8, children: [Text('2.5%'), Text('VS last month')]),
        ],
      ),
    );
  }
}
