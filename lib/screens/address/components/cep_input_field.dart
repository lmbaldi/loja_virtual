import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/common/common.dart';
import 'package:provider/provider.dart';
import 'package:brasil_fields/brasil_fields.dart';
import '../../../data/data.dart';
import '../../../helpers/helpers.dart';

class CepInputField extends StatelessWidget {

  final Address address;

  CepInputField(this.address);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;
    if(address.zipCode == null)
      return Column(
        children: [
          TextFormField(
            controller: cepController,
            decoration: InputDecoration(
              isDense: true,
              labelText: R.string.zipCode,
              hintText: R.string.zipCodeHintText
            ),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            keyboardType: TextInputType.number,
            validator: (cep){
              if(cep.isEmpty) {
                return 'Campo obrigatório';
              } else if(cep.length != 10) {
                return 'CEP Inválido';
              } else {
                return null;
              }
            },
          ),
          RaisedButton(
            onPressed: (){
              if(Form.of(context).validate()){
                print(cepController.text);
                context.read<CartManager>().getAddress(cepController.text);
              }
            },
            textColor: Colors.white,
            color: primaryColor,
            disabledColor: primaryColor.withAlpha(100),
            child: Text('Buscar CEP'),
          ),
        ],
      );
    else
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${R.string.zipCode}: ${address.zipCode}',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            CustomIconButton(
              iconData: Icons.edit,
              color: primaryColor,
              size: 20,
              onTap: (){
                context.read<CartManager>().removeAddress();
              },
            )
          ],
        ),
      );
  }
}
