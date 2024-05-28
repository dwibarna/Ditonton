import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvRecommendations {
  final TvShowRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(int id) {
    return repository.getTvSeriesRecommendations(id);
  }
}