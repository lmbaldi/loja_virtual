import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/drawer.dart';
import 'package:loja_virtual/helpers/i18n/resources.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  const Color.fromARGB(255, 203, 236, 241),
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              const Divider(),
              DrawerTile(iconData: Icons.home, title: R.string.start, page: 0,),
              DrawerTile(iconData: Icons.list, title: R.string.products, page: 1,),
              DrawerTile(iconData: Icons.playlist_add_check, title: R.string.order, page: 2,),
              DrawerTile(iconData: Icons.location_on, title: R.string.store, page: 3,),
            ],
          ),
        ],
      ),
    );
  }
}