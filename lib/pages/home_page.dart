import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/*
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new Center(
        child: new Text("Home Page"),
      ),
    );
  }
  Apenas Login
}*/


class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}



class _MyHomePageState extends State<HomePage> {
  //String url = 'https://randomuser.me/api/?results=15';
  String url = 'https://my-json-server.typicode.com/palomacorreia/APIS/db';
  List data;
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      var extractdata =  jsonDecode(response.body);
      data = extractdata["restaurants"];
      print(data);
    });
  }

  @override
  void initState() {
    this.makeRequest();
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Contact List'),
        ),
        body: new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            //percorre a lista
            itemBuilder: (BuildContext context, i) {
              return new ListTile(
                title: new Text(data[i]["nome"]),
                subtitle: new Text(data[i]["telefone"]),
                leading: new CircleAvatar(
                  backgroundImage:
                  new NetworkImage(data[i]["imgurl"]),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new SecondPage(data[i])));
                },
              );
            }
        )
    );
  }

}
/*
new Text(
          "Sqflite App Login",
          textScaleFactor: 2.0,
        )

 */


class SecondPage extends StatelessWidget {
  SecondPage(this.data);
  final data;
  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(title: new Text('Second Page')),
      body: new Center(
          child: new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Image.network(data["imgurl"]),
                new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Icon(Icons.thumb_up),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Text('Like',style: new TextStyle(fontSize: 18.0),),
                        ),

                        new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Text(data["nome"],style: new TextStyle(fontSize: 18.0)),
                        )

                      ],
                    )
                )
              ],
            ),

          )));
/*
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(title: new Text('Second Page')),
      body: new Center(
        child: new Container(
          width: 150.0,
          height: 150.0,
          decoration: new BoxDecoration(
            color: const Color(0xff7c94b6),
            image: new DecorationImage(
              image: new NetworkImage(data["imgurl"]),
              fit: BoxFit.cover,
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(75.0)),
            border: new Border.all(
              color: Colors.red,
              width: 4.0,
            ),
          ),
        ),
      ));
    */
}
