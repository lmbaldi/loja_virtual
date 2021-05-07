import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../data/data.dart';
import 'constants.dart' as Constants;

class CepAbertoService{

  Future<CepAbertoAddress> getAddressFromCep(String cep) async {

    String token = Constants.TOKEN_ABERTO;
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    print(cleanCep);
    final endPoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try{
      final response = await dio.get<Map<String,dynamic>>(endPoint);
      print(response.data);
      if(response.data.isEmpty){
        return Future.error('CEP INVALIDO');
      }

      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);
      return address;

    } on DioError catch(e){
      debugPrint(e.toString());
      return Future.error('Erro ao buscar CEP');
    }
  }
}