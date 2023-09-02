import 'package:flutter/material.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/source/auth_dataSource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/http_baseUrl.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> register(String username, String password);
  Future<void> refreshToken();
  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    _saveAuthTokens(authInfo);
    debugPrint(authInfo.accessToken);
  }

  @override
  Future<void> refreshToken() async {
    try {
      final AuthInfo authInfo =
          await dataSource.refreshToken(authChangeNotifier.value!.refreshToken);
      debugPrint("refresh token is ${authInfo.refreshToken}");
      debugPrint("access token is ${authInfo.accessToken}");
      _saveAuthTokens(authInfo);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> register(String username, String password) async {
    final AuthInfo authInfo = await dataSource.register(username, password);
    debugPrint(authInfo.accessToken);
    _saveAuthTokens(authInfo);
  }

  Future<void> _saveAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
    sharedPreferences.setString("email", authInfo.email);
    loadTokens();
  }

  Future<void> loadTokens() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString("access_token") ?? "";
    final String refreshToken =
        sharedPreferences.getString("refresh_token") ?? "";

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthInfo(accessToken, refreshToken,
          sharedPreferences.getString("email") ?? "");
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
