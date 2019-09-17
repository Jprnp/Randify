import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randify/auth_bloc/auth_bloc.dart';
import 'package:randify/auth_bloc/auth_event.dart';

class AuthenticationPage extends StatelessWidget {
  AuthBloc _authBloc;

  void _authenticate() {
    _authBloc.dispatch(AuthenticateEvent());
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text('Autenticar'),
            onPressed: _authenticate,
          ),
        ],
      ),
    );
  }
}
