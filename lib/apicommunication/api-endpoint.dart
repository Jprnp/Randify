import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'models/environment.dart';

class ApiEndpoint {
  static ApiEndpoint _instance;

  Environment _env;

  factory ApiEndpoint() {
    _instance ??= ApiEndpoint._ApiEndpoint();
    return _instance;
  }

  ApiEndpoint._ApiEndpoint() {
    print("BUSCANDO CONFIGS");
    getEnvironmentConfig();
  }

  void getEnvironmentConfig() async {
    var response = await http
        .get('https://us-central1-randify.cloudfunctions.net/getEnvConfig');

    print(response.body);

    _env = Environment.fromJson(json.decode(response.body));
  }

  bool hasEnv() {
    return _env != null;
  }

  Future<bool> authenticate() async {
    String scopes =
        "playlist-read-collaborative playlist-modify-private playlist-modify-public playlist-read-private user-top-read";

    String url = 'https://accounts.spotify.com/authorize?' +
        'client_id=' +
        _env.clientId +
        '&' +
        'response_type=code&' +
        'redirect_uri=' +
        _env.callbackUrl +
        '&' +
        'scope=' +
        scopes;

    /*var queryParameters = {
      'client_id': _env.clientId,
      'response_type': 'code',
      'redirect_uri': _env.callbackUrl,
      'scope': scopes
    };

    var uri = Uri.https('accounts.spotify.com', '/authorize', queryParameters);

    return http.get(uri);*/
    return launch(url);
  }
}
