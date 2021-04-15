import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/components/drawer/drawer.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';

class DrawerCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        children: [
          DrawerTile(
            iconData: Icons.home,
            title: R.string.start,
            page: 0,
          ),
          DrawerTile(
            iconData: Icons.list,
            title: R.string.products,
            page: 1,
          ),
          DrawerTile(
            iconData: Icons.playlist_add_check,
            title: R.string.order,
            page: 2,
          ),
          DrawerTile(
            iconData: Icons.shop,
            title: R.string.store,
            page: 3,
          ),
        ],
      ),
    );
  }
}
