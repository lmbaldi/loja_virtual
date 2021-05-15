import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/helpers/helpers.dart';
import 'package:provider/provider.dart';
import '../../common/common.dart';
import '../../data/data.dart';
import '../../helpers/helpers.dart';

class CheckoutScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) => checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(R.string.payment),
          centerTitle: true,
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager, __){
            if(checkoutManager.loading){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    const SizedBox(height: 16,),
                  ],
                ),
              );
            }
            return ListView(
              children: [
                PriceCard(
                  buttonText: R.string.checkOut,
                  onPressed: () {
                    checkoutManager.checkout(
                        onStockFail: (e) {
                          Navigator.of(context).popUntil((route) =>
                          route.settings.name == '/cart');
                        },
                        onSuccess: (order) {
                          Navigator.of(context).popUntil((route) =>
                          route.settings.name == '/');
                          Navigator.of(context).pushNamed('/confirmation', arguments: order);
                        }
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
