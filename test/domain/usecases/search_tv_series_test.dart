import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_search_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSearchTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetSearchTvShow(mockTvShowRepository);
  });

  final dummy = <TvShow>[];
  final dummyQuery = 'naruto';

  test('should get list of tv series from the repository', () async {
    when(mockTvShowRepository.getSearchTvShows(dummyQuery))
        .thenAnswer((_) async => Right(dummy));

    final result = await usecase.execute(dummyQuery);

    expect(result, Right(dummy));
  });
}
