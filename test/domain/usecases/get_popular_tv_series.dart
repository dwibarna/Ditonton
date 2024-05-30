import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetPopularTvShow(mockTvShowRepository);
  });

  final dummy = <TvShow>[];

  group('Get Popular Tv Series Tests', () {
    group('execute', () {
      test(
          'should get list from the repository when execute function is called',
          () async {
        when(mockTvShowRepository.getPopularTvShows())
            .thenAnswer((_) async => Right(dummy));
        final result = await usecase.execute();

        expect(result, Right(dummy));
      });
    });
  });
}
