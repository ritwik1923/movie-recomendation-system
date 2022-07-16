// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:mrs_app/model/MovieDataModel.dart';
import 'package:mrs_app/networkhandler.dart/networkhandler.dart';

part 'recmovie_event.dart';
part 'recmovie_state.dart';

class RecmovieBloc extends Bloc<RecmovieEvent, RecmovieState> {
  final NetworkHandler nh;
  // late String recmovie;
  RecmovieBloc(
    this.nh,
  ) : super(RecmovieInitialState()) {
    on<RecmovieEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is LoadMovieEvent) {
        print("event load");
        emit(MovieLoadingState());
        List<MovieModel> movies = await nh.getMovies();
        if (movies.isEmpty) {
          emit(MovieErrorState());
        } else {
          emit(MovieLoadedState(movies: movies));
        }
      } else if (event is LoadRecMovieEvent) {
        emit(RecMovieLoadingState());
        List<MovieModel> Recmovies = await nh.getRecomendation(event.recmovie);
        if (Recmovies.isEmpty)
          emit(RecMovieErrorState());
        else
          emit(RecMovieLoadedState(rec_movies: Recmovies));
      }
    });
  }
}
