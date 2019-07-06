import 'dart:convert';

import 'package:http/http.dart' as http;

class ItemDetail {
  /*
   * Projeto da disciplina de Flutter - Faculdade Ibratec
   * Aluno: Felipe Janser
   * Matrícula: 2016206772
   */

  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String poster;
  final String imdbRating;
  final String imdbID;

  ItemDetail(
      {this.title,
        this.year,
        this.rated,
        this.released,
        this.runtime,
        this.genre,
        this.director,
        this.writer,
        this.actors,
        this.plot,
        this.poster,
        this.imdbRating,
        this.imdbID});

  factory ItemDetail.fromJson(Map<String, dynamic> json) {
    return ItemDetail(
        title: json["Title"],
        year: json["Year"],
        rated: "",
        released: "",
        runtime: "",
        genre: "",
        director: "",
        writer: "",
        actors: "",
        plot: "",
        poster: json["Poster"],
        imdbRating: "",
        imdbID: json["imdbID"]);
  }

  static Future<dynamic> retrieveData(String idmovie) async {
    //final response = await http.get("http://www.transparencia.gov.br/api-de-dados/bolsa-familia-por-municipio?mesAno=201812&codigoIbge=3518800&pagina=1");
    final response = await http.get("http://www.omdbapi.com/?apikey=b446ef61&i=$idmovie");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erro ao tentar recuperar dados.");
    }
  }
}