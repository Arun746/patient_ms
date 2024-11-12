class SignUpModel {
  String firstName;
  String lastName;
  String mobileNumber;
  String emailAddress;
  String address;
  String password;
  String confirmPassword;
  List<String> userRoles;
  String username;

  SignUpModel({
    required this.confirmPassword,
    required this.emailAddress,
    required this.address,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.password,
    required this.userRoles,
    required this.username,
  });

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      confirmPassword: map['confirmPassword'],
      emailAddress: map['emailAddress'],
      address: map['address'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      mobileNumber: map['mobileNumber'],
      password: map['password'],
      userRoles: List<String>.from(map['userRoles']),
      username: map['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'confirmPassword': confirmPassword,
      'emailAddress': emailAddress,
      'address': address,
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNumber.toString(),
      'password': password,
      'userRoles': userRoles,
      'username': username,
    };
  }
}
