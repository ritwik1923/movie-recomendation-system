import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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

  Future getMovies1() async {
    final url = Uri.parse(formater("/getMovies"));
    print(url);
    http.Response response = await http.get(url);
    print("status: ${response.statusCode}");
    try {
      if (response.statusCode == 200) {
        // print(response.body);
        return response; //.body.toString();
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Error();
        return "failed";
      }
    } catch (e) {
      print(e);
      throw Error();
      return "failed";
    }
  }

  Future fetchMoviesDetail(int movie_id) async {
    var URI =
        "https://api.themoviedb.org/3/movie/${movie_id}?api_key=8265bd1679663a7ea12ac168da84d2e8&language=en-US";
    final url = Uri.parse(URI);
    print(url);
    http.Response response = await http.get(url);
    print("status: ${response.statusCode}");
    try {
      if (response.statusCode == 200) {
        // print(response.body);
        return response; //.body.toString();
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Error();
        return "failed";
      }
    } catch (e) {
      print(e);
      throw Error();
      return "failed";
    }
  }

  Future getMovies() async {
    try {
      Dio dio = Dio();
      var url = formater("/getMovies");
      print(url);
      var response = await dio.get(url);
      print("res: ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      return ["baal"];
    }
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName) {
    String url = formater("/uploads//$imageName");
    return NetworkImage(url);
  }
}
