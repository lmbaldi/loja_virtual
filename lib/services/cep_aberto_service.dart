import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loja_virtual/data/data.dart';
import 'constants.dart' as Constants;

class CepAbertoService{

  Future<void> getAddressFromCep(String cep) async {

    String token = Constants.TOKEN_ABERTO;
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endPoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token toke=$token';

    try{
      final response = await dio.get<Map<String,dynamic>>(endPoint);
      if(response.data.isNotEmpty){
        return Future.error('CEP INVALIDO');
      }

      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);
      return address;

    } on DioError catch(e){
      return Future.error('Erro ao buscar CEP');
    }
  }
}