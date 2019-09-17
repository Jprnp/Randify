import 'package:meta/meta.dart';

@immutable
abstract class DeepLinkState {}

class InitialDeepLinkState extends DeepLinkState {}

class DefaultState extends DeepLinkState {}

class ReceivedState extends DeepLinkState {
  ReceivedState({this.code});

  final code;
}
