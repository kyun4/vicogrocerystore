class TransactionClass {
  String user_transaction_id;
  String receipt_id;
  String user_id;
  String user_id_role;
  String transaction_type;
  String status;
  String vat_amount;
  String vat_percentage;
  String amount;
  String date_time;
  String date_time_approved;
  String approved_by;
  String approved_by_role;
  String grocery_fee;
  String payment_method;
  String payment_provider_name;
  String processing_fee;
  String purchase_type;
  String remarks;

  TransactionClass({
    required this.user_transaction_id,
    required this.receipt_id,
    required this.user_id,
    required this.user_id_role,
    required this.transaction_type,
    required this.status,
    required this.vat_amount,
    required this.vat_percentage,
    required this.amount,
    required this.date_time,
    required this.date_time_approved,
    required this.approved_by,
    required this.approved_by_role,
    required this.grocery_fee,
    required this.payment_method,
    required this.payment_provider_name,
    required this.processing_fee,
    required this.purchase_type,
    required this.remarks,
  });

  Map<String, dynamic> toMap() {
    return {
      user_transaction_id: user_transaction_id,
      user_id: user_id,
      receipt_id: receipt_id,
      user_id_role: user_id_role,
      transaction_type: transaction_type,
      status: status,
      vat_amount: vat_amount,
      vat_percentage: vat_percentage,
      amount: amount,
      date_time: date_time,
      date_time_approved: date_time_approved,
      approved_by: approved_by,
      approved_by_role: approved_by_role,
      grocery_fee: grocery_fee,
      payment_method: payment_method,
      payment_provider_name: payment_provider_name,
      processing_fee: processing_fee,
      purchase_type: purchase_type,
      remarks: remarks,
    };
  }

  factory TransactionClass.fromJson(Map<String, dynamic> json) {
    return TransactionClass(
      user_transaction_id: json['user_transaction_id'],
      user_id: json['user_id'],
      user_id_role: json['user_id_role'],
      receipt_id: json['receipt_id'],
      transaction_type: json['transaction_type'],
      status: json['status'],
      vat_amount: json['vat_amount'],
      vat_percentage: json['vat_percentage'],
      amount: json['amount'],
      date_time: json['date_time'],
      date_time_approved: json['date_time_approved'],
      approved_by: json['approved_by'],
      approved_by_role: json['approved_by_role'],
      grocery_fee: json['grocery_fee'],
      payment_method: json['payment_method'],
      payment_provider_name: json['payment_provider_name'],
      processing_fee: json['processing_fee'],
      purchase_type: json['purchase_type'],
      remarks: json['remarks'],
    );
  }
}
