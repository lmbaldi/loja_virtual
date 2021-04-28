import 'package:flutter/material.dart';
import '../../data/models/models.dart';
import '../../helpers/helpers.dart';
import '../screens.dart';

class EditProductScreen extends StatelessWidget {

  final Product product;

  EditProductScreen(this.product);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(R.string.editAd),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            ImagesForm(product),
            Padding(padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                      initialValue: product.name,
                      decoration: InputDecoration(
                        hintText: R.string.title,
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          fontSize:  20,
                          fontWeight: FontWeight.w600
                      ),
                    validator: (name) {
                        if(name.length < 6)
                          return R.string.shortTitle;
                        return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      R.string.from,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ${product.basePrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      R.string.description,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                    decoration: InputDecoration(
                        hintText:  R.string.description,
                        border: InputBorder.none
                    ),
                    maxLines: null,
                    validator: (desc){
                      if(desc.length < 10)
                        return R.string.shortTitle;
                      return null;
                    },
                  ),
                  SizesForm(product),
                  RaisedButton(
                    onPressed: (){
                      if(formKey.currentState.validate()){
                        print('valido');
                      }
                    },
                    child: Text(R.string.save),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

