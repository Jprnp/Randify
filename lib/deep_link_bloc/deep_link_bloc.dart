import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:randify/deep_link_bloc/bloc.dart';
import 'package:randify/link_listener.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinkBloc extends Bloc<DeepLinkEvent, DeepLinkState> {
  @override
  DeepLinkState get initialState => InitialDeepLinkState();

  LinkListener _listener;

  LinkListener get listener => _listener;

  DeepLinkBloc() {
    _listener = LinkListener(this);
  }

  @override
  Stream<DeepLinkState> mapEventToState(
    DeepLinkEvent event,
  ) async* {
    if (event is ReceivedLink) {
      closeWebView();
      yield ReceivedState(code: event.code);
    }
  }
}
