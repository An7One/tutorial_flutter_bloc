import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_signin/page/signin/model/model.dart';
import 'package:formz/formz.dart';

part 'event_signin.dart';
part 'state_signin.dart';

class BlocSignin extends Bloc<EventSignin, StateSignin> {
  BlocSignin({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const StateSignin()) {
    on<SigninUsernameChanged>(_onUsernameChanged);
    on<SigninPasswordChanged>(_onPasswordChanged);
    on<SigninSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    SigninUsernameChanged event,
    Emitter<StateSignin> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, state.username]),
    ));
  }

  void _onPasswordChanged(
    SigninPasswordChanged event,
    Emitter<StateSignin> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void _onSubmitted(
    SigninSubmitted event,
    Emitter<StateSignin> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.signIn(
            username: state.username.value, password: state.password.value);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
