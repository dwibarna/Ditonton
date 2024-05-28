import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_search_tv_show.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/tv_show.dart';

class TvSearchNotifier extends ChangeNotifier {
  final GetSearchTvShow searchTvShow;

  TvSearchNotifier({required this.searchTvShow});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _list = [];
  List<TvShow> get list => _list;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShow.execute(query);
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
