import 'package:dio/dio.dart';
import 'package:nike_store/common/constant.dart';
import 'package:nike_store/common/response_validator.dart';
import 'package:nike_store/data/auth_info.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String password);
  Future<AuthInfo> register(String username, String password);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource with ResponseValidator implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource(this.httpClient);
  @override
  Future<AuthInfo> login(String username, String password) async {
    final response = await httpClient.post("auth/token", data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constant.clientSecret,
      "username": username,
      "password": password
    });
    validateResponse(response);
    return AuthInfo(response.data["access_token"],
        response.data["refresh_token"], username);
  }

  @override
  Future<AuthInfo> refreshToken(String token) async {
    final response = await httpClient.post("auth/token", data: {
      "grant_type": "refresh_token",
      "client_id": 2,
      "client_secret": Constant.clientSecret,
      "refresh_token": token
    });
    validateResponse(response);
    return AuthInfo(
        response.data["access_token"], response.data["refresh_token"], "");
  }

  @override
  Future<AuthInfo> register(String username, String password) async {
    final response = await httpClient
        .post("user/register", data: {"email": username, "password": password});
    validateResponse(response);
    return login(username, password);
  }
}
