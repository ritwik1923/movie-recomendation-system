import 'package:freezed_annotation/freezed_annotation.dart';

part 'MovieDataModel.freezed.dart';
part 'MovieDataModel.g.dart';

@freezed
class MovieModel with _$MovieModel {
  factory MovieModel({
    required int movie_id,
    required String movie_name,
    required String movie_logo,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
