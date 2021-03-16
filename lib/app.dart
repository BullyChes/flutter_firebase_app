import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth_repository.dart';
import 'package:flutter_app/logic/blocs/auth/auth_bloc.dart';
import 'package:flutter_app/screens/auth/login/login_screen.dart';
import 'package:flutter_app/screens/home/home_screen.dart';
import 'package:flutter_app/screens/splash_screen.dart';
import 'package:flutter_app/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key key, @required this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (_) => AuthBloc(authRepository: authRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                _navigator.pushAndRemoveUntil(
                    HomeScreen.route(), (route) => false);
                break;
              case AuthStatus.unauthenticated:
                _navigator.pushAndRemoveUntil(
                    LoginScreen.route(), (route) => false);
                break;
              case AuthStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
