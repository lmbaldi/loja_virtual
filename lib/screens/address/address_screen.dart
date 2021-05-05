import 'package:flutter/material.dart';
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
        ],
      ),
    );
  }
}
