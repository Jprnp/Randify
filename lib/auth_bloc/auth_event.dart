import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}

class CheckFileEvent extends AuthEvent {}

class AuthenticateEvent extends AuthEvent {}

class RedirectEvent extends AuthEvent {
  RedirectEvent(this.authCode);

  final String authCode;
}
