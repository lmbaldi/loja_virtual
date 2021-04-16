import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/components/components.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/ui/screen/base/base.dart';
import 'package:loja_virtual/core/models/models.dart';

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

