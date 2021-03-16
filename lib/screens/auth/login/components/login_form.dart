import 'package:flutter/material.dart';
import 'package:flutter_app/logic/cubits/login/login_cubit.dart';
import 'package:flutter_app/screens/auth/signup/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                const SnackBar(content: Text("Authentication Failure")));
        }
      },
      child: Align(
        alignment: Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _EmailInput(),
              const SizedBox(height: 8),
              _PasswordInput(),
              const SizedBox(height: 16),
              _LoginButton(),
              const SizedBox(height: 8),
              _SignUpButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return Container(
            child: TextField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<LoginCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              maxLength: 99,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Email",
                helperText: "",
                errorText: state.email.invalid ? "invalid email" : null,
                icon: Icon(Icons.email),
              ),
            ),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return Container(
            child: TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginCubit>().passwordChanged(password),
              style: TextStyle(color: Colors.white),
              maxLength: 8,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  helperText: "",
                  errorText: state.password.invalid ? "invalid password" : null,
                  icon: Icon(Icons.lock)),
            ),
          );
        });
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  key: const Key('loginForm_continue_elevatedButton'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      primary: Colors.blue),
                  onPressed: state.status.isValidated
                      ? () => context.read<LoginCubit>().loginWithCredentials()
                      : null,
                  child: Text("SIGN IN"));
        });
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        key: const Key('loginForm_createAccount_textButton'),
        onPressed: () => Navigator.of(context).push(SignUpScreen.route()),
        child: Text("CREATE ACCOUNT"));
  }
}
