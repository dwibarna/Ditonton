import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetSearchTvShow {
  final TvShowRepository repository;

  GetSearchTvShow(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(String query) {
    return repository.getSearchTvShows(query);
  }
}
