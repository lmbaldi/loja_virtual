import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawer.dart';
import '../../data/data.dart';
import '../../helpers/i18n/resources.dart';

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
              Consumer<UserManager>(
                builder: (_, userManager, __){
                  if(userManager.adminEnabled) {
                    return Column(
                      children: [
                        const Divider(),
                        DrawerTile(iconData: Icons.settings,
                          title: R.string.users,
                          page: 4,),
                        DrawerTile(iconData: Icons.settings,
                          title: R.string.orders,
                          page: 5,),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
