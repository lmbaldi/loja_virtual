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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Loja do Baldi',
        debugShowCheckedModeBanner: false,
        theme: makeAppTheme(),
        initialRoute: '/base',
        onGenerateRoute: (settings) {

          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/signUp':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
