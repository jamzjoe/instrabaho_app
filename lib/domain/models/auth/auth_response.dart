import 'package:instrabaho_app/domain/models/auth/user_details.dart';

class AuthResponse {
  final String? token;
  final String? message;
  final bool status;
  final UserDetails? user;

  AuthResponse({
    this.token,
    this.message,
    required this.status,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      message: json['message'],
      status: json['status'] ?? false,
      user: json['user'] != null ? UserDetails.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'message': message,
      'status': status,
      'user': user?.toJson(),
    };
  }
}
