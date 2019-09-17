import 'package:http/http.dart' as http;
import 'package:randify/apicommunication/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/environment.dart';

class ApiEndpoint {
  static ApiEndpoint _instance;

  static final String BASE_URL =
      'https://us-central1-randify.cloudfunctions.net';

  static final String EXCHANGE_URL = BASE_URL + '/exchange';

  static final String REFRESH_URL = BASE_URL + '/refresh';

  Environment _env;

  User _user;

  factory ApiEndpoint({Environment env}) {
    _instance ??= ApiEndpoint._apiEndpoint(env);
    return _instance;
  }

  ApiEndpoint._apiEndpoint(Environment env) {
    _env = env;
  }

  bool hasEnv() {
    return _env != null;
  }

  User get user => _user;

  void set user(User user) {
    this._user = user;
  }

  Future<String> exchange(String code) async {
    var response = await http.post(EXCHANGE_URL, body: {"code": code});
    return response.body;
  }

  void refreshToken() {}

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
        scopes +
        '&' +
        'show_dialog=true';

    return launch(url);
  }
}
