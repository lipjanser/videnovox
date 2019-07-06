import 'package:flutter/material.dart';
import 'package:videnovox/apimovies/itemdetail.dart';
import 'detail.dart';
import 'movieDAO.dart';
import 'package:videnovox/apimovies/favoritedetail.dart';

class ListPage extends StatefulWidget {
  final String item;

  const ListPage({this.item});

  @override
  _ListState createState() => _ListState(item);
}

class _ListState extends State<ListPage> {
  final String item;


  _ListState(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: FutureBuilder(
        future: MovieDAO().get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.length);
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data[index].id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    MovieDAO().delete(snapshot.data[index].id);
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      /*Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FavoriteDetailPage(
                            item: ItemDetail.fromJson(snapshot.data["Search"][index] ),
                          ),
                        ),
                      );*/
                    },
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("${snapshot.data[index].poster}"),
                          ),
                          title: Text("${snapshot.data[index].title}"),
                          subtitle: Text("${snapshot.data[index].type}"),
                          trailing: Text("${snapshot.data[index].year}"),
                        ),
                        Divider(
                          height: 2,
                        ),
                      ],
                    )
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("No content to display =/"),
            );
          }
        },
      ),
/*      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(),
            ),
          );
        },
      ),*/
    );
  }
}