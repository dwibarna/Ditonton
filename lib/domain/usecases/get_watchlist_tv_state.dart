import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetWatchlistTvState {
  final TvShowRepository repository;

  GetWatchlistTvState({required this.repository});

  Future<bool> execute(int id) async {
    return repository.isAddedTvToWatchList(id);
  }
}