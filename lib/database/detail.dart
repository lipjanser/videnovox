import 'package:flutter/material.dart';
import 'movie.dart';
import 'movieDAO.dart';

class DetailPage extends StatefulWidget {
  Movie movie;

  DetailPage({this.movie});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController(text: widget.movie?.title);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
            ),
          ),
          RaisedButton(
            onPressed: () {
              if(widget.movie == null){
                widget.movie = Movie(title: _controller.text);
              }else{
                widget.movie.title = _controller.text;
              }
              MovieDAO().insert(movie: widget.movie);
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}