import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/data/data.dart';
import 'package:provider/provider.dart';
import '../../../data/models/address.dart';
import '../../../helpers/helpers.dart';

class AddressInputField extends StatelessWidget {
  Address address;

  AddressInputField(this.address);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final cartManager = context.watch<CartManager>();

    String emptyValidator(String text) =>
        text.isEmpty ? R.string.msgRequiredField : null;

    if(address.zipCode != null)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: address.street,
          decoration: InputDecoration(
            isDense: true,
            labelText: R.string.labelTextStreet,
            hintText: R.string.hintTextStreet,
          ),
          validator: emptyValidator,
          onSaved: (t) => address.street = t,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                // enabled: !cartManager.loading,
                initialValue: address.number,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: R.string.labelTextNumber,
                  hintText: R.string.labelTextNumber,
                ),
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                validator: emptyValidator,
                onSaved: (t) => address.number = t,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                // enabled: !cartManager.loading,
                initialValue: address.complement,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: R.string.labelTextComplement,
                  hintText: R.string.hintTextOptional,
                ),
                onSaved: (t) => address.complement = t,
              ),
            ),
          ],
        ),
        TextFormField(
          initialValue: address.district,
          decoration: InputDecoration(
              isDense: true,
              labelText: R.string.labelTextDistrict,
              hintText: R.string.hintTextDistrict),
          validator: emptyValidator,
          onSaved: (t) => address.district = t,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: TextFormField(
                enabled: false,
                initialValue: address.city,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: R.string.labelTextCity,
                  hintText: R.string.hintTextCity,
                ),
                validator: emptyValidator,
                onSaved: (t) => address.city = t,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                enabled: false,
                textCapitalization: TextCapitalization.characters,
                initialValue: address.state,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: R.string.labelTextState,
                  hintText: R.string.hintTextState,
                  counterText: '',
                ),
                maxLength: 2,
                validator: (e) {
                  if (e.isEmpty) {
                    return R.string.msgRequiredField;
                  } else if (e.length != 2) {
                    return R.string.invalidField;
                  }
                  return null;
                },
                onSaved: (t) => address.state = t,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        if (cartManager.loading)
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(primaryColor),
            backgroundColor: Colors.transparent,
          ),
        RaisedButton(
          color: primaryColor,
          disabledColor: primaryColor.withAlpha(100),
          textColor: Colors.white,
          onPressed: !cartManager.loading
              ? () async {
                  if (Form.of(context).validate()) {
                    Form.of(context).save();
                    try {
                      //await context.read<CartManager>().setAddress(address);
                    } catch (e) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('$e'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  }
                }
              : null,
          child: const Text('Calcular Frete'),
        ),
      ],
    );
    else
      return Container();
  }
}
