import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/tv_show.dart';
import '../../domain/usecases/get_watchlist_tv_state.dart';
import '../../domain/usecases/remove_watchlist_tv.dart';
import '../../domain/usecases/save_watchlist_tv.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchlistTvState getWatchlistStateTv;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.removeWatchlistTv,
    required this.saveWatchlistTv,
    required this.getWatchlistStateTv
  });

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

  bool _stateWatchlist = false;
  bool get stateWatchlist => _stateWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> removeTvWatchList(TvDetail tv) async {
    final result = await removeWatchlistTv.execute(tv);

    await result.fold(
        (failure) async {
          _watchlistMessage = failure.message;
        },
        (success) async {
          _watchlistMessage = success;
        }
    );

    await loadTvWatchListState(tv.id);
  }

  Future<void> addTvWatchList(TvDetail tv) async {
    final result = await saveWatchlistTv.execute(tv);

    await result.fold(
        (failure) async {
          _watchlistMessage = failure.message;
        },
        (success) async {
          _watchlistMessage = success;
        }
    );

    await loadTvWatchListState(tv.id);
  }

  Future<void> loadTvWatchListState(int id) async {
    final result = await getWatchlistStateTv.execute(id);
    _stateWatchlist = result;
    notifyListeners();
  }

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