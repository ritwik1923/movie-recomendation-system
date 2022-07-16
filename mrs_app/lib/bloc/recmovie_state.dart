// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recmovie_bloc.dart';

@immutable
abstract class RecmovieState {}

class RecmovieInitialState extends RecmovieState {}

class MovieLoadingState extends RecmovieState {}

class MovieLoadedState extends RecmovieState {
  final List<MovieModel> movies;
  MovieLoadedState({
    required this.movies,
  });
}

class MovieErrorState extends RecmovieState {}


class RecMovieLoadingState extends RecmovieState {}

class RecMovieLoadedState extends RecmovieState {
  final List<MovieModel> rec_movies;
  RecMovieLoadedState({
    required this.rec_movies,
  });
}

class RecMovieErrorState extends RecmovieState {}
