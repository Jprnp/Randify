class Environment {
  String _clientId;
  String _callbackUrl;

  Environment.fromJson(Map<String, dynamic> json)
      : _clientId = json['clientId'],
        _callbackUrl = json['callbackUrl'];

  String get clientId => _clientId;
  String get callbackUrl => _callbackUrl;
}
