import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../common/common.dart';
import '../../data/data.dart';
import '../../helpers/helpers.dart';

class AdminOrdersScreen extends StatelessWidget {

  final PanelController panelController = PanelController();

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

          return SlidingUpPanel(
            controller: panelController,
            body: Column(children: <Widget>[
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
                ),
              const SizedBox(height: 100,),
            ]),
            minHeight: 40,
            maxHeight: 250,
            panel: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    if(panelController.isPanelClosed){
                      panelController.open();
                    } else {
                      panelController.close();
                    }
                  },
                  child: Container(
                    height: 40,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'Filtros',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: Status.values.map((s){
                      return CheckboxListTile(
                        title: Text(Order.getStatusText(s)),
                        dense: true,
                        activeColor: Theme.of(context).primaryColor,
                        value: ordersManager.statusFilter.contains(s),
                        onChanged: (v){
                          ordersManager.setStatusFilter(
                              status: s,
                              enabled: v
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );

        },
      ),
    );
  }
}