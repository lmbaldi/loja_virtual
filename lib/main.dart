import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/components/theme/theme.dart';
import 'package:loja_virtual/ui/screen/screen.dart';

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
      home: ScreenBase()
    );
  }
}

