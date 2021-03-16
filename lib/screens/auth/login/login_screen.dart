import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth_repository.dart';
import 'package:flutter_app/logic/cubits/login/login_cubit.dart';
import 'package:flutter_app/screens/auth/login/components/login_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocProvider(
            create: (_) => LoginCubit(context.read<AuthRepository>()),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
