import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randify/authentication_page.dart';
import 'package:randify/error_page.dart';
import 'package:randify/loading_page.dart';
import 'package:randify/main_page.dart';
import 'package:randify/user_respository.dart';

import 'auth_bloc/bloc.dart';
import 'bloc_delegate.dart';
import 'deep_link_bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();

    _authBloc = AuthBloc();
    _checkFileExistance();
  }

  void _checkFileExistance() async {
    _authBloc.dispatch(CheckFileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
        builder: (context) => _authBloc,
        child: MaterialApp(
          title: 'Teste login spotify',
          theme: ThemeData(primarySwatch: Colors.green),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DeepLinkBloc _deepLinkBloc;
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();

    _deepLinkBloc = DeepLinkBloc();
    _deepLinkBloc.listener.initLinks();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeepLinkBloc, DeepLinkState>(
        bloc: _deepLinkBloc,
        listener: (context, state) {
          if (state is ReceivedState) {
            if (state.code != null) {
              _authBloc.dispatch(RedirectEvent(state.code));
            } else {
              _authBloc.dispatch(CheckFileEvent());
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: BlocProvider<DeepLinkBloc>(
            builder: (context) => _deepLinkBloc,
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is LoadingState) {
                return LoadingPage();
              } else if (state is UnauthenticatedState) {
                return AuthenticationPage();
              } else if (state is AuthenticatedState) {
                UserRepository.initializeData(state.authCode);
                return MainPage();
              }

              return ErrorPage();
            }),
          ),
        ));
  }
}
