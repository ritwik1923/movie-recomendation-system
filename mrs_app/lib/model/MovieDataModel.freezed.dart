// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'MovieDataModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return _MovieModel.fromJson(json);
}

/// @nodoc
class _$MovieModelTearOff {
  const _$MovieModelTearOff();

  _MovieModel call(
      {required int movie_id,
      required String movie_name,
      required String movie_logo}) {
    return _MovieModel(
      movie_id: movie_id,
      movie_name: movie_name,
      movie_logo: movie_logo,
    );
  }

  MovieModel fromJson(Map<String, Object?> json) {
    return MovieModel.fromJson(json);
  }
}

/// @nodoc
const $MovieModel = _$MovieModelTearOff();

/// @nodoc
mixin _$MovieModel {
  int get movie_id => throw _privateConstructorUsedError;
  String get movie_name => throw _privateConstructorUsedError;
  String get movie_logo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieModelCopyWith<MovieModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieModelCopyWith<$Res> {
  factory $MovieModelCopyWith(
          MovieModel value, $Res Function(MovieModel) then) =
      _$MovieModelCopyWithImpl<$Res>;
  $Res call({int movie_id, String movie_name, String movie_logo});
}

/// @nodoc
class _$MovieModelCopyWithImpl<$Res> implements $MovieModelCopyWith<$Res> {
  _$MovieModelCopyWithImpl(this._value, this._then);

  final MovieModel _value;
  // ignore: unused_field
  final $Res Function(MovieModel) _then;

  @override
  $Res call({
    Object? movie_id = freezed,
    Object? movie_name = freezed,
    Object? movie_logo = freezed,
  }) {
    return _then(_value.copyWith(
      movie_id: movie_id == freezed
          ? _value.movie_id
          : movie_id // ignore: cast_nullable_to_non_nullable
              as int,
      movie_name: movie_name == freezed
          ? _value.movie_name
          : movie_name // ignore: cast_nullable_to_non_nullable
              as String,
      movie_logo: movie_logo == freezed
          ? _value.movie_logo
          : movie_logo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$MovieModelCopyWith<$Res> implements $MovieModelCopyWith<$Res> {
  factory _$MovieModelCopyWith(
          _MovieModel value, $Res Function(_MovieModel) then) =
      __$MovieModelCopyWithImpl<$Res>;
  @override
  $Res call({int movie_id, String movie_name, String movie_logo});
}

/// @nodoc
class __$MovieModelCopyWithImpl<$Res> extends _$MovieModelCopyWithImpl<$Res>
    implements _$MovieModelCopyWith<$Res> {
  __$MovieModelCopyWithImpl(
      _MovieModel _value, $Res Function(_MovieModel) _then)
      : super(_value, (v) => _then(v as _MovieModel));

  @override
  _MovieModel get _value => super._value as _MovieModel;

  @override
  $Res call({
    Object? movie_id = freezed,
    Object? movie_name = freezed,
    Object? movie_logo = freezed,
  }) {
    return _then(_MovieModel(
      movie_id: movie_id == freezed
          ? _value.movie_id
          : movie_id // ignore: cast_nullable_to_non_nullable
              as int,
      movie_name: movie_name == freezed
          ? _value.movie_name
          : movie_name // ignore: cast_nullable_to_non_nullable
              as String,
      movie_logo: movie_logo == freezed
          ? _value.movie_logo
          : movie_logo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MovieModel implements _MovieModel {
  _$_MovieModel(
      {required this.movie_id,
      required this.movie_name,
      required this.movie_logo});

  factory _$_MovieModel.fromJson(Map<String, dynamic> json) =>
      _$$_MovieModelFromJson(json);

  @override
  final int movie_id;
  @override
  final String movie_name;
  @override
  final String movie_logo;

  @override
  String toString() {
    return 'MovieModel(movie_id: $movie_id, movie_name: $movie_name, movie_logo: $movie_logo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MovieModel &&
            const DeepCollectionEquality().equals(other.movie_id, movie_id) &&
            const DeepCollectionEquality()
                .equals(other.movie_name, movie_name) &&
            const DeepCollectionEquality()
                .equals(other.movie_logo, movie_logo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(movie_id),
      const DeepCollectionEquality().hash(movie_name),
      const DeepCollectionEquality().hash(movie_logo));

  @JsonKey(ignore: true)
  @override
  _$MovieModelCopyWith<_MovieModel> get copyWith =>
      __$MovieModelCopyWithImpl<_MovieModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MovieModelToJson(this);
  }
}

abstract class _MovieModel implements MovieModel {
  factory _MovieModel(
      {required int movie_id,
      required String movie_name,
      required String movie_logo}) = _$_MovieModel;

  factory _MovieModel.fromJson(Map<String, dynamic> json) =
      _$_MovieModel.fromJson;

  @override
  int get movie_id;
  @override
  String get movie_name;
  @override
  String get movie_logo;
  @override
  @JsonKey(ignore: true)
  _$MovieModelCopyWith<_MovieModel> get copyWith =>
      throw _privateConstructorUsedError;
}
