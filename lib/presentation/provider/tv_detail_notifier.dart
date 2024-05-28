import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/tv_show.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  TvDetailNotifier({required this.getTvDetail, required this.getTvRecommendations});

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _list = [];
  List<TvShow> get list => _list;

  RequestState _recState = RequestState.Empty;
  RequestState get recState => _recState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesDetail(int id) async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    result.fold(
        (failure) {
          _state = RequestState.Error;
          _message = failure.message;
          notifyListeners();
        },
        (tvShow) {
          _recState = RequestState.Loading;
          _tvDetail = tvShow;
          notifyListeners();

          recommendationResult.fold(
              (failure) {
                _recState = RequestState.Error;
                _message = failure.message;
              },
              (tv) {
                _recState = RequestState.Loaded;
                _list = tv;
              }
          );

          _state = RequestState.Loaded;
          notifyListeners();
        }
    );
  }
}