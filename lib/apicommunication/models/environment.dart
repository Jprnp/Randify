class Environment {
  String _clientId;
  String _clientSecret;
  String _callbackUrl;

  Environment.fromJson(Map<String, dynamic> json)
      : _clientId = json['clientId'],
        _clientSecret = json['clientSecret'],
        _callbackUrl = json['callbackUrl'];

  String get clientId => _clientId;
  String get clientSecret => _clientSecret;
  String get callbackUrl => _callbackUrl;
}
