import 'dart:convert';

import 'package:randify/apicommunication/api-endpoint.dart';

class UserRepository {
  static String _authorizationCode;

  static String _actualAccessToken;

  static String _actualRefreshToken;

  static String _displayName;

  static String _imageUrl;

  static void initializeData(String authCode) async {
    await exchangeToken(authCode);
    await loadUserData();
  }

  static Future<bool> exchangeToken(String authCode) async {
    _authorizationCode = authCode;

    var responseBody = await ApiEndpoint().exchange(authCode);

    var map = json.decode(responseBody);

    _actualAccessToken = map['access_token'];
    _actualRefreshToken = map['refresh_token'];

    return true;
  }

  static Future<bool> loadUserData() async {
    return true;
  }

  void destroy() {
    _authorizationCode = null;
    _actualRefreshToken = null;
    _actualAccessToken = null;
    _displayName = null;
    _imageUrl = null;
  }

  bool isLoaded() {
    return _authorizationCode != null &&
        _actualAccessToken != null &&
        _actualRefreshToken != null;
  }
}
