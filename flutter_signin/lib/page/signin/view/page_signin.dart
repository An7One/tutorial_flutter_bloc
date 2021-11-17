import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin/page/signin/bloc/bloc_signin.dart';
import 'package:flutter_signin/page/signin/view/form_signin.dart';

class PageSignin extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PageSignin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signin')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return BlocSignin(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: FormSignin(),
        ),
      ),
    );
  }
}
