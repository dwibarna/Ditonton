import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_show.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/tv_show.dart';

class TopRatedTvShowsNotifier extends ChangeNotifier {
  final GetTopRatedTvShow getTopRatedTvShow;

  TopRatedTvShowsNotifier(this.getTopRatedTvShow);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvShow> _list = [];

  List<TvShow> get list => _list;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopularTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShow.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (data) {
      _list = data;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
