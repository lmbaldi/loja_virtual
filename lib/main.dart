import 'package:flutter/material.dart';
import 'common/common.dart';
import 'screens/base/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Loja do Baldi',
        debugShowCheckedModeBanner: false,
        theme: makeAppTheme(),
        home: BaseScreen()
      );
  }
}

