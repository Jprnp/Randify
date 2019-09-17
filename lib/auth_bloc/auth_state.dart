import 'package:meta/meta.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class UnauthenticatedState extends AuthState {}

class LoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  AuthenticatedState(this.authCode);

  final String authCode;
}
