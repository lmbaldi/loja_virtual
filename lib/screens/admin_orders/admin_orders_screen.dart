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
        title: Text(R.string.allOrders),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, ordersManager, __) {
          final filteredOrders = ordersManager.filteredOrders;

          return Column(children: <Widget>[
            if (ordersManager.userFilter != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Pedidos de ${ordersManager.userFilter.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CustomIconButton(
                      iconData: Icons.close,
                      color: Colors.white,
                      onTap: () {
                        ordersManager.setUserFilter(null);
                      },
                    )
                  ],
                ),
              ),
            if (filteredOrders.isEmpty)
              EmptyCard(
                title: R.string.noSalesMade,
                iconData: Icons.border_clear,
              )
            else
              Expanded(
                child: ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (_, index) {
                      return OrderTile(
                        ordersManager.filteredOrders[index],
                        showControls: true,
                      );
                    }),
              )
          ]);
        },
      ),
    );
  }
}
