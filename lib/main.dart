import 'package:flutter/material.dart';
import 'package:loja_virtual/models/models.dart';
import 'package:provider/provider.dart';
import 'common/common.dart';
import 'screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return Provider(
        create: (_) => UserManager(),
        child: MaterialApp(
          title: 'Loja do Baldi',
          debugShowCheckedModeBanner: false,
          theme: makeAppTheme(),
          home: BaseScreen()
        ),
      );
  }
}

