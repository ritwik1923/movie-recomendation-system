// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/MovieDataModel.dart';
import '../../networkhandler.dart/networkhandler.dart';

part 'recomend_movie_event.dart';
part 'recomend_movie_state.dart';

class RecomendMovieBloc extends Bloc<RecomendMovieEvent, RecomendMovieState> {
  final NetworkHandler nh;
  RecomendMovieBloc(
    this.nh,
  ) : super(RecomendMovieInitialState()) {
    on<RecomendMovieEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is LoadRecMovieEvent) {
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
