import 'package:flutter/material.dart';
import '../helpers/helpers.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.string.enter),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: R.string.email),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email){
                      if(!emailValid(email)){
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
                    decoration: InputDecoration(hintText: R.string.password),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    obscureText: true,
                    validator: (password){
                      if(password.isEmpty || password.length < 6){
                        return R.string.invalidPassword;
                      }
                      return null;
                     },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                        onPressed: (){},
                        padding: EdgeInsets.zero,
                        child: Text(R.string.forgetPassword),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: (){
                        if(formKey.currentState.validate()){

                        }
                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                     child: Text(
                        R.string.enter,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                     ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
