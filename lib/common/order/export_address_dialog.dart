import 'package:flutter/material.dart';
import '../../data/data.dart';
import '../../helpers/helpers.dart';

class ExportAddressDialog extends StatelessWidget {
  final Address address;

  const ExportAddressDialog(this.address);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(R.string.deliveryAddress),
      content: Text(
        '${address.street}, ${address.number} ${address.complement}\n'
        '${address.district}\n'
        '${address.city}/${address.state}\n'
        '${address.zipCode}',
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
      actions: [
        FlatButton(
          child: Text(R.string.export),
          onPressed: (){},
        ),
      ],
    );
  }
}
