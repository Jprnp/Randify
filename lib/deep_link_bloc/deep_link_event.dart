import 'package:meta/meta.dart';

@immutable
abstract class DeepLinkEvent {}

class ReceivedLink extends DeepLinkEvent {
  ReceivedLink({this.code});

  final String code;
}
