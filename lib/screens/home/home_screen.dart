import 'package:flutter/material.dart';
import 'package:flutter_app/logic/blocs/auth/auth_bloc.dart';
import 'package:flutter_app/screens/home/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
              key: const Key('homePage_logout_iconButton'),
              icon: Icon(Icons.logout),
              onPressed: () =>
                  context.read<AuthBloc>().add(AuthLogoutRequest()))
        ],
      ),
      body: Body(user: user),
    );
  }
}
