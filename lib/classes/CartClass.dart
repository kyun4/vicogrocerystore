class CartClass {
  String cart_id;
  String firebase_uid;
  String product_id;
  String category_id;
  String price;
  String qty;
  String discount_percentage;
  String discount_amount;
  String promo_id;
  String sold_by_item;
  String date_time_added;
  String processed_by_cashier;
  String date_time_cashier_processed;
  String status;

  CartClass({
    required this.cart_id,
    required this.firebase_uid,
    required this.product_id,
    required this.category_id,
    required this.price,
    required this.qty,
    required this.discount_percentage,
    required this.discount_amount,
    required this.promo_id,
    required this.sold_by_item,
    required this.date_time_added,
    required this.processed_by_cashier,
    required this.date_time_cashier_processed,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      cart_id: cart_id,
      firebase_uid: firebase_uid,
      product_id: product_id,
      category_id: category_id,
      price: price,
      qty: qty,
      discount_percentage: discount_percentage,
      discount_amount: discount_amount,
      promo_id: promo_id,
      sold_by_item: sold_by_item,
      date_time_added: date_time_added,
      processed_by_cashier: processed_by_cashier,
      date_time_cashier_processed: date_time_cashier_processed,
      status: status,
    };
  }

  factory CartClass.fromJson(Map<String, dynamic> json) {
    return CartClass(
      cart_id: json['cart_id'],
      firebase_uid: json['firebase_uid'],
      product_id: json['product_id'],
      category_id: json['category_id'],
      price: json['price'],
      qty: json['qty'],
      discount_percentage: json['discount_percentage'],
      discount_amount: json['discount_amount'],
      promo_id: json['promo_id'],
      sold_by_item: json['sold_by_item'],
      date_time_added: json['date_time_added'],
      processed_by_cashier: json['processed_by_cashier'],
      date_time_cashier_processed: json['date_time_cashier_processed'],
      status: json['status'],
    );
  }
}
