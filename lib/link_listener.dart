import 'dart:async';

import 'package:randify/deep_link_bloc/bloc.dart';
import 'package:uni_links/uni_links.dart';

class LinkListener {
  StreamSubscription _subscription;

  DeepLinkBloc _linkBlock;

  LinkListener(DeepLinkBloc bloc) {
    _linkBlock = bloc;
  }

  Future<Null> initLinks() async {
    _subscription = getUriLinksStream().listen((Uri link) {
      _handleReturn(link);
    }, onError: (err) {
      print(err.toString());
    });
  }

  void _handleReturn(Uri link) {
    var parameters = link.queryParameters;

    if (parameters.containsKey('code')) {
      _linkBlock.dispatch(ReceivedLink(code: parameters['code']));
    } else {
      _linkBlock.dispatch(ReceivedLink());
    }
  }
}
