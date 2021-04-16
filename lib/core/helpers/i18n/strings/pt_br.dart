import 'translations.dart';

class PtBr implements Translations {
  //labels
  String get start => 'Início';
  String get products => 'Produtos';
  String get order => 'Meu pedido';
  String get store => 'Loja';
  String get enter => 'Entrar';
  String get password => 'Senha';
  String get email => 'Email';
  String get forgetPassword => 'Esqueci minha senha';
  String get invalidPassword => 'Senha inválida';
  String get invalidEmail => 'Email inválido';
  String get typeLoginEmail => 'Digite o login(email)';
  String get typePassword => 'Digite a senha';
  String get errorWeakPassword => 'Sua senha é muito fraca.';
  String get errorInvalidEmail => 'Seu e-mail é inválido.';
  String get errorEmailAlreadyInUse => 'E-mail já está sendo utilizado em outra conta.';
  String get errorInvalidCredential => 'Seu e-mail é inválido.';
  String get errorWrongPassword => 'Sua senha está incorreta.';
  String get errorUserNotFound => 'Não há usuário com este e-mail.';
  String get errorUserDisable => 'Este usuário foi desabilitado.';
  String get errorTooManyRequests => 'Muitas solicitações. Tente novamente mais tarde.';
  String get errorOperationNotAllowed => 'Operação não permitida.';
  String get errorUndefined => 'Um erro indefinido ocorreu.';
  String get errorLogin => 'Falha no login. ';
}