import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/screen/screen.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/ui/page_manager/page_manager.dart';
import 'package:loja_virtual/ui/components/drawer/drawer.dart';

class BaseScreen extends StatelessWidget {

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          LoginScreen(),
          Container(color: Colors.red,),
          Container(color: Colors.green,),
          Container(color: Colors.blue,),
        ],
      ),
    );
  }
}
