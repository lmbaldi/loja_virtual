import 'dart:collection';

import 'package:cloud_functions/cloud_functions.dart';
import '../data/data.dart';

class CieloPayment{

  final CloudFunctions functions = CloudFunctions.instance;

  Future<void> authorize(
      {CreditCard creditCard, num price, String orderId, User user}) async {
    try {
    final Map<String, dynamic> dataSale = {
      'merchantOrderId': orderId,
      //'amount': 10 * 100,
      'amount': (price * 100).toInt(),
      'softDescriptor': 'Loja Daniel',
      'installments': 1,
      'creditCard': creditCard.toJson(),
      'cpf': user.cpf,
      'paymentType': 'CreditCard',
    };

    final HttpsCallable callable = functions.getHttpsCallable(
        functionName: 'authorizeCreditCard'
    );
    final response = await callable.call(dataSale);
    final data = Map<String,dynamic>.from(response.data as LinkedHashMap);
    if (data['success'] as bool) {
      return data['paymentId'] as String;
    } else {
      return Future.error(data['error']['message']);
    }

    } catch (e){
      //debugPrint('$e');
      return Future.error('Falha ao processar transação. Tente novamente.');
    }

  }
}