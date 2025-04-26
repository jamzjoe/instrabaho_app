class WorkerDetails {
  final int id;
  final int userId;
  final double hourlyRate;
  final String countryCode;
  final String contactNumber;
  final String gender;
  final String? personalDescription;
  final int age;
  final String birthdate;
  final String address;
  final String latitude;
  final String longitude;
  final bool isVerifiedWorker;

  WorkerDetails({
    required this.id,
    required this.userId,
    required this.hourlyRate,
    required this.countryCode,
    required this.contactNumber,
    required this.gender,
    this.personalDescription,
    required this.age,
    required this.birthdate,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isVerifiedWorker,
  });

  factory WorkerDetails.fromJson(Map<String, dynamic> json) {
    return WorkerDetails(
      id: json['id'],
      userId: json['user_id'],
      hourlyRate: json['hourly_rate'].toDouble(),
      countryCode: json['country_code'].toString(),
      contactNumber: json['contact_number'],
      gender: json['gender'],
      personalDescription: json['personal_description'],
      age: json['age'],
      birthdate: json['birthdate'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isVerifiedWorker: json['is_verified_worker'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'hourly_rate': hourlyRate,
      'country_code': countryCode,
      'contact_number': contactNumber,
      'gender': gender,
      'personal_description': personalDescription,
      'age': age,
      'birthdate': birthdate,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'is_verified_worker': isVerifiedWorker,
    };
  }
}
