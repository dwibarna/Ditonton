import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTopRatedTvShow(mockTvShowRepository);
  });

  final dummy = <TvShow>[];

  test('should get list of Tv Series from repository', () async {
    when(mockTvShowRepository.getTopRatedTvShows())
        .thenAnswer((_) async => Right(dummy));

    final result = await usecase.execute();
    expect(result, Right(dummy));
  });
}
