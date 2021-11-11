import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageSplash extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PageSplash());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
