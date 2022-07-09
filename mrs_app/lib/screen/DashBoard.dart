import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../networkhandler.dart/networkhandler.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // this._getMovies();
  }
  late MovieListDataModel _movieChoose;
  int dropdownvalue = 0;
  List<MovieListDataModel> movieDataList = [];

  NetworkHandler nh = NetworkHandler();
  Future _getMovies() async {
    var list;
    final res = await nh.getMovies1().then((value) {
      list = json.decode(value.body)['data'];
      int t = 5;
      for (var movie in list) {
        if (t == 0) break;
        --t;
        nh.fetchMoviesDetail(movie).then((value) {
          var res = json.decode(value.body);
          movieDataList.add(
              MovieListDataModel(res['original_title'], res['poster_path']));
          // print("${res['original_title']}  ${res['poster_path']}");
        });
      }
      // for (var i in movieDataList) print(i.movie_logo);
    }).onError((error, stackTrace) {
      print(error);
      // list = [];
    });
    return movieDataList;
    // print("respp: $res");
    // setState(() {
    //   list = res;
    // });
    // return "done";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getMovies(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot projectSnap) {
          List<Widget> children;
          if (projectSnap.hasData) {
            var movies = projectSnap.data; // as List<String>?;
            print("movies list: ${movies?.length}");
            print("movies list: ${movies}");
            
            // dropdownvalue = movies[0];
            // var fetdata = nh.fetchMoviesDetail(movies[0]).then((value) {
            //   var res = json.decode(value.body);
            //   print(res);
            // });

            // for (String movie in movies)
            //   movieDataList.add(MovieListDataModel(movie,
            //       "https://www.kindpng.com/picc/m/83-837808_sbi-logo-state-bank-of-india-group-png.png"));
            // if (movies != Null)
            //   for (int movie = 0; movie < 5; ++movie) {
            //     print(movies![movie]);
            //   }
            // _movieChoose = movieDataList[0];
            return SingleChildScrollView(
              child: Column(

                children: <Widget>[
                  
                  ListView.builder(
                    itemCount: movieDataList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        // leading: Image.network("https://image.tmdb.org/t/p/w500/" + movieDataList[index].movie_logo),
                        title: Text(movieDataList[index].movie_logo),
                      );
                    },
                  )
                  
                  /*
                  DropdownButton(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: [0,1,2,3].map((int items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text("items $items"),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (int? Value) {
                      setState(() {
                        dropdownvalue = Value!;
                      });
                    },
                  ),
                  // ListView.builder(
                  //   itemBuilder: movies?.length,
                  // )
                  */
                  /*
                  Form(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 15, top: 10, right: 15),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(12, 10, 20, 20),
                                  // labelText: "hi",
                                  // labelStyle: textStyle,
                                  // labelText: _dropdownValue == null
                                  //     ? 'Where are you from'
                                  //     : 'From',
                                  errorText: "Wrong Choice",
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 16.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<MovieListDataModel>(
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontFamily: "verdana_regular",
                                  ),
                                  hint: Text(
                                    "Select movie",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: "verdana_regular",
                                    ),
                                  ),
                                  items: movieDataList.map<
                                          DropdownMenuItem<MovieListDataModel>>(
                                      (MovieListDataModel value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(value.movie_logo),
                                          ),
                                          // Icon(valueItem.movie_logo),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(value.movie_name),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  isExpanded: true,
                                  isDense: true,
                                  onChanged: (MovieListDataModel? value) {
                                    setState(() {
                                      _movieChoose = value!;
                                    });
                                  },
                                  value: _movieChoose,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
*/
                  // Widget to display the list of project
                ],
              ),
            );
          } else if (projectSnap.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error '), //${projectSnap.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovieListDataModel {
  String movie_name;
  String movie_logo;
  MovieListDataModel(this.movie_name, this.movie_logo);
}
