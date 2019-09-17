import 'package:flutter/material.dart';
import 'package:randify/apicommunication/api-endpoint.dart';

class MainPage extends StatelessWidget {
  var _apiEndpoint = ApiEndpoint();

  Widget buildHeader() {
    return Column(
      children: <Widget>[
        CircleAvatar(
          child: Image(
            image: NetworkImage(_apiEndpoint.user.imageUrl),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildHeader();
  }
}
