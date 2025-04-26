class WorkerRegisterRequest {
  final String firstName;
  final String lastName;
  final String? middleName;
  final String email;
  final String password;
  final String countryCode;
  final String contactNumber;
  final String gender;
  final String address;
  final double latitude;
  final double longitude;
  final String identificationFile;
  final String nbiCopyFile;
  final int serviceId;

  WorkerRegisterRequest({
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.email,
    required this.password,
    required this.countryCode,
    required this.contactNumber,
    required this.gender,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.identificationFile,
    required this.nbiCopyFile,
    required this.serviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'email': email,
      'password': password,
      'country_code': countryCode,
      'contact_number': contactNumber,
      'gender': gender,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'service_id': serviceId,
    };
  }
}
