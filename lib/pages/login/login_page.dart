            import 'package:flutter/cupertino.dart';
            import 'package:flutter/material.dart';
            import 'package:flutter_app_sqlite_restaurant/models/user.dart';
            import 'package:flutter_app_sqlite_restaurant/pages/login/login-presenter.dart';

            class LoginPage extends StatefulWidget {
              @override
              _LoginPageState createState() => new _LoginPageState();
            }
            class  _LoginPageState extends State<LoginPage> implements
                LoginPageContract {
              BuildContext ctx;
              bool isLoading = false;
              final formKey = new GlobalKey<FormState>();
              final scaffOldKey = new GlobalKey<ScaffoldState>();

              String  _username, _password;
              LoginPagePresenter _presenter;

              _LoginPageState() {
                _presenter = new LoginPagePresenter(this);
              }

              void _register() {
                Navigator.of(context).pushNamed("/register");
              }

              void _submit() {
                final form = formKey.currentState;

                if (form.validate()) {
                  setState(() {
                    isLoading = true;
                    form.save();
                    print("SUBMIT");
                    _presenter.doLogin(_username, _password);
                  });
                }
              }
                void _showSnackBar(String text) {
                  scaffOldKey.currentState.showSnackBar(new SnackBar(
                    content: new Text(text),
                  ));
                }


                @override
                Widget build(BuildContext context) {
                  // TODO: implement build

                  ctx = context;
                  var loginBtn = new RaisedButton(
                    onPressed: _submit,
                    child: new Text("Login"),
                    color: Colors.green,
                  );
                  var registerBtn = new RaisedButton(
                    padding: const EdgeInsets.all(10.0),
                    onPressed: _register,
                    child: new Text("Register"),
                    color: Colors.green,
                  );

                  var loginForm = new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "App Login",
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
                                decoration: new InputDecoration(
                                    labelText: "Username"),
                              ),
                            ),

                            new Padding(padding: const EdgeInsets.all(10.0),
                              child: new TextFormField(
                                onSaved: (val) => _password = val,
                                decoration: new InputDecoration(
                                    labelText: "Password"),
                              ),
                            )
                          ],
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.all(10.0),
                          child: loginBtn),

                      registerBtn
                    ],
                  );

                  return new Scaffold(
                    appBar: new AppBar(
                      title: new Text("Login Page"),
                    ),
                    key: scaffOldKey,
                    body: new Container(
                      child: new Center(
                        child: loginForm,
                      ),
                    ),
                  );
                }

                @override
                void onLoginError(String error) {
                  // TODO: implement onLoginError
                  _showSnackBar(error);
                  setState(() {
                    isLoading = false;
                  });
                }

                @override
                void onLoginSuccess(User user) {
                  // TODO: implement onLoginSuccess
                  print("sucess");
                  setState(() {
                    isLoading = false;
                  });
                  if (user.flaglogado == "logado") {
                    print("logado");
                    Navigator.of(context).pushNamed("/home");
                  } else {
                    print("não logado");
                  }
                }
              }


