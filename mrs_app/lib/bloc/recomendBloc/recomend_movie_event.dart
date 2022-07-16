part of 'recomend_movie_bloc.dart';

@immutable
abstract class RecomendMovieEvent {}


class LoadRecMovieEvent extends RecomendMovieEvent {
  final String recmovie;
  LoadRecMovieEvent({
    required this.recmovie,
  });
}
