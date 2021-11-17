import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin/page/signin/bloc/bloc_signin.dart';
import 'package:formz/formz.dart';

class FormSignin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocSignin, StateSignin>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _InputUsername(),
            const Padding(padding: EdgeInsets.all(12)),
            _InputPassword(),
            const Padding(padding: EdgeInsets.all(12)),
            _BtnSignin(),
          ],
        ),
      ),
    );
  }
}

class _InputUsername extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocSignin, StateSignin>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('textField_inputUsername_formSignin'),
          onChanged: (username) =>
              context.read<BlocSignin>().add(SigninUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'username',
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _InputPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocSignin, StateSignin>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('textField_inputPassword_formSignin'),
          onChanged: (password) =>
              context.read<BlocSignin>().add(SigninPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _BtnSignin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocSignin, StateSignin>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('btnRaised_continue_formSignin'),
                child: const Text('Signin'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<BlocSignin>().add(const SigninSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}
