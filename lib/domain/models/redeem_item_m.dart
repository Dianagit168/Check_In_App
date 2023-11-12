class RedeemItemModel {
  final String orderId;
  final String lineItem;
  int qty;


  RedeemItemModel({
    required this.orderId,
    required this.lineItem,
    required this.qty,
  });

}
