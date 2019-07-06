import 'package:flutter/material.dart';
import 'package:videnovox/apimovies/item.dart';
import 'package:videnovox/apimovies/itemdetail.dart';
import 'package:videnovox/apimovies/detail.dart';
import 'package:videnovox/database/list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //TextEditingController _textEditingController = TextEditingController(text: "Difendo/Rictusempra");

  /* Projeto da disciplina de Flutter - Faculdade Ibratec
   * Aluno: Felipe Janser
   * Matrícula: 2016206772
   */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController = TextEditingController(text: "");
  Future<dynamic> items;

  void _retrieveData() {
    setState(() {
      items = Item.retrieveData("${_textEditingController.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ViDeNovo X"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4),),
                      ),
                    ),
                  ),
              ),
              RaisedButton(
                onPressed: () {
                  if(_textEditingController.text.isEmpty) {
                    print("Não pesquisou.");
                  } else {
                    _retrieveData();
                  }
                },
                child: const Text(
                    'Search',
                    style: TextStyle(fontSize: 12)
                ),
              ),
            ],
          ),
          Expanded(
            child:FutureBuilder(
              future: items,
              //future: ItemDetail.retrieveData("tt0107290"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //print("ItemCount: ${snapshot.data.length} Dados: ${snapshot.data}");
                  return ListView.builder(
                    itemCount: snapshot.data["Search"]?.length,
                    itemBuilder: (context, index) {
                      //print("${snapshot.data[index]["Title"]}");
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage("${snapshot.data["Search"][index]["Poster"]}"),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    item: ItemDetail.fromJson(snapshot.data["Search"][index] ),
                                  ),
                                ),
                              );
                            },
                            title: Text("${snapshot.data["Search"][index]["Title"]}"),
                            subtitle: Text("${snapshot.data["Search"][index]["Type"]}"),
                            trailing: Text("${snapshot.data["Search"][index]["Year"]}"),
                          ),
                          Divider(
                            height: 2,
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ),

        ],
      )
        ,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.movie),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListPage(),
              ),
            );
          },
        )
    );
  }
}

