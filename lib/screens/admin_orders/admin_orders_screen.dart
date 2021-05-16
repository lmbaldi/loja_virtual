import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/common.dart';
import '../../data/data.dart';
import '../../helpers/helpers.dart';

class AdminOrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title:  Text(R.string.allOrders),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, ordersManager, __){

          if(ordersManager.orders.isEmpty){
            debugPrint('${ordersManager.orders}');
            return EmptyCard(
              title: R.string.noSalesMade,
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: ordersManager.orders.length,
              itemBuilder: (_, index){
                return OrderTile(
                  ordersManager.orders.reversed.toList()[index],
                  showControls: true,
                );
              }
          );
        },
      ),
    );
  }
}
