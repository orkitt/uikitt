import '../models/order_list_model.dart';

final List<OrderListModel> dummyOrders = [
  OrderListModel(
    mealName: 'Margherita Pizza',
    orderID: 'ORD001',
    items: 2,
    tableNo: 5,
    status: Status.kitchen,
    price: 12.34,
    discount: 2.34,
  ),
  OrderListModel(
    mealName: 'Caesar Salad',
    orderID: 'ORD002',
    items: 1,
    tableNo: 3,
    status: Status.delivered, price: 13.4, discount: 1.4,
  ),
  OrderListModel(
    mealName: 'Spaghetti Carbonara',
    orderID: 'ORD003',
    items: 3,
    tableNo: 7,
    status: Status.kitchen, price: 123.67, discount: 0.67,
  ),
  OrderListModel(
    mealName: 'Grilled Chicken',
    orderID: 'ORD004',
    items: 2,
    tableNo: 2,
    status: Status.cancelled, price: 3, discount: 0,
  ),
  OrderListModel(
    mealName: 'Cheeseburger',
    orderID: 'ORD005',
    items: 4,
    tableNo: 1,
    status: Status.delivered, price: 356, discount: 6,
  ),
  OrderListModel(
    mealName: 'Veggie Wrap',
    orderID: 'ORD006',
    items: 1,
    tableNo: 4,
    status: Status.kitchen, price: 345.5, discount: 0.5,
  ),
  OrderListModel(
    mealName: 'Tacos',
    orderID: 'ORD007',
    items: 3,
    tableNo: 6,
    status: Status.delivered, price: 44, discount: 0.4,
  ),
  OrderListModel(
    mealName: 'French Fries',
    orderID: 'ORD008',
    items: 2,
    tableNo: 8,
    status: Status.kitchen, price: 12, discount: 0,
  ),
];
