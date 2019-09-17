import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:randify/apicommunication/api-endpoint.dart';
import 'package:randify/apicommunication/models/environment.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  Environment _env;

  Environment get env => _env;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckFileEvent) {
      yield LoadingState();

      if (_fileExists()) {
        //yield AuthenticatedState();
      } else {
        yield UnauthenticatedState();
      }
    } else if (event is AuthenticateEvent) {
      yield LoadingState();
      await _getEnvironmentConfig();
      await _authenticate();
    } else if (event is RedirectEvent) {
      yield AuthenticatedState(event.authCode);
    }
  }

  bool _fileExists() {
    return false;
  }

  Future<void> _getEnvironmentConfig() async {
    var response = await http
        .get('https://us-central1-randify.cloudfunctions.net/getEnvConfig');

    print(response.body);

    _env = Environment.fromJson(json.decode(response.body));
  }

  Future<bool> _authenticate() {
    var endpoint = ApiEndpoint(env: _env);
    return endpoint.authenticate();
  }
}
