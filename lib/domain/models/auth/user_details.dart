import 'package:instrabaho_app/domain/models/auth/client_details.dart';
import 'package:instrabaho_app/domain/models/auth/worker_details.dart';

class UserDetails {
  final int id;
  final String username;
  final String? email;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? profilePhoto;
  final String? emailVerifiedAt;
  final String status;
  final WorkerDetails? worker;
  final ClientDetails? client;

  UserDetails({
    required this.id,
    required this.username,
    this.email,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.profilePhoto,
    this.emailVerifiedAt,
    required this.status,
    this.worker,
    this.client,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      profilePhoto: json['profile_photo'],
      emailVerifiedAt: json['email_verified_at'],
      status: json['status'],
      worker: json['worker'] != null
          ? WorkerDetails.fromJson(json['worker'])
          : null,
      client: json['client'] != null
          ? ClientDetails.fromJson(json['client'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'profile_photo': profilePhoto,
      'email_verified_at': emailVerifiedAt,
      'status': status,
      'worker': worker?.toJson(),
      'client': client?.toJson(),
    };
  }
}
