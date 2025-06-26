class ProductsClass {
  final String product_id;
  final String product_name;
  final String barcode;
  final String price;
  final String category_id;
  final String sku;
  final String current_stock;
  final String sold_by_quantity;
  final String added_by;
  final String date_time_added;
  final String last_updated_by;
  final String last_date_time_updated;
  final String url_image;
  final String user_quantity_limit;

  ProductsClass({
    required this.product_id,
    required this.product_name,
    required this.barcode,
    required this.price,
    required this.category_id,
    required this.sku,
    required this.current_stock,
    required this.sold_by_quantity,
    required this.added_by,
    required this.date_time_added,
    required this.last_updated_by,
    required this.last_date_time_updated,
    required this.url_image,
    required this.user_quantity_limit,
  });

  Map<String, dynamic> toMap() {
    return {
      product_id: product_id,
      product_name: product_name,
      barcode: barcode,
      price: price,
      category_id: category_id,
      sku: sku,
      current_stock: current_stock,
      added_by: added_by,
      date_time_added: date_time_added,
      last_updated_by: last_updated_by,
      last_date_time_updated: last_date_time_updated,
      url_image: url_image,
      user_quantity_limit: user_quantity_limit,
    };
  }

  factory ProductsClass.fromJson(Map<String, dynamic> json) {
    return ProductsClass(
      product_id: json['product_id'],
      product_name: json['product_name'],
      price: json['price'],
      category_id: json['category_id'],
      barcode: json['barcode'],
      sold_by_quantity: json['sold_by_quantity'],
      sku: json['sku'],
      added_by: json['added_by'],
      date_time_added: json['date_time_added'],
      last_updated_by: json['last_updated_by'],
      last_date_time_updated: json['date_time_last_updated'],
      url_image: json['url_image'],
      current_stock: json['current_stock'],
      user_quantity_limit: json['user_quantity_limit'],
    );
  }
}
