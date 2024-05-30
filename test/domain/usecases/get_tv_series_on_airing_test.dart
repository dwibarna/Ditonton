import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowAiringTvShow usecase;
  late MockTvShowRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvShowRepository();
    usecase = GetNowAiringTvShow(mockTvSeriesRepository);
  });

  final dummy = <TvShow>[];

  test('should get list of Tv Series from the repository', () async {
    when(mockTvSeriesRepository.getNowAiringTvShows())
        .thenAnswer((_) async => Right(dummy));

    final result = await usecase.execute();

    expect(result, Right(dummy));
  });
}
