class UserModel {
  String? name;
  String? email;

  UserModel({this.name, this.email});

  UserModel.fromMap(Map<String, dynamic> data) {
    name = data['fullName'] ?? '';
    email = data['email'] ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': name,
      'email': email,
    };
  }
}
