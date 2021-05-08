import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/common.dart';
import '../../data/data.dart';
import '../../helpers/helpers.dart';
import 'address.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.string.delivery),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AddressCard(),
          Consumer<CartManager>(
            builder: (_, cartManager, __){
              return PriceCard(
                buttonText: R.string.buttonProceedPayment,
                onPressed: cartManager.isAddressValid ? (){
                  Navigator.of(context).pushNamed('/checkout');
                } : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
