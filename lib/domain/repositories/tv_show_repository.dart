import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_show.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getNowAiringTvShows();
  Future<Either<Failure, List<TvShow>>> getPopularTvShows();
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();
  Future<Either<Failure, List<TvShow>>> getSearchTvShows(String query);
  Future<Either<Failure, List<TvShow>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, String>> addTvWatchList(TvDetail tv);
  Future<Either<Failure, String>> removeTvWatchList(TvDetail tv);
  Future<bool> isAddedTvToWatchList(int id);
  Future<Either<Failure, List<TvShow>>> getWatchlistTvSeries();

}