import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:brasil_fields/brasil_fields.dart';
import '../../../data/data.dart';
import '../../../common/common.dart';
import '../../../helpers/helpers.dart';

class CepInputField extends StatefulWidget {

  final Address address;

  CepInputField(this.address);

  @override
  _CepInputFieldState createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {

  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final primaryColor = Theme.of(context).primaryColor;
    if(widget.address.zipCode == null)
      return Column(
        children: [
          TextFormField(
            enabled: !cartManager.loading,
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
          if(cartManager.loading)
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(primaryColor),
            backgroundColor: Colors.transparent,
          ),
          RaisedButton(
            onPressed: !cartManager.loading ? () async {
              if(Form.of(context).validate()){
                try {
                  await context.read<CartManager>().getAddress(cepController.text);
                } catch (e){
                  Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$e'),
                        backgroundColor: Colors.red,
                      )
                  );
                }
              }
            }: null,
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
                '${R.string.zipCode}: ${widget.address.zipCode}',
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
