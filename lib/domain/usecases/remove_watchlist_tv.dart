import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class RemoveWatchlistTv {
  final TvShowRepository repository;

  RemoveWatchlistTv({required this.repository});

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeTvWatchList(tv);
  }
}