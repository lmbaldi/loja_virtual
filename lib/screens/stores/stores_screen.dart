import 'package:flutter/material.dart';
import 'package:loja_virtual/common/common.dart';

class StoresScreen extends StatelessWidget {

  const StoresScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Lojas'),
        centerTitle: true,
      ),
    );
  }
}
