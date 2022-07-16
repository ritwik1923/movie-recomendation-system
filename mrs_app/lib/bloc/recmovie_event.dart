// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recmovie_bloc.dart';

@immutable
abstract class RecmovieEvent {}

class LoadMovieEvent extends RecmovieEvent {}



class LoadRecMovieEvent extends RecmovieEvent {
  final String recmovie;
  LoadRecMovieEvent({
    required this.recmovie,
  });
}
