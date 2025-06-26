class WalletClass {
  String user_id;
  String current_balance;
  String date_time_last_updated;

  WalletClass({
    required this.user_id,
    required this.current_balance,
    required this.date_time_last_updated,
  });

  Map<String, dynamic> toMap() {
    return {
      user_id: user_id,
      current_balance: current_balance,
      date_time_last_updated: date_time_last_updated,
    };
  }

  factory WalletClass.fromJson(Map<String, dynamic> json) {
    return WalletClass(
      current_balance: json['current_balance'],
      user_id: json['user_id'],
      date_time_last_updated: json['date_time_last_updated'],
    );
  }
}
