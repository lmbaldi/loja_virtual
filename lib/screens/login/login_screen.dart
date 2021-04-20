import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/helpers.dart';
import '../../models/models.dart';
import '../../helpers/helpers.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(R.string.enter),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, child) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        enabled: !userManager.loading,
                        decoration: InputDecoration(hintText: R.string.email),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (!emailValid(email)) {
                            return R.string.invalidEmail;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: passwordController,
                        enabled: !userManager.loading,
                        decoration:
                            InputDecoration(hintText: R.string.password),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        obscureText: true,
                        validator: (password) {
                          if (password.isEmpty || password.length < 6) {
                            return R.string.invalidPassword;
                          }
                          return null;
                        },
                      ),
                    ),
                    child,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 44,
                        child: RaisedButton(
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  if (formKey.currentState.validate()) {
                                    userManager.signIn(
                                        user: User(
                                            email: emailController.text,
                                            password: passwordController.text),
                                        onFail: (error) {
                                          scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.red[900],
                                              content: Text(
                                                R.string.errorLogin + error,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        },
                                        onSuccess: () {
                                          //TODO fechar tela de login
                                        });
                                  }
                                },
                          color: Theme.of(context).primaryColor,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          child: userManager.loading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text(
                                  R.string.enter,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                    )
                  ],
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Text(R.string.forgetPassword),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
