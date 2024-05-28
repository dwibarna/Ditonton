import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tv_show.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_show.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_show.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_show.dart';

class TvShowListNotifier extends ChangeNotifier {
  final GetNowAiringTvShow getNowAiringTvShow;
  final GetTopRatedTvShow getTopRatedTvShow;
  final GetPopularTvShow getPopularTvShow;

  TvShowListNotifier({required this.getNowAiringTvShow, required this.getTopRatedTvShow, required this.getPopularTvShow});

  var _nowAiringTvShows = <TvShow>[];
  List<TvShow> get nowAiringTvShows => _nowAiringTvShows;

  RequestState _nowAiringTvShowState = RequestState.Empty;
  RequestState get nowAiringTvShowState => _nowAiringTvShowState;

  var _topRatedTvShow = <TvShow>[];
  List<TvShow> get topRatedTvShow => _topRatedTvShow;

  RequestState _topRatedTvShowsState = RequestState.Empty;
  RequestState get topRatedTvShowsState => _topRatedTvShowsState;

  var _popularTvShows = <TvShow>[];
  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAiringTvShows() async {
    _nowAiringTvShowState = RequestState.Loading;
    notifyListeners();

    final result = await getNowAiringTvShow.execute();
    result.fold((failure) {
      _nowAiringTvShowState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _nowAiringTvShowState = RequestState.Loaded;
      _nowAiringTvShows = data;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShow.execute();
    result.fold((failure) {
      _topRatedTvShowsState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _topRatedTvShowsState = RequestState.Loaded;
      _topRatedTvShow = data;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShow.execute();
    result.fold((failure) {
      _popularTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _popularTvState = RequestState.Loaded;
      _popularTvShows = data;
      notifyListeners();
    });
  }
}
