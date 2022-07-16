import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrs_app/bloc/recmovie_bloc.dart';
import 'package:mrs_app/bloc/recomendBloc/recomend_movie_bloc.dart';
import 'package:mrs_app/model/MovieDataModel.dart';
import 'package:mrs_app/screen/movie_detail.dart';

import '../networkhandler.dart/networkhandler.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    // future = this._getMovies();
    _currentSelectedValue = _currencies[0];
    ctrl.addListener(() {
      int pos = ctrl.page!.round();
      if (currentPage != pos) {
        {
          setState(() {
            currentPage = pos;
          });
        }
      }
    });
    // _movieChoose = movieDataList[0];
  }

  late MovieModel _movieChoose;
  late MovieModel dropdownvalue;
  List<MovieModel> movieDataList = [];
  final movieTextCtrl = TextEditingController();
  var _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];
  late String _currentSelectedValue;
  NetworkHandler nh = NetworkHandler();
  late Future<List<MovieModel>> future;
  late Future<List<MovieModel>> future1;
  final PageController ctrl = PageController(
    viewportFraction: 0.99,
  );

  @override
  Widget build(BuildContext context) {
    // if (movieDataList.isNotEmpty) _movieChoose = movieDataList[0];
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu_sharp),
            onPressed: () {},
          ),
          title: Container(
              // margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue[900],
              ),
              child: Text("MRS",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      height: 1.0,
                      fontSize: 24,
                      fontFamily: "Poppins"))),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),

                // SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  // color: Colors.pink,
                  child: PageView.builder(
                      controller: ctrl,
                      itemCount: 8,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, int index) {
                        // Active page
                        bool active = index == currentPage;
                        return _buildStoryPage();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Recomended Movie",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          height: 1.0, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "Poppins")),
                ),

                BlocBuilder<RecmovieBloc, RecmovieState>(
                  key: UniqueKey(),
                  builder: (context, state) {
                    print("i: ");
                    if (state is RecmovieInitialState) {
                      print("added loading");
                      context.read<RecmovieBloc>().add(LoadMovieEvent());
                      return Column(
                        children: [
                          const SizedBox(
                            width: 60,
                            height: 60,
                            child: const CircularProgressIndicator(),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...'),
                          )
                        ],
                      );
                      // return CircularProgressIndicator();
                    } else if (state is MovieLoadingState) {
                      print("loading");
                      return Column(
                        children: [
                          const SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...'),
                          )
                        ],
                      );
                    } else if (state is MovieLoadedState) {
                      print("loaded");
                      //,

                      print(state.movies);
                      // setState(() {
                      //   movieDataList = state.movies;
                      // });
                      // state.

                      return reWidget(state.movies);
                    } else if (state is MovieErrorState) {
                      return const Text("Error");
                    }
                    return const Text("Something went wrong");
                    // return Container();
                  },
                ),

             
                const SizedBox(
                  height: 10,
                ),
                // Expanded(child: Container(),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Made with ❤️",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          height: 1.0, fontSize: 10, fontFamily: "Poppins")),
                ),
              ],
            ),
          ),
        ));
  }

  _buildStoryPage() {
    List<Color> getColorsList = [
      Colors.blueAccent,
      Colors.blueAccent,
      Colors.blue,
      Colors.blue,
    ];

    bool active = true;
    print("active: $active");
    // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      // height: 100,
      curve: Curves.easeOutQuint,
      // TODO: COntraints not working properly
      constraints: BoxConstraints(minHeight: 500, minWidth: 750),
      // margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // color: Colors.blue,
        // gradient: LinearGradient(
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        //   // colors: getColorsList,
        //   tileMode: TileMode.clamp,
        // ),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage("https://image.tmdb.org/t/p/w500/" +
              "/p9fXIvNppK21fCHAEkznSZb8hnv.jpg"),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.,
                children: [
                  Image.network(
                    "https://image.tmdb.org/t/p/w500/" +
                        "/wxgD3fB5lQ2sGJLog0rvXW049Pf.jpg",
                    height: 200,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Movie Name",
                            // textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                height: 1.0,
                                fontSize: 24,
                                fontFamily: "Poppins")),
                        Text("Movie describtion",
                            // textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                height: 1.0,
                                fontSize: 14,
                                fontFamily: "Poppins")),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 30,
                // width: 30,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white.withOpacity(.2),
                  border: Border.all(color: Colors.white),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 30,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 30,
                // width: 30,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white.withOpacity(.2),
                  border: Border.all(color: Colors.white),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget reWidget(var movies) {
    _movieChoose = movies[0];
    return Wrap(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (MovieModel i in movies)
          GestureDetector(
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetail(
                          movie: i,
                        )),
              );
            }),
            child: Container(
              // width: 100,
              width: 100,
              margin: const EdgeInsets.all(5),
              // color: Colors.pink,
              child: Column(children: [
                Image.network(
                  "https://image.tmdb.org/t/p/w500/" + i.movie_logo,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                // Text("${i.movie_logo}"),
                Container(
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    child: Text("${i.movie_name}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            height: 1.0,
                            fontSize: 14,
                            fontFamily: "Poppins"))),
              ]),
            ),
          ),
      ],
    );
  }

// TODO: popback making error
  Widget recmovieswidget(var movies) {
    return Column(
      children: <Widget>[
/*
        Container(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (MovieModel i in movies)
                Container(
                  // width: 100,
                  width: 100,
                  margin: const EdgeInsets.all(5),
                  // color: Colors.pink,
                  child: Wrap(children: [
                    Image.network(
                      "https://image.tmdb.org/t/p/w500/" + i.movie_logo,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    // Text("${i.movie_logo}"),
                    Container(
                        padding: const EdgeInsets.all(5),
                        height: 50,
                        child: Text("${i.movie_name}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                height: 1.0,
                                fontSize: 14,
                                fontFamily: "Poppins"))),
                  ]),
                ),
            ],
          ),
        ),
        */

        // Widget to display the list of project
      ],
    );
  }

  Widget reUse(Key k) {
    return DropdownButton(
      // Initial Value
      value: _currentSelectedValue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: _currencies.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          _currentSelectedValue = newValue!;
        });
      },
    );
    return DropdownButton<String>(
      key: k,
      value: _currentSelectedValue,
      isDense: true,
      onChanged: (String? newValue) {
        setState(() {
          _currentSelectedValue = newValue!;
          print("Selected: ${_currentSelectedValue}");
          // state.didChange(newValue);
        });
      },
      items: _currencies.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
    return FormField<String>(
      key: k,
      initialValue: _currentSelectedValue,
      validator: (value) {
        print("value: $value");
      },
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              // labelStyle: textStyle,
              errorStyle:
                  const TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: 'Please select expense',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: _currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _currentSelectedValue,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  _currentSelectedValue = newValue!;
                  print("Selected: ${_currentSelectedValue}");
                  state.didChange(newValue);
                });
              },
              items: _currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

// class MovieModel {
//   int movie_id;
//   String movie_name;
//   String movie_logo;
//   MovieModel(this.movie_id, this.movie_name, this.movie_logo);
// }
