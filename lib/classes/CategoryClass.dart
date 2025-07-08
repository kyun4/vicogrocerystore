class CategoryClass {
  String category_id;
  String category_name;
  String date_time_added;
  String added_by;
  String added_by_role;
  String date_time_last_updated;
  String last_updated_by;
  String last_updated_by_role;
  String sub_category_of;
  String status;

  CategoryClass({
    required this.category_id,
    required this.category_name,
    required this.date_time_added,
    required this.added_by,
    required this.added_by_role,
    required this.date_time_last_updated,
    required this.last_updated_by,
    required this.last_updated_by_role,
    required this.sub_category_of,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      category_id: category_id,
      category_name: category_name,
      date_time_added: date_time_added,
      added_by: added_by,
      date_time_last_updated: date_time_last_updated,
      last_updated_by: last_updated_by,
      last_updated_by_role: last_updated_by_role,
      sub_category_of: sub_category_of,
      status: status,
    };
  }

  factory CategoryClass.fromJson(Map<String, dynamic> json) {
    return CategoryClass(
      category_id: json['category_id'],
      category_name: json['category_name'],
      date_time_added: json['date_time_added'],
      added_by: json['added_by'],
      added_by_role: json['added_by_role'],
      date_time_last_updated: json['date_time_last_updated'],
      last_updated_by: json['last_updated_by'],
      last_updated_by_role: json['last_updated_by_role'],
      sub_category_of: json['sub_category_of'],
      status: json['status'],
    );
  }
}
