import 'dart:async';

import 'package:flutter_app_sqlite_restaurant/models/user.dart';
import 'package:flutter_app_sqlite_restaurant/utils/network-util.dart';
import 'package:flutter_app_sqlite_restaurant/data/database-helper.dart';

class RestData {
 NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<User> login( String username, String password) async {
    String flaglogado = "logado";
    //aqui vamos simular a conexao com internet fazendo um select no banco de dados local para verificar
    //se usuario ja foi cadastrado
    var user = new User(null, username, password, null);
    var db = new DatabaseHelper();
    var userRetorno = new User(null,null,null,null);
    userRetorno = await db.selectUser(user);
    if(userRetorno != null){
      flaglogado = "logado";
      return new Future.value(new User(null, username, password,flaglogado));
    }else {
      flaglogado = "nao";
      return new Future.value(new User(null, username, password,flaglogado));
    }
  }
}
