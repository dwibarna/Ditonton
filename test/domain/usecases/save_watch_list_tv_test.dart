import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SaveWatchlistTv(repository: mockTvShowRepository);
  });

  test('should save tv series to the repository', () async {
    when(mockTvShowRepository.addTvWatchList(testTvShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));

    final result = await usecase.execute(testTvShowDetail);

    verify(mockTvShowRepository.addTvWatchList(testTvShowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
