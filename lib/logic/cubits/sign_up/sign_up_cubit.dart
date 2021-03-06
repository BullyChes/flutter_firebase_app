import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/api/auth_repository.dart';
import 'package:flutter_app/models/confirmed_password.dart';
import 'package:flutter_app/models/email.dart';
import 'package:flutter_app/models/password.dart';
import 'package:formz/formz.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepository)
      : assert(_authRepository != null),
        super(const SignUpState());

  final AuthRepository _authRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email,
        status:
            Formz.validate([email, state.password, state.confirmedPassword])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
        password: password.value, value: state.confirmedPassword.value);
    emit(state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status:
            Formz.validate([state.email, password, state.confirmedPassword])));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword =
        ConfirmedPassword.dirty(password: state.password.value, value: value);
    emit(state.copyWith(
        confirmedPassword: confirmedPassword,
        status:
            Formz.validate([state.email, state.password, confirmedPassword])));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository.signUp(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
