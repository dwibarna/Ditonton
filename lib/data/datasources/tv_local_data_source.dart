import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_show_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTvSeries(TvShowTable tv);
  Future<String> removeWatchlistTvSeries(TvShowTable tv);
  Future<TvShowTable?> getTvShowById(int id);
  Future<List<TvShowTable>> getTvSeriesWatchlist();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvShowTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvShowTable>> getTvSeriesWatchlist() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((x) => TvShowTable.fromMap(x)).toList();
  }

  @override
  Future<String> insertWatchlistTvSeries(TvShowTable tv) async {
    try {
      await databaseHelper.insertTvWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTvSeries(TvShowTable tv) async {
    try {
      await databaseHelper.removeTvWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

}