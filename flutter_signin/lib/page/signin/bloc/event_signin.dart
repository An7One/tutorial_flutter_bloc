part of 'bloc_signin.dart';

abstract class EventSignin extends Equatable {
  const EventSignin();

  @override
  List<Object> get props => [];
}

class SigninUsernameChanged extends EventSignin {
  const SigninUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class SigninPasswordChanged extends EventSignin {
  const SigninPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class SigninSubmitted extends EventSignin {
  const SigninSubmitted();
}
