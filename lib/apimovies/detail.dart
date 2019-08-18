import 'package:flutter/material.dart';
import 'itemdetail.dart';
import 'package:videnovox/database/movieDAO.dart';
import 'package:videnovox/database/movie.dart';

class DetailPage extends StatefulWidget {
  final ItemDetail item;

  const DetailPage({this.item});

  @override
  _DetailPageState createState() => _DetailPageState(item);
}

class _DetailPageState extends State<DetailPage> {
  final ItemDetail item;

  _DetailPageState(this.item);

  /*
   * Projeto da disciplina de Flutter - Faculdade Ibratec
   * Aluno: Felipe Janser
   * Matrícula: 2016206772
   */

  @override
  Widget build(BuildContext context) {
    print("${this.item.toString()}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Column(
          children: <Widget>[
            Container(
              child: FutureBuilder(
                future: ItemDetail.retrieveData("${item.imdbID}"),
                //future: ItemDetail.retrieveData("tt0107290"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column (
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints.expand(height: 200),
                            alignment: Alignment.center,
                            child: Image.network("${snapshot.data["Poster"]}"),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Title:")),
                              Text("${snapshot.data["Title"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Year:")),
                              Text("${snapshot.data["Year"]}"),
                            ],
                          ),
                          /*Row(
                            children: <Widget>[
                              Expanded(child: Text("Rated:")),
                              Text("${snapshot.data["Rated"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Released:")),
                              Text("${snapshot.data["Released"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Runtime:")),
                              Text("${snapshot.data["Runtime"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Genre:")),
                              Text("${snapshot.data["Genre"]}"),
                            ],
                          ),*/
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Director:")),
                              Text("${snapshot.data["Director"]}"),
                            ],
                          ),
                          Text("Actors: ${snapshot.data["Actors"]}"),
                          Text("Plot: ${snapshot.data["Plot"]}"),
                          /*Row(
                            children: <Widget>[
                              Expanded(child: Text("Language:")),
                              Text("${snapshot.data["Language"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Country:")),
                              Text("${snapshot.data["Country"]}"),
                            ],
                          ),*/
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("IMDB Rating:")),
                              Text("${snapshot.data["imdbRating"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("IMDB Votes:")),
                              Text("${snapshot.data["imdbVotes"]}"),
                            ],
                          ),
                          /*Row(
                            children: <Widget>[
                              Expanded(child: Text("Production:")),
                              Text("${snapshot.data["Production"]}"),
                            ],
                          ),*/
                          FloatingActionButton(
                              onPressed: (){
                                MovieDAO().insert(movie: Movie(title: "${snapshot.data["Title"]}",
                                                              year:"${snapshot.data["Year"]}",
                                                              imdbid: "${snapshot.data["imdbID"]}",
                                                              type: "${snapshot.data["Type"]}",
                                                              poster: "${snapshot.data["Poster"]}"));
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("New Favorite Added"),
                                  ),
                                );
                              },
                              child: Icon(Icons.star),
                          ),
                        ]
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
              ),
            ),

          ],
      ),
    );
  }
}