import 'package:flutter/material.dart';
import '../../data/models/models.dart';
import '../../helpers/helpers.dart';
import '../screens.dart';

class EditProductScreen extends StatelessWidget {

  final Product product;

  EditProductScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.string.editAd),
      ),
      body: ListView(
        children: [
          ImagesForm(product),

        ],
      ),
    );
  }
}

