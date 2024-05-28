import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tv_show.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/tv_show.dart';

class OnAiringTvShowsNotifier extends ChangeNotifier {
  final GetNowAiringTvShow getNowAiringTvShow;

  OnAiringTvShowsNotifier(this.getNowAiringTvShow);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvShow> _list = [];

  List<TvShow> get list => _list;

  String _message = '';

  String get message => _message;

  Future<void> fetchOnAiringTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowAiringTvShow.execute();

    result.fold(
        (failure) {
          _message = failure.message;
          _state = RequestState.Error;
          notifyListeners();
        },
        (data) {
          _list = data;
          _state = RequestState.Loaded;
          notifyListeners();
        }
    );
  }
}