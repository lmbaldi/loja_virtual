import 'package:flutter/material.dart';
import '../helpers/i18n/resources.dart';

class LoginScreen extends StatelessWidget {
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
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: R.string.email),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email){return null;},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
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
                    onPressed: (){},
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
    );
  }
}
