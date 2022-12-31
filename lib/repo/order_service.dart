import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shalomhouse/constants/data_keys.dart';
import 'package:shalomhouse/data/order_model.dart';

class OrderService {
  static final OrderService _orderService = OrderService._internal();

  factory OrderService() => _orderService;

  OrderService._internal();

  Future createNewOrder(Map<String, dynamic> json, String orderKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_ORDERS).doc(orderKey);
    final DocumentSnapshot documentSnapshot = await documentReference.get();

    if (!documentSnapshot.exists) {
      await documentReference.set(json);
    }
  }

  Future<OrderModel> getOrder(String orderKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_ORDERS).doc(orderKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await documentReference.get();
    OrderModel orderModel = OrderModel.fromSnapshot(documentSnapshot);
    return orderModel;
  }

  Future<List<OrderModel>> getOrders() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection(COL_ORDERS);
    QuerySnapshot<Map<String, dynamic>> snapshot = await collectionReference
    .orderBy("createdDate", descending: true).get();

    List<OrderModel> orders = [];

    for (int i = 0; i < snapshot.size; i++) {
      OrderModel orderModel = OrderModel.fromQuerySnapshot(snapshot.docs[i]);
      orders.add(orderModel);
    }
    return orders;
  }
  Future<List<OrderModel>> getUserOrders(String userKey,
      {String? orderKey}) async {
    CollectionReference<Map<String, dynamic>> collectionReference =
    FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(COL_USER_ORDERS);
    QuerySnapshot<Map<String, dynamic>> snapshots =
    await collectionReference.get();

    List<OrderModel> orders = [];

    for (int i = 0; i < snapshots.size; i++) {
      OrderModel orderModel = OrderModel.fromQuerySnapshot(snapshots.docs[i]);
      if (!(orderKey != null && orderKey == orderModel.orderKey))
        orders.add(orderModel);
    }

    return orders;
  }
}

//    .orderBy("createdDate","desc")
