// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mrs_app/model/MovieDataModel.dart';

import '../bloc/recmovie_bloc.dart';

class MovieDetail extends StatefulWidget {
  MovieModel movie;
  MovieDetail({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    context
        .read<RecmovieBloc>()
        .add(LoadRecMovieEvent(recmovie: widget.movie.movie_name));

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // width: 100,
            width: 100,
            margin: const EdgeInsets.all(5),
            // color: Colors.pink,
            child: Column(children: [
              Image.network(
                "https://image.tmdb.org/t/p/w500/" + widget.movie.movie_logo,
                height: 200,
                fit: BoxFit.cover,
              ),
              // Text("${i.movie_logo}"),
              Container(
                  padding: const EdgeInsets.all(5),
                  height: 50,
                  child: Text("${widget.movie.movie_name}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          height: 1.0,
                          fontSize: 14,
                          fontFamily: "Poppins"))),
            ]),
          ),
          Text("Recomended",
              style: const TextStyle(
                  color: Colors.white,
                  height: 1.0,
                  fontSize: 30,
                  fontFamily: "Poppins")),
          BlocBuilder<RecmovieBloc, RecmovieState>(
            key: UniqueKey(),
            builder: (context, state) {
              print("rec: $state");
              if (state is RecmovieInitialState) {
                print("added loading");
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
              } else if (state is RecMovieLoadingState) {
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
              } else if (state is RecMovieLoadedState) {
                print("loaded");
                // print(state.movies);
                // setState(() {
                //   movieDataList = state.movies;
                // });
                // state.

                return reWidget(state.rec_movies);
              } else if (state is RecMovieErrorState) {
                return const Text("Error");
              }
              return const Text("Something went wrong");
              // return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget reWidget(var movies) {
    // _movieChoose = movies[0];
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
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
          ),
        ),
/*
        StatefulBuilder(builder: (context, setState) {
          return Form(
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 10, 20, 20),
                          // labelText: "hi",
                          // labelStyle: textStyle,
                          // labelText: _dropdownValue == null
                          //     ? 'Where are you from'
                          //     : 'From',
                          // errorText: "Wrong Choice",
                          // errorStyle: const TextStyle(
                          //     color: Colors.redAccent, fontSize: 16.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<MovieModel>(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            // fontFamily: "verdana_regular",
                          ),
                          hint: const Text(
                            "Select movie",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              // fontFamily: "verdana_regular",
                            ),
                          ),
                          items: movies.map<DropdownMenuItem<MovieModel>>(
                              (MovieModel value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://image.tmdb.org/t/p/w500/" +
                                            value.movie_logo),
                                  ),
                                  // Icon(valueItem.movie_logo),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(value.movie_name),
                                ],
                              ),
                            );
                          }).toList(),
                          isExpanded: true,
                          isDense: true,
                          onChanged: (MovieModel? value) {
                            setState(() {
                              _movieChoose = value!;
                              print("Selected: ${_movieChoose.movie_name}");
                              // state.didChange(_movieChoose.movie_name);
                              // state.recmovie =
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
          );
        }),
*/
        // Widget to display the list of project
      ],
    );
  }
}
