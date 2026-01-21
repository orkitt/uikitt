// ignore_for_file: public_member_api_docs, sort_constructors_first
enum Status { kitchen, delivered, cancelled }

class OrderListModel {
  final String mealName;
  final String orderID;
  final int items;
  final int tableNo;
  final Status status;
  final double price;
  final double discount;
  OrderListModel({
    required this.mealName,
    required this.orderID,
    required this.items,
    required this.tableNo,
    required this.status,
    required this.price,
    required this.discount,
  });
}
