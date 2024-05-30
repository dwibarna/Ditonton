import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = RemoveWatchlistTv(repository: mockTvShowRepository);
  });

  test('should remove watchlist tv series from repository', () async {
    when(mockTvShowRepository.removeTvWatchList(testTvShowDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));

    final result = await usecase.execute(testTvShowDetail);

    verify(mockTvShowRepository.removeTvWatchList(testTvShowDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
