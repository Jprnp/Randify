class User {
  String _name;

  String _imageUrl;

  User.fromSpotifyResponse(Map<String, dynamic> json)
      : _name = json['display_name'],
        _imageUrl = json[''];

  String get name => _name;

  String get imageUrl => _imageUrl;
}
