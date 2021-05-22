import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/helpers.dart';
import 'package:provider/provider.dart';
import '../../common/common.dart';
import '../../data/data.dart';
import 'stores.dart';

class StoresScreen extends StatelessWidget {

  const StoresScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(R.string.store),
        centerTitle: true,
      ),
      body: Consumer<StoresManager>(
        builder: (_, storesManager, __){
          if(storesManager.stores.isEmpty){
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
              backgroundColor: Colors.transparent,
            );
          }

          return ListView.builder(
            itemCount: storesManager.stores.length,
            itemBuilder: (_, index){
              return StoreCard(storesManager.stores[index]);
            },
          );
        },
      ),
    );
  }
}
