class UsersClass {
  final String user_id;
  final String username;
  final String firstname;
  final String lastname;
  final String middlename;
  final String phone;
  final String email;
  final String address;
  final String otp;
  final String qrcode;
  final String date_time_registered;

  UsersClass({
    required this.user_id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.middlename,
    required this.phone,
    required this.address,
    required this.email,
    required this.otp,
    required this.qrcode,
    required this.date_time_registered,
  });

  Map<String, dynamic> toMap() {
    return {
      user_id: user_id,
      username: username,
      firstname: firstname,
      middlename: middlename,
      lastname: lastname,
      phone: phone,
      email: email,
      address: address,
      otp: otp,
      qrcode: qrcode,
      date_time_registered: date_time_registered,
    };
  }

  factory UsersClass.fromJson(Map<String, dynamic> json) {
    return UsersClass(
      user_id: json['user_id'],
      username: json['username'],
      firstname: json['firstname'],
      middlename: json['middlename'],
      lastname: json['lastname'],
      phone: json['phone'],
      address: json['address'],
      email: json['email'],
      otp: json['otp'],
      qrcode: json['qrcode'],
      date_time_registered: json['date_time_registered'],
    );
  }
}
