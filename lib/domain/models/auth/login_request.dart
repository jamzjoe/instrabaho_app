class LoginRequest {
  final String countryCode;
  final String contactNumber;
  final String password;

  LoginRequest({
    required this.countryCode,
    required this.contactNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'contact_number': contactNumber,
      'country_code': countryCode,
      'password': password,
    };
  }
}
