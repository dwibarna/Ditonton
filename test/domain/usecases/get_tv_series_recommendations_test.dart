import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvShowRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvShowRepository();
    usecase = GetTvRecommendations(mockTvSeriesRepository);
  });

  final dummyId = 31910;
  final dummy = <TvShow>[];

  test('should get list of Tv Series recommendations from the repository',
      () async {
    when(mockTvSeriesRepository.getTvSeriesRecommendations(dummyId))
        .thenAnswer((_) async => Right(dummy));

    final result = await usecase.execute(dummyId);

    expect(result, Right(dummy));
  });
}
