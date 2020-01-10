
import 'package:flutter/cupertino.dart';
    import 'package:flutter/material.dart';
  import 'package:flutter_app_sqlite_restaurant/data/database-helper.dart';
  import 'package:flutter_app_sqlite_restaurant/models/user.dart';

    class RegisterPage extends StatefulWidget  {
      @override
     _RegisterPageState createState() => new  _RegisterPageState();
      }

    class  _RegisterPageState extends State<RegisterPage> {
      BuildContext ctx;
      bool isLoading = false;
      final formKey = new GlobalKey<FormState>();
      final scaffOldKey = new GlobalKey<ScaffoldState>();
      String _name, _username, _password;

      @override
      Widget build(BuildContext context) {
        ctx = context;
        var loginBtn = new RaisedButton(
          onPressed: _submit,
          child: new Text("Register"),
          color: Colors.green,
        );

        var loginForm = new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Sqlite App Login",
              textScaleFactor: 2.0,

            ),
            new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new TextFormField(
                      onSaved: (val) => _username = val,
                      decoration: new InputDecoration(labelText: "Name"),
                    ),
                  ),

                  new Padding(padding: const EdgeInsets.all(10.0),
                    child: new TextFormField(
                      onSaved: (val) => _password = val,
                      decoration: new InputDecoration(labelText: "Password"),
                    ),
                  )
                ],
              ),
            ),
            loginBtn
          ],
        );
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Register"),
          ),
          key: scaffOldKey,
          body: new Container(
            child: new Center(
              child: loginForm,
            ),
          ),
        );
      }//build

      void _showSnackBar(String text) {
        scaffOldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(text),
        ));
      }

      void _submit() {
      final form = formKey.currentState;

      if(form.validate()){
        setState((){
          isLoading=true;
          form.save();
          var user = new User(_name, _username, _password, null);
          var db = new DatabaseHelper();
          db.saveUser(user);
          isLoading =false;
          Navigator.of(ctx).pushNamed("/login");
        });
        }
      }
    }



