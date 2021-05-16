import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import '../../data/data.dart';
import '../../helpers/helpers.dart';

class ExportAddressDialog extends StatelessWidget {
  final Address address;
  final ScreenshotController screenShotController = ScreenshotController();

  ExportAddressDialog(this.address);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(R.string.deliveryAddress),
      content: Screenshot(
        controller: screenShotController,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Text(
            '${address.street}, ${address.number} ${address.complement}\n'
            '${address.district}\n'
            '${address.city}/${address.state}\n'
            '${address.zipCode}',
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
      actions: [
        FlatButton(
          child: Text(R.string.export),
          onPressed: () async{
            Navigator.of(context).pop();
            final file =  await screenShotController.capture();
            await GallerySaver.saveImage(file.path);
          },
        ),
      ],
    );
  }
}
