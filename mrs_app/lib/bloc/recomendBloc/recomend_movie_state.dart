part of 'recomend_movie_bloc.dart';

@immutable
abstract class RecomendMovieState {}

class RecomendMovieInitialState extends RecomendMovieState {}


class RecMovieLoadingState extends RecomendMovieState {}

class RecMovieLoadedState extends RecomendMovieState {
  final List<MovieModel> rec_movies;
  RecMovieLoadedState({
    required this.rec_movies,
  });
}

class RecMovieErrorState extends RecomendMovieState {}
