part of 'bloc_signin.dart';

class StateSignin extends Equatable {
  const StateSignin({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Password password;

  StateSignin copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
  }) {
    return StateSignin(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
