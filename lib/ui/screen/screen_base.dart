import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/ui/page_manager/page_manager.dart';
import 'package:loja_virtual/ui/components/drawer/drawer.dart';

class ScreenBase extends StatelessWidget {

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            drawer: DrawerCustom(),
            appBar: AppBar(
              title: const Text('Home'),
            ),
          ),
          Container(color: Colors.red,),
          Container(color: Colors.green,),
          Container(color: Colors.blue,),
        ],
      ),
    );
  }
}
