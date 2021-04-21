import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../helpers/helpers.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(R.string.addAccount),
        centerTitle: true,
      ),
      key: scaffoldKey,
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __){
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: R.string.fullName),
                        enabled: !userManager.loading,
                        validator: (name){
                          if(name.isEmpty){
                            return R.string.msgRequiredField;
                          }else if(name.trim().split(' ').length <= 1){
                            return R.string.fillFullName;
                          }
                          return null;
                        },
                        onSaved: (name) => user.name = name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: R.string.email),
                        enabled: !userManager.loading,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email){
                          if(email.isEmpty){
                            return R.string.msgRequiredField;
                          }else if(!emailValid(email)){
                            return R.string.invalidEmail;
                          }
                          return null;
                        },
                        onSaved: (email) => user.email = email,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: R.string.password),
                        enabled: !userManager.loading,
                        autocorrect: false,
                        obscureText: true,
                        validator: (password) {
                          if (password.isEmpty) {
                            return R.string.msgRequiredField;
                          } else if (password.length < 6) {
                            return R.string.shortPassword;
                          }
                          return null;
                        },
                        onSaved: (password) => user.password = password,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: R.string.repeatPassword),
                        enabled: !userManager.loading,
                        autocorrect: false,
                        obscureText: true,
                        validator: (password) {
                          if (password.isEmpty) {
                            return R.string.msgRequiredField;
                          } else if (password.length < 6) {
                            return R.string.shortPassword;
                          }
                          return null;
                        },
                        onSaved: (password) => user.confirmPassword = password,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 44,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                          child: userManager.loading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text(
                                  R.string.addAccount,
                                  style: TextStyle(fontSize: 18),
                                ),
                          onPressed: userManager.loading ? null : (){
                            if(formKey.currentState.validate()){
                              formKey.currentState.save();
                              if(user.password != user.confirmPassword){
                                scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red[900],
                                    content: Text(
                                      R.string.passwordsDifferents,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                                return;
                              }
                              userManager.signUp(
                                  user: user,
                                  onSuccess: (){
                                    Navigator.of(context).pop();
                                  },
                                  onFail: (e){
                                    scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red[900],
                                        content: Text(
                                          '${R.string.failedRegister}: $e' ,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }
                              );
                            }
                          },

                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
