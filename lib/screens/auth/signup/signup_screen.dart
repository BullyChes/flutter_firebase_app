import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth_repository.dart';
import 'package:flutter_app/logic/cubits/sign_up/sign_up_cubit.dart';
import 'package:flutter_app/screens/auth/signup/components/signup_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocProvider<SignUpCubit>(
            create: (_) => SignUpCubit(context.read<AuthRepository>()),
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}
