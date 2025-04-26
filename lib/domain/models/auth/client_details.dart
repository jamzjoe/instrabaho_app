class ClientDetails {
  final int id;
  final String contactNumber;
  final String countryCode;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? facebookUrl;

  ClientDetails({
    required this.id,
    required this.contactNumber,
    required this.countryCode,
    this.address,
    this.latitude,
    this.longitude,
    this.facebookUrl,
  });

  factory ClientDetails.fromJson(Map<String, dynamic> json) {
    return ClientDetails(
      id: json['id'],
      contactNumber: json['contact_number'],
      countryCode: json['country_code'].toString(),
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      facebookUrl: json['facebook_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contact_number': contactNumber,
      'country_code': countryCode,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'facebook_url': facebookUrl,
    };
  }
}
