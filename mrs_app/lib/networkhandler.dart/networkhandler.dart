import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:mrs_app/model/MovieDataModel.dart';

class NetworkHandler {
  // http://127.0.0.1:5000/sendRecomendation?movie=Avatar
  // http://127.0.0.1:5000/getMovies

  // String baseurl = "http://10.0.2.2:80";
  // String baseurl = "http://127.0.0.1:5000";
  String baseurl = "http://127.0.0.1:5000";
// var url = Uri.parse('https://example.com/whatsit/create');
  // Future getMovies2() async {
  //   String uri = formater("/getMovies");
  //   final response = await http.get(uri);

  // }

  Future<List<MovieModel>> getMovies() async {
    final url = Uri.parse(formater("/getMovies"));
    print(url);
    http.Response response = await http.get(url);
    print("status: ${response.statusCode}");
    try {
      if (response.statusCode == 200) {
        int t = 25;
        var list = json.decode(response.body)['data'];
        List<MovieModel> movies = [];
        for (int m in list) {
          if (t == 0) break;
          --t;
          var movie = await fetchMoviesDetail(m);

          if (movie != Error()) movies.add(movie);
        }
        return movies;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        // return [];
      }
    } catch (e) {
      print(e);
    }
    return [];
    // throw Error();
  }

  Future<List<MovieModel>> getRecomendation(String movie) async {
    final url = Uri.parse(formater("/sendRecomendation?movie=$movie"));
    print(url);
    http.Response response = await http.get(url);
    print("status: ${response.statusCode}");
    try {
      if (response.statusCode == 200) {
         int t = 100;
        var list = json.decode(response.body)['data'];
        List<MovieModel> movies = [];
        for (int m in list) {
          if (t == 0) break;
          --t;
          var movie = await fetchMoviesDetail(m);

          if (movie != Error()) movies.add(movie);
        }
        return movies;
        // return response; //.body.toString();dataModels
      } else {
        print('Request failed with status: ${response.statusCode}.');
        // throw Error();
        return [];
      }
    } catch (e) {
      print(e);
      // throw Error();
      return [];
    }
  }

  Future<MovieModel> fetchMoviesDetail(int movie_id) async {
    var URI =
        "https://api.themoviedb.org/3/movie/${movie_id}?api_key=8265bd1679663a7ea12ac168da84d2e8&language=en-US";
    final url = Uri.parse(URI);
    print(url);
    http.Response response = await http.get(url);
    print("status: ${response.statusCode}");
    try {
      if (response.statusCode == 200) {
        // print(response.body);
        var data = json.decode(response.body);
        MovieModel val = MovieModel(
            movie_id: movie_id,
            movie_name: data['title'],
            movie_logo: data['poster_path']);
        return val; //.body.toString();
      } else {
        print('Request failed with status: ${response.statusCode}.');
        // throw Error();
      }
    } catch (e) {
      print(e);
      // return "failed";
    }
    // TODO: handle properly
    throw Error();
    // return Null;
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName) {
    String url = formater("/uploads//$imageName");
    return NetworkImage(url);
  }
}
