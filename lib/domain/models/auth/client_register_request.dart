class ClientRegisterRequest {
  final String firstName;
  final String lastName;
  final String contactNumber;
  final String countryCode;
  final String password;

  ClientRegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.countryCode,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'contact_number': contactNumber,
      'country_code': countryCode,
      'password': password,
    };
  }
}
