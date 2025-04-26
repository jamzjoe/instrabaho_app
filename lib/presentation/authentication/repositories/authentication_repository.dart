import 'package:dio/dio.dart';
import 'package:instrabaho_app/domain/models/auth/auth_response.dart';
import 'package:instrabaho_app/domain/models/auth/client_register_request.dart';
import 'package:instrabaho_app/domain/models/auth/login_request.dart';
import 'package:instrabaho_app/domain/models/auth/worker_register_request.dart';
import 'package:instrabaho_app/env.g.dart';
import 'package:splash_master/cmd/logging.dart';

class AuthenticationRepository {
  final Dio _dio;
  final String _baseUrl;

  AuthenticationRepository({required Dio dio})
      : _dio = dio,
        _baseUrl = Env.baseUrl;

  Future<AuthResponse> registerWorker(WorkerRegisterRequest request) async {
    final formData = FormData.fromMap({
      ...request.toJson(),
      'identification_file':
          await MultipartFile.fromFile(request.identificationFile),
      'nbi_copy_file': await MultipartFile.fromFile(request.nbiCopyFile),
    });

    final response = await _dio.post(
      '$_baseUrl/workers/register',
      data: formData,
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> registerClient(ClientRegisterRequest request) async {
    final formData = FormData.fromMap(request.toJson());

    final response = await _dio.post(
      '$_baseUrl/clients/register',
      data: formData,
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> logout() async {
    final response = await _dio.post(
      '$_baseUrl/logout',
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> loginClient(LoginRequest request) async {
    final url = '$_baseUrl/clients/login';
    log("Login url $url");
    final response = await _dio.post(
      url,
      data: request.toJson(),
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    log("Login client ${response.data}");

    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> loginWorker(LoginRequest request) async {
    final response = await _dio.post(
      '$_baseUrl/workers/login',
      data: request.toJson(),
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    return AuthResponse.fromJson(response.data);
  }
}
