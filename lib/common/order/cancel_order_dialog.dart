import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/helpers.dart';
import '../../data/data.dart';

class CancelOrderDialog extends StatefulWidget {
  //alterado para stateful para gerenciar o estado somente do alert dialog
  final Order order;

  CancelOrderDialog(this.order);

  @override
  _CancelOrderDialogState createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {

  bool loading = false;
  String error;

  @override
  Widget build(BuildContext context) {
    // WillPopScope -> para desabilitar o botao voltar do celular
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: Text('${R.string.cancel} ${widget.order.formattedId}?'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              loading
                ? '${R.string.canceling}'
                : '${R.string.msgCancelOrderDialog}'),
            if(error != null)
              Padding(
                  padding: const EdgeInsets.only(top: 8),
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
        actions: [
          FlatButton(
              onPressed: !loading ? (){
                Navigator.of(context).pop();
              }: null,
              child: Text(R.string.goBack)
          ),
          FlatButton(
              onPressed: !loading ? () async {
                setState(() {
                  loading = true;
                });
                try{
                  await widget.order.cancel();
                  Navigator.of(context).pop();
                }catch(e){
                  setState(() {
                    loading = false;
                    error = e.toString();
                  });
                }
              }: null,
              color: Colors.red,
              child: Text(R.string.cancelOrder)
          )
        ],
      ),
    );
  }
}
